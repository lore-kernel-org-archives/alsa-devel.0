From: Giuliano Pochini <pochini@denise.shiny.it>
Subject: Re: Re: [linux-audio-dev] the big jack bug... > crappy
 audio on XRUNS
Date: Mon, 7 Nov 2005 14:49:55 +0100 (CET)
Message-ID: <Pine.LNX.4.58.0511071448320.23090@denise.shiny.it>
References: <436E25DB.2070804@inwind.it> <1131302264.13599.8.camel@mindpipe>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <1131302264.13599.8.camel@mindpipe>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Lee Revell <rlrevell@joe-job.com>
Cc: The Linux Audio Developers' Mailing List <linux-audio-dev@music.columbia.edu>, jackit-devel@lists.sourceforge.net, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org



On Sun, 6 Nov 2005, Lee Revell wrote:

> On Sun, 2005-11-06 at 16:48 +0100, federico wrote:
> > it happens randomly, while I play a soft synth, that jack XRUNs once,
> > and the audio become crappy, noisy, like a kinda of digital
> > effect....bit crusher?
>
> It's probably a driver bug but could also be a PCI latency issue.
>
> Try setpci -d CARD:ID latency_timer=40 where CARD:ID is the PCI id of
> the card obtained from lspci.  Do this immediately after loading the
> driver and before playing any audio.

No, the latency must be 192 and the driver already sets it at startup.


--
Giuliano.


-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. Download
it for free - -and be entered to win a 42" plasma tv or your very own
Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
