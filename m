From: "Martijn Sipkema" <msipkema@sipkema-digital.com>
Subject: Re: [linux-audio-dev] Re: Forcing an absolute timestamp for every midi event.
Date: Mon, 19 Aug 2002 07:43:59 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <002b01c2474b$ec3c0170$0400a8c0@martijn>
References: <20020818055740.2af8e3e7.coding@reduz.com.ar> <000c01c246f3$bfed4370$0400a8c0@martijn> <20020818211826.GA7440@idefix.fvdpol.home.nl>
Reply-To: "Martijn Sipkema" <msipkema@sipkema-digital.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from hirogen.kabelfoon.nl (hirogen.kabelfoon.nl [62.45.45.69])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id HAA15326
	for <alsa-devel@alsa-project.org>; Mon, 19 Aug 2002 07:47:44 +0200
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Frank van de Pol <fvdpol@home.nl>, linux-audio-dev@music.columbia.edu
Cc: Juan Linietsky <coding@reduz.com.ar>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

[...]
> Is there already a commonly available UST on linux? To my knowledge the
only
> thing that comes close is the (cpu specific) cycle counter.

No, not yet. I think we should try to get hard- or firm-timers and POSIX
CLOCK_MONOTONIC into the Linux kernel.

--martijn






-------------------------------------------------------
This sf.net email is sponsored by: OSDN - Tired of that same old
cell phone?  Get a new here for FREE!
https://www.inphonic.com/r.asp?r=sourceforge1&refcode1=vs3390
