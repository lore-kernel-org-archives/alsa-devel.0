From: Erich Focht <efocht@hpce.nec.com>
Subject: Re: usx2y hangs SuSE 9.2 Pro kernel
Date: Wed, 10 Nov 2004 00:28:45 +0100
Message-ID: <200411100028.46091.efocht@hpce.nec.com>
References: <200411092216.41896.efocht@hpce.nec.com> <32933.192.168.1.5.1100037216.squirrel@192.168.1.5>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <32933.192.168.1.5.1100037216.squirrel@192.168.1.5>
Content-Disposition: inline
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Rui Nuno Capela <rncbc@rncbc.org>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Tuesday 09 November 2004 22:53, Rui Nuno Capela wrote:
> > I'm having trouble with my Tascam US-122. When trying to run it with
> > the SuSE 9.2 Pro kernel (2.6.8-24.3-default) the kernel hangs
> > immediately. I wonder whether the devices are tested at all with this
> > kernel...
> >
> > Does anybody have a hint where to look at?
>
> Yes. It seems that you're suffering from that nasty snd-usb-usx2y OHCI
> bug, which has been known around since ALSA 1.0.6.
> 
> Look at ALSA bugtracker's:
> 
> Bug #000425 (https://bugtrack.alsa-project.org/alsa-bug/view.php?id=425)
> Bug #000607 (https://bugtrack.alsa-project.org/alsa-bug/view.php?id=607)

Thanks a lot!!!

I'll either press the patches into the SuSE kernel or switch to the
-mm tree. At least I know it should work afterwards.

Regards,
Erich



-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
