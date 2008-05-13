From: "Benjamin van den Hout" <bvdhout@gmail.com>
Subject: Re: Alsa-devel Digest, Vol 15, Issue 30
Date: Tue, 13 May 2008 17:56:30 +0200
Message-ID: <d5eabee70805130856n1126f25cr36ccc2ab20e79e2@mail.gmail.com>
References: <mailman.7743.1210692269.2095.alsa-devel@alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from yw-out-1718.google.com (yw-out-1718.google.com [74.125.46.157])
	by alsa0.perex.cz (Postfix) with ESMTP id 5C1C424B3E
	for <alsa-devel@alsa-project.org>;
	Tue, 13 May 2008 17:56:31 +0200 (CEST)
Received: by yw-out-1718.google.com with SMTP id 9so1709605ywk.2
	for <alsa-devel@alsa-project.org>; Tue, 13 May 2008 08:56:30 -0700 (PDT)
In-Reply-To: <mailman.7743.1210692269.2095.alsa-devel@alsa-project.org>
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

Kind regards,
Benjamin
