From: Jean-Marc Valin <jean-marc.valin@usherbrooke.ca>
Subject: Re: Quality resampling code for libasound
Date: Tue, 20 Feb 2007 00:38:16 +1100
Message-ID: <45D9A848.9040803@usherbrooke.ca>
References: <45D92131.50601@usherbrooke.ca>	<s5hirdy72ue.wl%tiwai@suse.de>	<45D99DF7.90204@usherbrooke.ca>
	<s5hhcti70pa.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------080402050004070604070504"
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <s5hhcti70pa.wl%tiwai@suse.de>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------080402050004070604070504
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

>> What?? I hope you're joking here. It's one thing if you don't want my
>> code for a reason or another, but being happy to keep things as they are
>> currently is just insane. What libasound does is not resampling, it's
>> audio mutilation, plain and simple. It's not an audiophile thing we're
>> talking about. The aliasing is so bad people notice it even with speech
>> (which usually tolerates a lot of abuse) and think it's an application
>> bug (e.g. http://www.mail-archive.com/ekiga-list@gnome.org/msg01316.html
>> ). This is only getting worse as people get new machines with HDA-based
>> cards that only do 44.1/48 kHz, so it'll become even more embarrassing.
>> Do you expect most Linux users who use a soundcard to know that they
>> need a plugin to have their cards actually reproduce sounds properly?
> 
> Yes.  Of course, we can do eventually merge, but let's see the result
> at first.  I don't want to be a politician who promisses the vapor
> things.

As I said in my original post, I'm quite willing to help whoever is
interested in integrating this code in libasound -- but at this point,
I'm not planning on writing the plugin itself. Any taker?

> That's why I asked you kick off the patch first...

Patch attached. This is based on my (very little) understanding of the
sample conversion code, so it could also be just dead wrong.

	Jean-Marc

--------------080402050004070604070504
Content-Type: text/x-patch;
 name="plug_shift.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="plug_shift.patch"

--- plugin_ops.h.old	2006-12-08 01:10:28.000000000 +1100
+++ plugin_ops.h	2007-02-20 00:29:14.000000000 +1100
@@ -256,14 +256,14 @@
 conv_xxx1_009x: as_u32(dst) = sx24s((u_int32_t)(as_u8c(src) ^ 0x80) << 8); goto CONV_END;
 conv_xxx1_9000: as_u32(dst) = (u_int32_t)(as_u8c(src) ^ 0x80) << 24; goto CONV_END;
 conv_xxx1_0009: as_u32(dst) = (u_int32_t)(as_u8c(src) ^ 0x80); goto CONV_END;
-conv_xx12_xxx1: as_u8(dst) = as_u16c(src) >> 8; goto CONV_END;
+conv_xx12_xxx1: as_u8(dst) = as_u16c(src)+128 >> 8; goto CONV_END;
 conv_xx12_xx12: as_u16(dst) = as_u16c(src); goto CONV_END;
 conv_xx12_xx21: as_u16(dst) = bswap_16(as_u16c(src)); goto CONV_END;
 conv_xx12_x120: as_u32(dst) = sx24((u_int32_t)as_u16c(src) << 8); goto CONV_END;
 conv_xx12_021x: as_u32(dst) = sx24s((u_int32_t)bswap_16(as_u16c(src)) << 8); goto CONV_END;
 conv_xx12_1200: as_u32(dst) = (u_int32_t)as_u16c(src) << 16; goto CONV_END;
 conv_xx12_0021: as_u32(dst) = (u_int32_t)bswap_16(as_u16c(src)); goto CONV_END;
-conv_xx12_xxx9: as_u8(dst) = (as_u16c(src) >> 8) ^ 0x80; goto CONV_END;
+conv_xx12_xxx9: as_u8(dst) = (as_u16c(src)+128 >> 8) ^ 0x80; goto CONV_END;
 conv_xx12_xx92: as_u16(dst) = as_u16c(src) ^ 0x8000; goto CONV_END;
 conv_xx12_xx29: as_u16(dst) = bswap_16(as_u16c(src)) ^ 0x80; goto CONV_END;
 conv_xx12_x920: as_u32(dst) = sx24((u_int32_t)(as_u16c(src) ^ 0x8000) << 8); goto CONV_END;
@@ -282,57 +282,57 @@
 conv_xx12_01Ax: as_u32(dst) = sx24s((u_int32_t)(as_u16c(src) ^ 0x80) << 8); goto CONV_END;
 conv_xx12_A100: as_u32(dst) = (u_int32_t)bswap_16(as_u16c(src) ^ 0x80) << 16; goto CONV_END;
 conv_xx12_001A: as_u32(dst) = (u_int32_t)(as_u16c(src) ^ 0x80); goto CONV_END;
-conv_x123_xxx1: as_u8(dst) = as_u32c(src) >> 16; goto CONV_END;
-conv_x123_xx12: as_u16(dst) = as_u32c(src) >> 8; goto CONV_END;
-conv_x123_xx21: as_u16(dst) = bswap_16(as_u32c(src) >> 8); goto CONV_END;
+conv_x123_xxx1: as_u8(dst) = as_u32c(src)+32768 >> 16; goto CONV_END;
+conv_x123_xx12: as_u16(dst) = as_u32c(src)+128 >> 8; goto CONV_END;
+conv_x123_xx21: as_u16(dst) = bswap_16(as_u32c(src)+128 >> 8); goto CONV_END;
 conv_x123_x123: as_u32(dst) = sx24(as_u32c(src)); goto CONV_END;
 conv_x123_321x: as_u32(dst) = sx24s(bswap_32(as_u32c(src))); goto CONV_END;
 conv_x123_1230: as_u32(dst) = as_u32c(src) << 8; goto CONV_END;
-conv_x123_0321: as_u32(dst) = bswap_32(as_u32c(src)) >> 8; goto CONV_END;
-conv_x123_xxx9: as_u8(dst) = (as_u32c(src) >> 16) ^ 0x80; goto CONV_END;
-conv_x123_xx92: as_u16(dst) = (as_u32c(src) >> 8) ^ 0x8000; goto CONV_END;
-conv_x123_xx29: as_u16(dst) = bswap_16(as_u32c(src) >> 8) ^ 0x80; goto CONV_END;
+conv_x123_0321: as_u32(dst) = bswap_32(as_u32c(src))+128 >> 8; goto CONV_END;
+conv_x123_xxx9: as_u8(dst) = (as_u32c(src)+32768 >> 16) ^ 0x80; goto CONV_END;
+conv_x123_xx92: as_u16(dst) = (as_u32c(src)+128 >> 8) ^ 0x8000; goto CONV_END;
+conv_x123_xx29: as_u16(dst) = bswap_16(as_u32c(src)+128 >> 8) ^ 0x80; goto CONV_END;
 conv_x123_x923: as_u32(dst) = sx24(as_u32c(src) ^ 0x800000); goto CONV_END;
 conv_x123_329x: as_u32(dst) = sx24s(bswap_32(as_u32c(src)) ^ 0x8000); goto CONV_END;
 conv_x123_9230: as_u32(dst) = (as_u32c(src) ^ 0x800000) << 8; goto CONV_END;
-conv_x123_0329: as_u32(dst) = (bswap_32(as_u32c(src)) >> 8) ^ 0x80; goto CONV_END;
-conv_123x_xxx3: as_u8(dst) = (as_u32c(src) >> 8) & 0xff; goto CONV_END;
-conv_123x_xx32: as_u16(dst) = bswap_16(as_u32c(src) >> 8); goto CONV_END;
-conv_123x_xx23: as_u16(dst) = (as_u32c(src) >> 8) & 0xffff; goto CONV_END;
+conv_x123_0329: as_u32(dst) = (bswap_32(as_u32c(src))+128 >> 8) ^ 0x80; goto CONV_END;
+conv_123x_xxx3: as_u8(dst) = (as_u32c(src)+128 >> 8) & 0xff; goto CONV_END;
+conv_123x_xx32: as_u16(dst) = bswap_16(as_u32c(src)+128 >> 8); goto CONV_END;
+conv_123x_xx23: as_u16(dst) = (as_u32c(src)+128 >> 8) & 0xffff; goto CONV_END;
 conv_123x_x321: as_u32(dst) = sx24(bswap_32(as_u32c(src))); goto CONV_END;
 conv_123x_123x: as_u32(dst) = sx24s(as_u32c(src)); goto CONV_END;
 conv_123x_3210: as_u32(dst) = bswap_32(as_u32c(src)) << 8; goto CONV_END;
-conv_123x_0123: as_u32(dst) = as_u32c(src) >> 8; goto CONV_END;
-conv_123x_xxxB: as_u8(dst) = ((as_u32c(src) >> 8) & 0xff) ^ 0x80; goto CONV_END;
-conv_123x_xxB2: as_u16(dst) = bswap_16((as_u32c(src) >> 8) ^ 0x80); goto CONV_END;
-conv_123x_xx2B: as_u16(dst) = ((as_u32c(src) >> 8) & 0xffff) ^ 0x80; goto CONV_END;
+conv_123x_0123: as_u32(dst) = as_u32c(src)+128 >> 8; goto CONV_END;
+conv_123x_xxxB: as_u8(dst) = ((as_u32c(src)+128 >> 8) & 0xff) ^ 0x80; goto CONV_END;
+conv_123x_xxB2: as_u16(dst) = bswap_16((as_u32c(src)+128 >> 8) ^ 0x80); goto CONV_END;
+conv_123x_xx2B: as_u16(dst) = ((as_u32c(src)+128 >> 8) & 0xffff) ^ 0x80; goto CONV_END;
 conv_123x_xB21: as_u32(dst) = sx24(bswap_32(as_u32c(src)) ^ 0x800000); goto CONV_END;
 conv_123x_12Bx: as_u32(dst) = sx24s(as_u32c(src) ^ 0x8000); goto CONV_END;
 conv_123x_B210: as_u32(dst) = bswap_32(as_u32c(src) ^ 0x8000) << 8; goto CONV_END;
-conv_123x_012B: as_u32(dst) = (as_u32c(src) >> 8) ^ 0x80; goto CONV_END;
-conv_1234_xxx1: as_u8(dst) = as_u32c(src) >> 24; goto CONV_END;
-conv_1234_xx12: as_u16(dst) = as_u32c(src) >> 16; goto CONV_END;
-conv_1234_xx21: as_u16(dst) = bswap_16(as_u32c(src) >> 16); goto CONV_END;
-conv_1234_x123: as_u32(dst) = sx24(as_u32c(src) >> 8); goto CONV_END;
+conv_123x_012B: as_u32(dst) = (as_u32c(src)+128 >> 8) ^ 0x80; goto CONV_END;
+conv_1234_xxx1: as_u8(dst) = as_u32c(src)+8388608 >> 24; goto CONV_END;
+conv_1234_xx12: as_u16(dst) = as_u32c(src)+32768 >> 16; goto CONV_END;
+conv_1234_xx21: as_u16(dst) = bswap_16(as_u32c(src)+32768 >> 16); goto CONV_END;
+conv_1234_x123: as_u32(dst) = sx24(as_u32c(src)+128 >> 8); goto CONV_END;
 conv_1234_321x: as_u32(dst) = sx24s(bswap_32(as_u32c(src)) << 8); goto CONV_END;
 conv_1234_1234: as_u32(dst) = as_u32c(src); goto CONV_END;
 conv_1234_4321: as_u32(dst) = bswap_32(as_u32c(src)); goto CONV_END;
-conv_1234_xxx9: as_u8(dst) = (as_u32c(src) >> 24) ^ 0x80; goto CONV_END;
-conv_1234_xx92: as_u16(dst) = (as_u32c(src) >> 16) ^ 0x8000; goto CONV_END;
-conv_1234_xx29: as_u16(dst) = bswap_16(as_u32c(src) >> 16) ^ 0x80; goto CONV_END;
-conv_1234_x923: as_u32(dst) = sx24((as_u32c(src) >> 8) ^ 0x800000); goto CONV_END;
+conv_1234_xxx9: as_u8(dst) = (as_u32c(src)+8388608 >> 24) ^ 0x80; goto CONV_END;
+conv_1234_xx92: as_u16(dst) = (as_u32c(src)+32768 >> 16) ^ 0x8000; goto CONV_END;
+conv_1234_xx29: as_u16(dst) = bswap_16(as_u32c(src)+32768 >> 16) ^ 0x80; goto CONV_END;
+conv_1234_x923: as_u32(dst) = sx24((as_u32c(src)+128 >> 8) ^ 0x800000); goto CONV_END;
 conv_1234_329x: as_u32(dst) = sx24s((bswap_32(as_u32c(src)) ^ 0x80) << 8); goto CONV_END;
 conv_1234_9234: as_u32(dst) = as_u32c(src) ^ 0x80000000; goto CONV_END;
 conv_1234_4329: as_u32(dst) = bswap_32(as_u32c(src)) ^ 0x80; goto CONV_END;
 conv_1234_xxx4: as_u8(dst) = as_u32c(src) & 0xff; goto CONV_END;
 conv_1234_xx43: as_u16(dst) = bswap_16(as_u32c(src)); goto CONV_END;
 conv_1234_xx34: as_u16(dst) = as_u32c(src) & 0xffff; goto CONV_END;
-conv_1234_x432: as_u32(dst) = sx24(bswap_32(as_u32c(src)) >> 8); goto CONV_END;
+conv_1234_x432: as_u32(dst) = sx24(bswap_32(as_u32c(src))+128 >> 8); goto CONV_END;
 conv_1234_234x: as_u32(dst) = sx24s(as_u32c(src) << 8); goto CONV_END;
 conv_1234_xxxC: as_u8(dst) = (as_u32c(src) & 0xff) ^ 0x80; goto CONV_END;
 conv_1234_xxC3: as_u16(dst) = bswap_16(as_u32c(src) ^ 0x80); goto CONV_END;
 conv_1234_xx3C: as_u16(dst) = (as_u32c(src) & 0xffff) ^ 0x80; goto CONV_END;
-conv_1234_xC32: as_u32(dst) = sx24((bswap_32(as_u32c(src)) >> 8) ^ 0x800000); goto CONV_END;
+conv_1234_xC32: as_u32(dst) = sx24((bswap_32(as_u32c(src))+128 >> 8) ^ 0x800000); goto CONV_END;
 conv_1234_23Cx: as_u32(dst) = sx24s((as_u32c(src) ^ 0x80) << 8); goto CONV_END;
 conv_1234_C321: as_u32(dst) = bswap_32(as_u32c(src) ^ 0x80); goto CONV_END;
 conv_1234_123C: as_u32(dst) = as_u32c(src) ^ 0x80; goto CONV_END;
@@ -382,26 +382,26 @@
 get16_12_92: sample = as_u16c(src) ^ 0x8000; goto GET16_END;
 get16_12_21: sample = bswap_16(as_u16c(src)); goto GET16_END;
 get16_12_A1: sample = bswap_16(as_u16c(src) ^ 0x80); goto GET16_END;
-get16_0123_12: sample = as_u32c(src) >> 8; goto GET16_END;
-get16_0123_92: sample = (as_u32c(src) >> 8) ^ 0x8000; goto GET16_END;
-get16_1230_32: sample = bswap_16(as_u32c(src) >> 8); goto GET16_END;
-get16_1230_B2: sample = bswap_16((as_u32c(src) >> 8) ^ 0x80); goto GET16_END;
-get16_1234_12: sample = as_u32c(src) >> 16; goto GET16_END;
-get16_1234_92: sample = (as_u32c(src) >> 16) ^ 0x8000; goto GET16_END;
+get16_0123_12: sample = as_u32c(src)+128 >> 8; goto GET16_END;
+get16_0123_92: sample = (as_u32c(src)+128 >> 8) ^ 0x8000; goto GET16_END;
+get16_1230_32: sample = bswap_16(as_u32c(src)+128 >> 8); goto GET16_END;
+get16_1230_B2: sample = bswap_16((as_u32c(src)+128 >> 8) ^ 0x80); goto GET16_END;
+get16_1234_12: sample = as_u32c(src)+32768 >> 16; goto GET16_END;
+get16_1234_92: sample = (as_u32c(src)+32768 >> 16) ^ 0x8000; goto GET16_END;
 get16_1234_43: sample = bswap_16(as_u32c(src)); goto GET16_END;
 get16_1234_C3: sample = bswap_16(as_u32c(src) ^ 0x80); goto GET16_END;
-get16_123_12: sample = _get_triple(src) >> 8; goto GET16_END;
-get16_123_92: sample = (_get_triple(src) >> 8) ^ 0x8000; goto GET16_END;
-get16_123_32: sample = _get_triple_s(src) >> 8; goto GET16_END;
-get16_123_B2: sample = (_get_triple_s(src) >> 8) ^ 0x8000; goto GET16_END;
-get16_123_12_20: sample = _get_triple(src) >> 4; goto GET16_END;
-get16_123_92_20: sample = (_get_triple(src) >> 4) ^ 0x8000; goto GET16_END;
-get16_123_32_20: sample = _get_triple_s(src) >> 4; goto GET16_END;
-get16_123_B2_20: sample = (_get_triple_s(src) >> 4) ^ 0x8000; goto GET16_END;
-get16_123_12_18: sample = _get_triple(src) >> 2; goto GET16_END;
-get16_123_92_18: sample = (_get_triple(src) >> 2) ^ 0x8000; goto GET16_END;
-get16_123_32_18: sample = _get_triple_s(src) >> 2; goto GET16_END;
-get16_123_B2_18: sample = (_get_triple_s(src) >> 2) ^ 0x8000; goto GET16_END;
+get16_123_12: sample = _get_triple(src)+128 >> 8; goto GET16_END;
+get16_123_92: sample = (_get_triple(src)+128 >> 8) ^ 0x8000; goto GET16_END;
+get16_123_32: sample = _get_triple_s(src)+128 >> 8; goto GET16_END;
+get16_123_B2: sample = (_get_triple_s(src)+128 >> 8) ^ 0x8000; goto GET16_END;
+get16_123_12_20: sample = _get_triple(src)+8 >> 4; goto GET16_END;
+get16_123_92_20: sample = (_get_triple(src)+8 >> 4) ^ 0x8000; goto GET16_END;
+get16_123_32_20: sample = _get_triple_s(src)+8 >> 4; goto GET16_END;
+get16_123_B2_20: sample = (_get_triple_s(src)+8 >> 4) ^ 0x8000; goto GET16_END;
+get16_123_12_18: sample = _get_triple(src)+2 >> 2; goto GET16_END;
+get16_123_92_18: sample = (_get_triple(src)+2 >> 2) ^ 0x8000; goto GET16_END;
+get16_123_32_18: sample = _get_triple_s(src)+2 >> 2; goto GET16_END;
+get16_123_B2_18: sample = (_get_triple_s(src)+2 >> 2) ^ 0x8000; goto GET16_END;
 }
 #endif
 
@@ -429,8 +429,8 @@
 
 #ifdef PUT16_END
 while (0) {
-put16_12_1: as_u8(dst) = sample >> 8; goto PUT16_END;
-put16_12_9: as_u8(dst) = (sample >> 8) ^ 0x80; goto PUT16_END;
+put16_12_1: as_u8(dst) = sample+128 >> 8; goto PUT16_END;
+put16_12_9: as_u8(dst) = (sample+128 >> 8) ^ 0x80; goto PUT16_END;
 put16_12_12: as_u16(dst) = sample; goto PUT16_END;
 put16_12_92: as_u16(dst) = sample ^ 0x8000; goto PUT16_END;
 put16_12_21: as_u16(dst) = bswap_16(sample); goto PUT16_END;
@@ -500,8 +500,8 @@
 get32_12_A100: sample = (u_int32_t)bswap_16(as_u16c(src) ^ 0x80) << 16; goto GET32_END;
 get32_0123_1230: sample = as_u32c(src) << 8; goto GET32_END;
 get32_0123_9230: sample = (as_u32c(src) << 8) ^ 0x80000000; goto GET32_END;
-get32_1230_3210: sample = bswap_32(as_u32c(src) >> 8); goto GET32_END;
-get32_1230_B210: sample = bswap_32((as_u32c(src) >> 8) ^ 0x80); goto GET32_END;
+get32_1230_3210: sample = bswap_32(as_u32c(src)+128 >> 8); goto GET32_END;
+get32_1230_B210: sample = bswap_32((as_u32c(src)+128 >> 8) ^ 0x80); goto GET32_END;
 get32_1234_1234: sample = as_u32c(src); goto GET32_END;
 get32_1234_9234: sample = as_u32c(src) ^ 0x80000000; goto GET32_END;
 get32_1234_4321: sample = bswap_32(as_u32c(src)); goto GET32_END;
@@ -568,32 +568,32 @@
 
 #ifdef PUT32_END
 while (0) {
-put32_1234_1: as_u8(dst) = sample >> 24; goto PUT32_END;
-put32_1234_9: as_u8(dst) = (sample >> 24) ^ 0x80; goto PUT32_END;
-put32_1234_12: as_u16(dst) = sample >> 16; goto PUT32_END;
-put32_1234_92: as_u16(dst) = (sample >> 16) ^ 0x8000; goto PUT32_END;
-put32_1234_21: as_u16(dst) = bswap_16(sample >> 16); goto PUT32_END;
-put32_1234_29: as_u16(dst) = bswap_16(sample >> 16) ^ 0x80; goto PUT32_END;
-put32_1234_0123: as_u32(dst) = sx24(sample >> 8); goto PUT32_END;
-put32_1234_0923: as_u32(dst) = sx24((sample >> 8) ^ 0x800000); goto PUT32_END;
+put32_1234_1: as_u8(dst) = sample+8388608 >> 24; goto PUT32_END;
+put32_1234_9: as_u8(dst) = (sample+8388608 >> 24) ^ 0x80; goto PUT32_END;
+put32_1234_12: as_u16(dst) = sample+32768 >> 16; goto PUT32_END;
+put32_1234_92: as_u16(dst) = (sample+32768 >> 16) ^ 0x8000; goto PUT32_END;
+put32_1234_21: as_u16(dst) = bswap_16(sample+32768 >> 16); goto PUT32_END;
+put32_1234_29: as_u16(dst) = bswap_16(sample+32768 >> 16) ^ 0x80; goto PUT32_END;
+put32_1234_0123: as_u32(dst) = sx24(sample+128 >> 8); goto PUT32_END;
+put32_1234_0923: as_u32(dst) = sx24((sample+128 >> 8) ^ 0x800000); goto PUT32_END;
 put32_1234_3210: as_u32(dst) = sx24s(bswap_32(sample) << 8); goto PUT32_END;
 put32_1234_3290: as_u32(dst) = sx24s((bswap_32(sample) ^ 0x80) << 8); goto PUT32_END;
 put32_1234_1234: as_u32(dst) = sample; goto PUT32_END;
 put32_1234_9234: as_u32(dst) = sample ^ 0x80000000; goto PUT32_END;
 put32_1234_4321: as_u32(dst) = bswap_32(sample); goto PUT32_END;
 put32_1234_4329: as_u32(dst) = bswap_32(sample) ^ 0x80; goto PUT32_END;
-put32_1234_123: _put_triple(dst, sample >> 8); goto PUT32_END;
-put32_1234_923: _put_triple(dst, (sample ^ 0x80000000) >> 8); goto PUT32_END;
-put32_1234_321: _put_triple_s(dst, sample >> 8); goto PUT32_END;
-put32_1234_329: _put_triple_s(dst, (sample ^ 0x80000000) >> 8); goto PUT32_END;
-put32_1234_123_20: _put_triple(dst, sample >> 12); goto PUT32_END;
-put32_1234_923_20: _put_triple(dst, (sample ^ 0x80000000) >> 12); goto PUT32_END;
-put32_1234_321_20: _put_triple_s(dst, sample >> 12); goto PUT32_END;
-put32_1234_329_20: _put_triple_s(dst, (sample ^ 0x80000000) >> 12); goto PUT32_END;
-put32_1234_123_18: _put_triple(dst, sample >> 14); goto PUT32_END;
-put32_1234_923_18: _put_triple(dst, (sample ^ 0x80000000) >> 14); goto PUT32_END;
-put32_1234_321_18: _put_triple_s(dst, sample >> 14); goto PUT32_END;
-put32_1234_329_18: _put_triple_s(dst, (sample ^ 0x80000000) >> 14); goto PUT32_END;
+put32_1234_123: _put_triple(dst, sample+128 >> 8); goto PUT32_END;
+put32_1234_923: _put_triple(dst, (sample ^ 0x80000000)+128 >> 8); goto PUT32_END;
+put32_1234_321: _put_triple_s(dst, sample+128 >> 8); goto PUT32_END;
+put32_1234_329: _put_triple_s(dst, (sample ^ 0x80000000)+128 >> 8); goto PUT32_END;
+put32_1234_123_20: _put_triple(dst, sample+2048 >> 12); goto PUT32_END;
+put32_1234_923_20: _put_triple(dst, (sample ^ 0x80000000)+2048 >> 12); goto PUT32_END;
+put32_1234_321_20: _put_triple_s(dst, sample+2048 >> 12); goto PUT32_END;
+put32_1234_329_20: _put_triple_s(dst, (sample ^ 0x80000000)+2048 >> 12); goto PUT32_END;
+put32_1234_123_18: _put_triple(dst, sample+8192 >> 14); goto PUT32_END;
+put32_1234_923_18: _put_triple(dst, (sample ^ 0x80000000)+8192 >> 14); goto PUT32_END;
+put32_1234_321_18: _put_triple_s(dst, sample+8192 >> 14); goto PUT32_END;
+put32_1234_329_18: _put_triple_s(dst, (sample ^ 0x80000000)+8192 >> 14); goto PUT32_END;
 }
 #endif
 

--------------080402050004070604070504
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--------------080402050004070604070504
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

--------------080402050004070604070504--
