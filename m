From: Anton Worshevsky <gbdj@linux.spb.org>
Subject: Re: VIA8235 with ALC650
Date: Fri, 24 Jan 2003 14:45:57 +0300
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <18615.030124@linux.spb.org>
Reply-To: Anton Worshevsky <gbdj@linux.spb.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Dear Takashi Iwai,

Thursday, January 16, 2003, 12:21:42 PM, you wrote:

>> >  if someone has VIA8233, VIA8233A, VIA8233C or VIA8235 chipset, could
>> >  you help the testing of the new driver?
>> >  the new driver code is found at
>> >
>> >         http://www.alsa-project.org/~iwai/via82xx.c
>>
>> i has VIA8235 and ALC650 codec. After installing new driver from cvs from

>> >  the new driver can (hopefully) play multiple streams simultaneously on
>> >  VIA8233, VIA8233C and VIA8235, but NOT on VIA8233A.
>>
>> It's worked, but second stream plays only left channel.
>>
>> Almost all OSS application such as games (UT, tux-racer and other) now producing
>> cracking and skipping sound. Only XMMS OSS-plugin plays good. OSS-sound was good
>> with rc6.

TI> does the patch below change something?

There are no change in apps which played good before (all tested apps with
alsa output, mpg123 and xmms oss-plugin). In games sound with patch playing faster and
higher, but as i can hear with same bad quality. RC6 do not has such problems.

Any idea?

Can you explain me in which units we must calculate rate under mask 0xfffff in
next code ? Are there any special values for it (such as 0xfffff)?

        outl((runtime->format == SNDRV_PCM_FORMAT_S16_LE ? VIA8233_REG_TYPE_16BIT : 0) | /* format */
             (runtime->channels > 1 ? VIA8233_REG_TYPE_STEREO : 0) | /* stereo */
-            (0xffff * runtime->rate)/(48000/16) | /* rate */
+            // (0xffff * runtime->rate)/(48000/16) | /* rate */
+            0xfffff |
             0xff000000,    /* STOP index is never reached */
             port + VIA_REG_OFFSET_STOP_IDX);

Please point me to the documentation in which such questions are described.

8235 detected as via8233C by alsa. But my kernel 2.4.20 has correct pci ID for
via8235. May be this important.

I will try to help you with development, but i need appropriate documentation.

Anton Worshevsky




-------------------------------------------------------
This SF.NET email is sponsored by:
SourceForge Enterprise Edition + IBM + LinuxWorld = Something 2 See!
http://www.vasoftware.com
