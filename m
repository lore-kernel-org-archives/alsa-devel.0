From: Uros Bizjak <uros@kss-loka.si>
Subject: Re: [HW BUG?] AWE64 Full duplex failures
Date: Fri, 8 Nov 2002 07:21:32 +0100 (CET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.05.10211080701560.6798-100000@pulsar.kss-loka.si>
References: <Pine.LNX.4.05.10211071257010.18843-200000@pulsar.kss-loka.si>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.05.10211071257010.18843-200000@pulsar.kss-loka.si>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
Cc: bmartin@umr.edu, amyrow@midsouth.rr.com
List-Id: alsa-devel@alsa-project.org

Hello!

> In this state, 8bit IRQ is still pending! It looks that with some SB DSP
> chip versions, this will block generation of 8 _and_ 16bit IRQs.
> 
> Attached patch (untested!) acknowledges [16|8] bit interrupt, but adds
> [8|16] bit acknowledge, if secondary channel is not in use at the moment.
> 
> Please, could someone with described problems test this patch.

  Hm, it really looks like hardware bug. Unfortunatelly, it is not just a
case of stucked interrupt, but something is wrong with capture channel
changing DMA from 16bit to 8bit if 8bit was used in full-duplex playback.
Changing DMA_OFF to DMA_EXIT does not help either.

  I can trigger described bug only with this sequence
  (with 16-bit DMA Allocation = Auto)

  - start playback (16bit DMA)
  - start capture (8bit DMA)

  - stop playback
  - stop capture
  (it doesn't matter if capture is stopped firs)

  - start capture (16bit DMA, fails)

  Interesting, there are no problems with:

  - start capture (16bit DMA)
  - start playback (8bit DMA)

  (stop them)

  - start playback (16bit DMA, ok)

  This behavior can be fixed by setting "16-bit DMA Allocation" control to
either playback or capture. Then everything works OK.

	Uros.



-------------------------------------------------------
This sf.net email is sponsored by: See the NEW Palm 
Tungsten T handheld. Power & Color in a compact size!
http://ads.sourceforge.net/cgi-bin/redirect.pl?palm0001en
