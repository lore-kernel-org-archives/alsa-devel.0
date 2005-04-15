From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: GPL Violation in Aldi PC Medion MD95500
Date: Fri, 15 Apr 2005 18:50:27 +0200 (METDST)
Message-ID: <Pine.HPX.4.33n.0504151831520.8806-100000@studcom.urz.uni-halle.de>
References: <Pine.LNX.4.58.0504101821320.12537@tigger.tange.dk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.58.0504101821320.12537@tigger.tange.dk>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: legal@lists.gpl-violations.org
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Ole Tange wrote:
> I just bought Aldi PC Medion MD95500. It comes with a neat system for
> playing DVDs without starting Microsoft Windows. It boots a small Linux
> system for this. The manual does not contain GPL. None of the unwrapped
> CDs contain GPL.
> ...
> ./image-mnt/lib/modules/snd-seq-device.ko
> ./image-mnt/lib/modules/snd-pcm.ko
> ./image-mnt/lib/modules/snd.ko
> ./image-mnt/lib/modules/snd-mixer-oss.ko
> ./image-mnt/lib/modules/snd-timer.ko
> ./image-mnt/lib/modules/snd-seq-midi-event.ko
> ./image-mnt/lib/modules/snd-page-alloc.ko
> ./image-mnt/lib/modules/snd-pcm-oss.ko
> ./image-mnt/lib/modules/snd-seq-oss.ko
> ./image-mnt/lib/modules/snd-seq.ko

These are ALSA modules.  A few lines of code in these were written by
me.  Most was written by Jaroslaw Kysela and Takashi Iwai (both are
SUSE employees).


Ole, could you please send me the snd.ko file so that I can determine
which ALSA version this is?


Regards,
Clemens



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
