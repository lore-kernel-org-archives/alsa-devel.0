From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: Playing multiple sounds at the same time
Date: Tue, 4 May 2010 10:34:59 +0800
Message-ID: <h2u4f3252891005031934h2a950ac4z1e9036738c88e27e@mail.gmail.com>
References: <4411e1854e5de844b0cf28262efd5992-EhVcX19FRQFfRwgeDBcNWRwwfgFLV15YQUBGAEFbWi9fXEYKW1loAFJQQ1lcLkQAWFhfQltcWgE=-webmailer2@server02.webmailer.hosteurope.de>
	<20100430104308.GE21607@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pw0-f51.google.com (mail-pw0-f51.google.com
	[209.85.160.51]) by alsa0.perex.cz (Postfix) with ESMTP id 9457824403
	for <alsa-devel@alsa-project.org>;
	Tue,  4 May 2010 04:35:00 +0200 (CEST)
Received: by pwj8 with SMTP id 8so1352620pwj.38
	for <alsa-devel@alsa-project.org>; Mon, 03 May 2010 19:34:59 -0700 (PDT)
In-Reply-To: <20100430104308.GE21607@sirena.org.uk>
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

2010/4/30 Mark Brown <broonie@opensource.wolfsonmicro.com>

> On Fri, Apr 30, 2010 at 12:38:49PM +0200, Andreas Falkenhahn wrote:
>
> > Now I want to play sounds 1 to 3 at the same time. My question is now:
> Can
> > ALSA do automatic mixing for me here or do I have to do the mixing on my
> > own? In other words, can I simply feed all these three sound streams to
> > ALSA or do I have to mix them into a fourth audio stream first and
> feeding
> > this new fourth stream to ALSA then?
>
> The easiest thing for your application is to just open and play multiple
> audio streams and allow a system mixing daemon such as PulseAudio to
> take care of the mixing.
>
>
Are you sure that your program can connect to PA server multilple times ?
