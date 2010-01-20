From: Raul Xiong <raulxiong@gmail.com>
Subject: Re: Can we add optional parameters in snd_pcm_hw_params
Date: Wed, 20 Jan 2010 17:07:52 +0800
Message-ID: <358341421001200107n672c388as167c3ae7efede02f@mail.gmail.com>
References: <358341421001190535o616ff737m15851b124402950e@mail.gmail.com>
	<20100119133757.GA2392@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from qw-out-1920.google.com (qw-out-1920.google.com [74.125.92.147])
	by alsa0.perex.cz (Postfix) with ESMTP id BA42724436
	for <alsa-devel@alsa-project.org>; Wed, 20 Jan 2010 10:07:53 +0100 (CET)
Received: by qw-out-1920.google.com with SMTP id 4so179556qwk.56
	for <alsa-devel@alsa-project.org>; Wed, 20 Jan 2010 01:07:52 -0800 (PST)
In-Reply-To: <20100119133757.GA2392@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Thanks Mark.

That's a good idea. But consider below scenario,
Assuming I'm implementing a external PCM plug-in. Inside this plug-in there
are two working mode. How can the plug-in get the mode parameter?

2010/1/19 Mark Brown <broonie@opensource.wolfsonmicro.com>

> On Tue, Jan 19, 2010 at 09:35:10PM +0800, Raul Xiong wrote:
>
> > Basically, my requirment is: There are two modes: ModeA and ModeB. I'd
> like
> > application to set this mode before it begin playing. If you have other
> > better methods to reach this requirment, it's also welcome. Thanks.
>
> Why not just expose a regular control for this and store the value in
> your private data?
>
