From: Fergus Reid <fergusr@solid-state-logic.com>
Subject: Request for advice on stopping xruns
Date: Wed, 06 Mar 2002 08:50:28 +0000
Message-ID: <3C85D854.484BF9EF@solid-state-logic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Hi, I'm developing an 8 channel recorder based on alsa0.9.0beta10 and a
Terratec EWS88mt sound card.
I'm now using a 2.4.18 kernel with the Andrew Morton patches applied. I
really want to be able to record/playback at the full 96k 24bits on all
8 channels simultaneously, but I need absolutely no under/overruns.
Currently, as I try to up the bandwidth requirements I get xruns
occurring more and more frequently; I'm not even sure if I can guarantee

a maximum, before the onset of xruns, although 16bit 44.1 may well be
okay.

I don't care about other system processes, so I've set the record and
playback threads to SCHED_FIFO prio 99 (although I don't really know if
this is the right thing to do!)

Is there anything I can do/change/not do to eliminate xruns altogether?

Thanks,
Fergus





**********************************************************************
This email and any files transmitted with it are confidential and
intended solely for the use of the individual or entity to whom they
are addressed. If you have received this email in error please notify
the system manager.

This footnote also confirms that this email message has been swept by
MIMEsweeper for the presence of computer viruses.

www.mimesweeper.com
**********************************************************************


_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel
