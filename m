From: "Rui Nuno Capela" <rncbc@rncbc.org>
Subject: Re: usx2y hangs SuSE 9.2 Pro kernel
Date: Tue, 9 Nov 2004 21:53:36 -0000 (WET)
Message-ID: <32933.192.168.1.5.1100037216.squirrel@192.168.1.5>
References: <200411092216.41896.efocht@hpce.nec.com>
Mime-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <200411092216.41896.efocht@hpce.nec.com>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Erich Focht <efocht@hpce.nec.com>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Erich Focht,
>
> I'm having trouble with my Tascam US-122. When trying to run it with
> the SuSE 9.2 Pro kernel (2.6.8-24.3-default) the kernel hangs
> immediately. I wonder whether the devices are tested at all with this
> kernel...
>
> Does anybody have a hint where to look at?
>

Yes. It seems that you're suffering from that nasty snd-usb-usx2y OHCI
bug, which has been known around since ALSA 1.0.6.

Look at ALSA bugtracker's:

Bug #000425 (https://bugtrack.alsa-project.org/alsa-bug/view.php?id=425)
Bug #000607 (https://bugtrack.alsa-project.org/alsa-bug/view.php?id=607)

Good news is that's been already solved as of current CVS (snd-usb-usx2y
0.8.6). Bad news is, if you wanna get your US-122 working right now,
you'll have to build the alsa-kernel/alsa-driver tandem from CVS, or you
might wait for the official ALSA 1.0.7 release or even longer for a SUSE
9.2 package update.

Cheers,
-- 
rncbc aka Rui Nuno Capela
rncbc@rncbc.org



-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
