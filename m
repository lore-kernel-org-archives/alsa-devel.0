From: "Martijn Sipkema" <msipkema@sipkema-digital.com>
Subject: Re: Fw: writing audiowerk driver (philips saa7146a), some questions
Date: Fri, 31 May 2002 13:22:32 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <001a01c2089d$de159800$0400a8c0@martijn>
References: <Pine.LNX.4.21.0205311259260.14881-100000@mailserver.intern.bfad.de>
Reply-To: "Martijn Sipkema" <msipkema@sipkema-digital.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from hirogen.kabelfoon.nl (hirogen.kabelfoon.nl [62.45.45.69])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id NAA32013
	for <alsa-devel@alsa-project.org>; Fri, 31 May 2002 13:23:10 +0200
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: tomasz motylewski <T.Motylewski@bfad.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

> >  - does alsa allow varipitch? i think the new rme cards are supposed to
> >  have this feature and the audiowerk8 has it, i.e. it can change its
> > sampling
> >  rate from about 37700 to 58200 hz while running in 1hz increments.
> >  this allows for sync to video/tape/midi or whatever. or it allows for
the
> >  sample rate to be adjusted when receiving audio using rtp.
>
> Can the frequency be changed without stopping (no loss of sound)?

yes

> If so it is
> an interesting feature, but I am not sure if supported by ALSA.

perhaps it could be added?
in EASI every driver has a number of supported sample rates and an
associated pitch range.

--martijn


_______________________________________________________________

Don't miss the 2002 Sprint PCS Application Developer's Conference
August 25-28 in Las Vegas -- http://devcon.sprintpcs.com/adp/index.cfm
