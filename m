From: "Benjamin van den Hout" <bvdhout@gmail.com>
Subject: Re: Problem with aloop
Date: Wed, 14 May 2008 10:35:03 +0200
Message-ID: <d5eabee70805140135n7d45c858j55f7fca9a9765d5a@mail.gmail.com>
References: <d5eabee70805130627v1dd7b675ua4fadc9bd1905357@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from yw-out-1718.google.com (yw-out-1718.google.com [74.125.46.158])
	by alsa0.perex.cz (Postfix) with ESMTP id 03F76243DB
	for <alsa-devel@alsa-project.org>;
	Wed, 14 May 2008 10:35:04 +0200 (CEST)
Received: by yw-out-1718.google.com with SMTP id 9so1913677ywk.2
	for <alsa-devel@alsa-project.org>; Wed, 14 May 2008 01:35:03 -0700 (PDT)
In-Reply-To: <d5eabee70805130627v1dd7b675ua4fadc9bd1905357@mail.gmail.com>
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Gustavo da Silva Serra wrote:

*Sorry, I accidentally left the subject to the digest title. Reposting to
get the threading right*

I tryied to use the HG versions, but they didn't work well for me. Maybe
> you should give the 1.0.16 a try, just to make sure.
> I need an asound.conf since my network application uses a very low
> latency, that is not default. I am attaching my asound.conf.
> Another possible source of problems are the artsd and esd daemons, are
> they running?
>
> Hi Gustavo,

I just downloaded the 10.0.16 version and the code for aloop-kernel.c looked
quite different from the one in the HG version. I was under the
understanding that the HG version is a current development snapshot that
eventually gets tagged into an official 1.0.1xx version. That's not the case
then?

Anyway, I will try with the 10.0.16 version, I see some stuff about a
#define called SND_CARD_LOOPBACK_START_SYNC, that sounds promising perhaps.
I've also looked at the config file you attached, the stuff about
period_time and buffer_size also looks quite interesting and is perhaps
something I should play with then :)

I'll let you know how things work out! Thanks for your continued help, it is
greatly appreciated...

UPDATE: I built the 10.0.16 version of snd-aloop and it seems to perform a
bit better out of the box! I will experiment a bit more...

Kind regards,
Benjamin
