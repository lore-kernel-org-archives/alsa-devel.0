From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: Which project to choose?
Date: Thu, 15 Jul 2010 06:32:15 +0800
Message-ID: <AANLkTilT1F0hUp2m5C-9PbY_Ef7oaiAxftwJvU_w6i0y@mail.gmail.com>
References: <1279062131.24837.22.camel@localhost.localdomain>
	<AANLkTikEf4gf-oeQf4hNGUEvNi0YVrvutnSMCbxGwtJ8@mail.gmail.com>
	<1279065709.24837.29.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-vw0-f51.google.com (mail-vw0-f51.google.com
	[209.85.212.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 7B805103893
	for <alsa-devel@alsa-project.org>;
	Thu, 15 Jul 2010 00:32:17 +0200 (CEST)
Received: by vws9 with SMTP id 9so313489vws.38
	for <alsa-devel@alsa-project.org>; Wed, 14 Jul 2010 15:32:15 -0700 (PDT)
In-Reply-To: <1279065709.24837.29.camel@localhost.localdomain>
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

2010/7/14 Chris <cpollock@embarqmail.com>

> On Wed, 2010-07-14 at 07:26 +0800, Raymond Yau wrote:
> > 2010/7/14 Chris <cpollock@embarqmail.com>
> >
>
>
> Then Raymond, tell me, how do I stop this from happening? It just
> happens, I'm not playing any audio when it does. For instance
>
> Jul 13 17:29:39 localhost pulseaudio[24553]: ratelimit.c: 466 events
> suppressed
> Jul 13 17:29:39 localhost pulseaudio[24553]: asyncq.c: q overrun,
> queuing locally
> Jul 13 17:29:39 localhost pulseaudio[24553]: asyncq.c: q overrun,
> queuing locally
> Jul 13 17:29:39 localhost pulseaudio[24553]: asyncq.c: q overrun,
> queuing locally
>


> Jul 13 17:29:39 localhost pulseaudio[24553]: asyncq.c: q overrun,
> queuing locally
> Jul 13 17:29:44 localhost pulseaudio[24553]: ratelimit.c: 497 events
> suppressed
>
> So, is this a pulseaudio issue or an Alsa issue?
>
>

You have to ask PA developer about "asyncq.c: q overrun,
queuing locally" , this seem to be asyncq_push() cannot be called twice and
I have no idea about this operation has any direct relationship with alsa
