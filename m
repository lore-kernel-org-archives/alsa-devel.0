From: thomas schorpp <t.schorpp@gmx.de>
Subject: [ALSA - driver 0000925]: no sound with CMI9761A, Cus fix verified
 OK
Date: Tue, 22 Feb 2005 21:26:14 +0100
Message-ID: <421B9566.7040806@gmx.de>
Reply-To: t.schorpp@gmx.de
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

post it here, cant get on bugtracker:

this is ok with:

-pcm playback
-pcm capture
-looped through lines

thx, cus.

  Additional Information  	 After some testing i found that the 
following patch fixes the problem:

--- ac97_patch.c.orig 2005-02-18 00:08:01.000000000 +0100
+++ ac97_patch.c 2005-02-19 18:08:23.000000000 +0100
@@ -2010,7 +2010,7 @@
          ac97->ext_id |= AC97_EI_SPDIF;
         /* to be sure: we overwrite the ext status bits */
         snd_ac97_write_cache(ac97, AC97_EXTENDED_STATUS, 0x05c0);
- snd_ac97_write_cache(ac97, AC97_CM9761_SPDIF_CTRL, 0x0209);
+ snd_ac97_write_cache(ac97, AC97_CM9761_SPDIF_CTRL, 0x0009);
         ac97->rates[AC97_RATES_SPDIF] = SNDRV_PCM_RATE_48000; /* 48k 
only */

         /* set-up multi channel */


I don't know why it works, and what that 0x0200 bit means in that 
register, someone may explain.

Cus

outstanding : Maybe better to use 0x0001 instead? I guess 0x0008 
controls the "IEC958 Capture Monitor", and got some reports that this 
disturbs the output. tashaki.

-no, now it disturbs no more.

all fine, thx.

add.:

with this you get master vol slider back:


	/* CM9761 has no Master and PCM volume although the register reacts */
	ac97->flags |= /*AC97_HAS_NO_MASTER_VOL |*/ AC97_HAS_NO_PCM_VOL;

@takashi: maybe this was tested only with pcm not with looped through 
lines, before. i assume false negatives from previous tests.


tom



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
