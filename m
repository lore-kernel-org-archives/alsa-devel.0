From: Juergen Kreileder <jk@blackdown.de>
Subject: Re: ioctl32 on ppc64
Date: Tue, 14 Sep 2004 17:11:37 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <871xh4q40m.fsf@blackdown.de>
References: <87fz5notfg.fsf@blackdown.de> <s5hoek9rv63.wl@alsa2.suse.de>
	<s5hfz5lrlv8.wl@alsa2.suse.de> <s5hu0u0x6qy.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hu0u0x6qy.wl@alsa2.suse.de> (Takashi Iwai's message of "Tue,
	14 Sep 2004 16:30:45 +0200")
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Takashi Iwai <tiwai@suse.de> writes:

> At Tue, 14 Sep 2004 16:00:43 +0200,
> I wrote:
>> Could you try the attached patch?
>> With the patch, mmapping of PCM status/control records is disabled
>> on 32bit mode.
>
> Sorry, it included a typo.
> The fixed patch is below.

Thanks, it works now!
I just had to make one small fix:

--- sound/core/ioctl32/pcm32.c.orig     2004-09-14 17:01:41.817995464 +0200
+++ sound/core/ioctl32/pcm32.c  2004-09-14 17:01:48.864989384 +0200
@@ -480,7 +480,7 @@ enum {
        SNDRV_PCM_IOCTL_READN_FRAMES32 = _IOR('A', 0x53, struct sndrv_xfern32),
        SNDRV_PCM_IOCTL_HW_REFINE_OLD32 = _IOWR('A', 0x10, struct sndrv_pcm_hw_params_old32),
        SNDRV_PCM_IOCTL_HW_PARAMS_OLD32 = _IOWR('A', 0x11, struct sndrv_pcm_hw_params_old32),
-       SNDRV_PCM_IOCTL_SYNC_PTR32 = _IOWR('A', 0x23, struct sndrv_pcm_sync_ptr),
+       SNDRV_PCM_IOCTL_SYNC_PTR32 = _IOWR('A', 0x23, struct sndrv_pcm_sync_ptr32),
 
 };
 
=

So rate conversion now works in the mixed 32-/64-bit environment.
dmix still doesn't work but that happens in pure 32-bit and 64-bit
environments too.


        Juergen

-- 
Juergen Kreileder, Blackdown Java-Linux Team
http://www.blackdown.org/java-linux/java2-status/


-------------------------------------------------------
This SF.Net email is sponsored by: thawte's Crypto Challenge Vl
Crack the code and win a Sony DCRHC40 MiniDV Digital Handycam
Camcorder. More prizes in the weekly Lunch Hour Challenge.
Sign up NOW http://ad.doubleclick.net/clk;10740251;10262165;m
