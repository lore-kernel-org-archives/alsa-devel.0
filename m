From: Jonas Petersen <jnsptrsn1@gmail.com>
Subject: Re: M-Audio Audiophile 192 (ice1724)'s broken spdif
 capture
Date: Thu, 31 Jan 2013 01:29:15 +0100
Message-ID: <5109BADB.30403@gmail.com>
References: <CAF+J8LeejgAx6vs0Ee8svWpmGYyk3-7SK+mE1ev-bWXYy-7v6Q@mail.gmail.com>
 <51042EE5.5070900@perex.cz>
 <7adcf466397b198e2e079e35b47686bc.squirrel@mail.insite.cz>
 <CAF+J8LduUEPqaguteL0oyiACXa4jVXGTVVTCm4Tw=jMxRTmLWA@mail.gmail.com>
 <510670CC.2090904@ivitera.com> <5107188F.3060001@gmail.com>
 <510798CC.3080006@ivitera.com> <51081FA7.70907@gmail.com>
 <5108F541.3010300@ivitera.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------000108020802000509030808"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bk0-f54.google.com (mail-bk0-f54.google.com
 [209.85.214.54])
 by alsa0.perex.cz (Postfix) with ESMTP id 715CE265115
 for <alsa-devel@alsa-project.org>; Thu, 31 Jan 2013 01:29:18 +0100 (CET)
Received: by mail-bk0-f54.google.com with SMTP id w5so1090243bku.41
 for <alsa-devel@alsa-project.org>; Wed, 30 Jan 2013 16:29:18 -0800 (PST)
In-Reply-To: <5108F541.3010300@ivitera.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Pavel Hofman <pavel.hofman@ivitera.com>
Cc: alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------000108020802000509030808
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Am 30.01.2013 11:26, schrieb Pavel Hofman:
> On 29.1.2013 20:14, Jonas Petersen wrote:
>> Am 29.01.2013 10:39, schrieb Pavel Hofman:
>>
>> I did that with no success. Same behaviour, no change, still no ak4114.
>> The only difference I got was:
>>
>> $ diff ~/Audiophile192-proc-a.txt ~/Audiophile192-proc-b.txt
>> 90c90
>> <   MT05     : 0x08
>> ---
>>>    MT05     : 0x00
>> I printk'ed a message in ap192_ak4114_init() and it's definitely being
>> called.
>>
> I see, ak4114 support in revo.c is incomplete. ak4114 controls incl. the
> proc file are never built. Please try the following patch (applicable to
> clean git checkout):
>

Pavel, I applied your patch (including the correction in the other 
post). It did not work out of the box. I had to do a lot of debugging 
and changes to it to make it compile and then more of that fun to make 
it not crash alsa. One of the problems was that ice->spec is initialized 
in revo51_i2c_init(), but it is never called with the ap192. So I copied 
the initialization to ap192_ak4114_init(). I'll attach a patch of my 
final version.

When it finally compiled and was running, I had an ak4114 file in proc.

Unfortunately it's full of 0x00's:

/proc/asound/Audiophile192/ak4114:

0x00 = 0x00
0x02 = 0x00
[...]
0x1e = 0x00
0x1f = 0x00

(32 lines total)

There is also no change in the spdif capture behaviour.

Btw. before all of that it took me already some time to make the patch 
working. Pasting patches in the mail body converts tabs to spaces and 
also breaks long lines. I can use -l but still it messes up the original 
content. Is it bad to attach .patch files to mails in this list?

Ok, now I need some help regarding the git sources. I applied all this 
to my alsa-driver source that I got from here:

ftp://ftp.suse.com/pub/people/tiwai/snapshot/alsa-driver-snapshot.tar.gz

This is so far the only source that I was able to compile. The 1.0.25 
release source won't compile with my ubuntu 12.10 (symbol errors). The 
alsa-compile.sh from 
http://www.alsa-project.org/main/index.php/Driver_Compilation will also 
complain about some missing stuff. The git stuff was confusing me a bit. 
Do I need alsa-kernel or alsa-driver? Or both? The alsa-driver (branch 
'release') complains about missing alsa-kernel. But alsa-kernel is a 
huge package. Is that really necessary?

This snapshot package has some nice ./configure and will make and make 
install against the ubuntu kernel-headers quite smoothly. So I was using 
this all the time.

How do I create (or get) a package that compiles against the 
kernel-headers from my distribution?

- Jonas

--------------000108020802000509030808
Content-Type: text/x-patch;
 name="ap192-ak4114-2013-01-30.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="ap192-ak4114-2013-01-30.patch"

diff --git a/sound/pci/ice1712/revo.c.orig b/sound/pci/ice1712/revo.c
index 7641080..13aab89 100644
--- a/sound/pci/ice1712/revo.c.orig
+++ b/sound/pci/ice1712/revo.c
@@ -35,6 +35,7 @@
 struct revo51_spec {
 	struct snd_i2c_device *dev;
 	struct snd_pt2258 *pt2258;
+	struct ak4114 *ak4114;
 };
 
 static void revo_i2s_mclk_changed(struct snd_ice1712 *ice)
@@ -480,17 +481,23 @@ static int ap192_ak4114_init(struct snd_ice1712 *ice)
 	static const unsigned char ak4114_init_txcsb[] = {
 		0x41, 0x02, 0x2c, 0x00, 0x00
 	};
-	struct ak4114 *ak;
 	int err;
 
+	struct revo51_spec* spec;
+	spec = kzalloc(sizeof(*spec), GFP_KERNEL);
+	if (!spec)
+		return -ENOMEM;
+	ice->spec = spec;
+
+
 	err = snd_ak4114_create(ice->card,
 				 ap192_ak4114_read,
 				 ap192_ak4114_write,
 				 ak4114_init_vals, ak4114_init_txcsb,
-				 ice, &ak);
+				 ice, &spec->ak4114);
 	/* AK4114 in Revo cannot detect external rate correctly.
 	 * No reason to stop capture stream due to incorrect checks */
-	ak->check_flags = AK4114_CHECK_NO_RATE;
+	spec->ak4114->check_flags = AK4114_CHECK_NO_RATE;
 
 	return 0; /* error ignored; it's no fatal error */
 }
@@ -562,6 +569,9 @@ static int revo_init(struct snd_ice1712 *ice)
 					       ice);
 		if (err < 0)
 			return err;
+		err = ap192_ak4114_init(ice);
+		if (err < 0)
+			return err;
 		
 		/* unmute all codecs */
 		snd_ice1712_gpio_write_bits(ice, VT1724_REVO_MUTE,
@@ -575,7 +585,7 @@ static int revo_init(struct snd_ice1712 *ice)
 
 static int revo_add_controls(struct snd_ice1712 *ice)
 {
-	struct revo51_spec *spec;
+	struct revo51_spec *spec = ice->spec;
 	int err;
 
 	switch (ice->eeprom.subvendor) {
@@ -597,7 +607,9 @@ static int revo_add_controls(struct snd_ice1712 *ice)
 		err = snd_ice1712_akm4xxx_build_controls(ice);
 		if (err < 0)
 			return err;
-		err = ap192_ak4114_init(ice);
+		/* only capture SPDIF over AK4114 */
+		err = snd_ak4114_build(spec->ak4114, NULL,
+		   ice->pcm->streams[SNDRV_PCM_STREAM_CAPTURE].substream);
 		if (err < 0)
 			return err;
 		break;

--------------000108020802000509030808
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--------------000108020802000509030808--
