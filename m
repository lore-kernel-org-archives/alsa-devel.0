From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: [Fwd: Re: [pulseaudio-discuss] pulseaudio debug
	mode]
Date: Mon, 26 Jul 2010 07:31:43 +0800
Message-ID: <AANLkTimj3W_tgi-+Qqgz-J31u-daOqJ8a2E74qEUzy8U@mail.gmail.com>
References: <1280097015.29696.8.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-vw0-f51.google.com (mail-vw0-f51.google.com
	[209.85.212.51]) by alsa0.perex.cz (Postfix) with ESMTP id DCC9624541
	for <alsa-devel@alsa-project.org>;
	Mon, 26 Jul 2010 01:31:44 +0200 (CEST)
Received: by vws20 with SMTP id 20so2198406vws.38
	for <alsa-devel@alsa-project.org>; Sun, 25 Jul 2010 16:31:43 -0700 (PDT)
In-Reply-To: <1280097015.29696.8.camel@localhost.localdomain>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

2010/7/26 Chris <cpollock@embarqmail.com>

> Raymond, attached is a post I made today to the pulseaudio list.
>
> From: Chris <cpollock@embarqmail.com>
> To: pulseaudio-discuss@mail.0pointer.de
> Date: Sun, 25 Jul 2010 12:15:02 -0500
> Subject: Re: [pulseaudio-discuss] pulseaudio debug mode
> On Fri, 2010-07-23 at 08:58 +0100, Colin Guthrie wrote:
> > 'Twas brillig, and Chris at 23/07/10 02:04 did gyre and gimble:
> > > What is the best way to start PA for debugging and still have all the
> > > usual clients running?
> >
> > If you mean having all the clients connect (e.g. applications with
> > libcanberra support or similar for sound events), then there are
> > basically two ways.
> >
> > The first is as Luke suggests. These clients will automatically
> > reconnect to PA if they need to (provided you have a vaguely recent
> > libcanberra), after it is restarted and run in debug mode.
> >
> > Alternatively you can simply set debug-level to "debug" in daemon.conf
> > (in /etc/pulse or ~/.pulse), and then "grep pulseaudio /var/log/messages"
> >
> > Col
> >
>
> Colin, link below is for debug output also some other output. Anything
> look out of place that would cause the overruns?
>
> http://pastebin.com/ZWSWmXZt
> --
>

Most likely you will need to set debug-level to "debug" in daemon.conf
logout and login , and check the /var/log/messages

I suspect it occur after PA server abort and auto spawn , so please don't
just post the PA log starting from "asyncq overrun" , you need to post from
the last two PA startup sequence before the error occur since we need to
know why PA auto spawn
