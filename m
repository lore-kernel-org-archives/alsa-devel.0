From: Adrian Bunk <bunk@stusta.de>
Subject: 2.6.10-mm1: ALSA ac97 compile error with CONFIG_PM=n
Date: Tue, 4 Jan 2005 01:11:30 +0100
Message-ID: <20050104001130.GT2980@stusta.de>
References: <OF0551C40F.E8032010-ON86256F7E.007EFEBA-86256F7E.007EFF1F@raytheon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mailout.stusta.mhn.de (mailout.stusta.mhn.de [141.84.69.5])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with SMTP id 6EFAD239
	for <alsa-devel@alsa-project.org>; Tue,  4 Jan 2005 01:11:31 +0100 (MET)
Content-Disposition: inline
In-Reply-To: <OF0551C40F.E8032010-ON86256F7E.007EFEBA-86256F7E.007EFF1F@raytheon.com>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Mark_H_Johnson@raytheon.com
Cc: Andrew Morton <akpm@osdl.org>, lkml <linux-kernel@vger.kernel.org>, perex@suse.cz, Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Mon, Jan 03, 2005 at 05:07:08PM -0600, Mark_H_Johnson@raytheon.com wrote:
> I was looking to compare RT latency between this kernel and the latest from
> Ingo and I had the following warnings / errors building 2.6.10-mm1:
> 
> [no apparent compile / link errors]
> *** Warning: "snd_ac97_restore_iec958" [sound/pci/ac97/snd-ac97-codec.ko]
> undefined!
> *** Warning: "snd_ac97_restore_status" [sound/pci/ac97/snd-ac97-codec.ko]
> undefined!
>...
> To fix this, should I just add the EXPORT_SYMBOL lines for these symbols
>   snd_ac97_restore_status  snd_ac97_restore_iec958
> or is something more needed?

That's not the problem, since function and definition are in the same 
module.

You didn't send your .config, but looking at the code it seems 
CONFIG_PM=n was the culprit.

As a workaround, it should work after enabling the following option:
  Power management options (ACPI, APM)
    Power Management support

This is only a workaround, I've Cc'ed the ALSA maintainers for a real 
fix.

> Thanks.
>   --Mark Johnson <mailto:Mark_H_Johnson@Raytheon.com>

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed



-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
