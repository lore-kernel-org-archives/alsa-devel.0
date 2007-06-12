From: Liam Girdwood <lg@opensource.wolfsonmicro.com>
Subject: Re: [ASoC] bug in soc_pcm_open
Date: Tue, 12 Jun 2007 17:29:38 +0100
Message-ID: <1181665778.29999.66.camel@a10072.wolfsonmicro.main>
References: <loom.20070611T165936-889@post.gmane.org>
	<8d6898730706111344x6a6f53e1n4a21d8b93da83f70@mail.gmail.com>
	<8d6898730706112251j6226601bia95c1596ef655582@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (unknown [80.75.67.54])
	by alsa0.perex.cz (Postfix) with ESMTP id DDABC245AD
	for <alsa-devel@alsa-project.org>;
	Tue, 12 Jun 2007 18:29:39 +0200 (CEST)
In-Reply-To: <8d6898730706112251j6226601bia95c1596ef655582@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Nobin Mathew <nobin.mathew@gmail.com>
Cc: alsa-devel@alsa-project.org, Matthieu CASTET <matthieu.castet@parrot.com>
List-Id: alsa-devel@alsa-project.org

On Tue, 2007-06-12 at 11:21 +0530, Nobin Mathew wrote:
> Same will cause problems in ALSA also, because nobody is checking
> whether channel_min/max is zero; it is used in pcm_native.c
> 
> http://mailman.alsa-project.org/pipermail/alsa-devel/2007-June/001400.html
> 
> 
> On 6/12/07, Nobin Mathew <nobin.mathew@gmail.com> wrote:
> > Seems like a problem,
> > Adding to that
> >
> > if (machine->ops && machine->ops->shutdown)
> >                 machine->ops->shutdown(substream);
> >
> > if (platform->pcm_ops->close)
> >                 platform->pcm_ops->close(substream);
> >
> > if (cpu_dai->ops.shutdown)
> >                 cpu_dai->ops.shutdown(substream);
> >
> > if it is a error condition then above functions are called twice (also
> > in snd_codec_close())
 
They should only be called once (in open()) as close() should only be
called after the device has successfully opened.

Fwiw, I placed some debug in close just to make sure nothing in the
upper layers was calling close when open failed. Everything seems to
work as expected.

Liam
