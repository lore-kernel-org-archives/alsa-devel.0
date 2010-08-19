From: Manuel Lauss <manuel.lauss@googlemail.com>
Subject: Re: [PATCH] ASoC/multi-component: fix au1x platform
Date: Thu, 19 Aug 2010 16:58:55 +0200
Message-ID: <AANLkTimbasVqtJLeg-F+M9Ry9AzLgy8EG213vy_rEbc=@mail.gmail.com>
References: <AANLkTikyZKhs6t8RRRd36KjW_Enb-+NGvUCraxEakHO5@mail.gmail.com>
	<20100819140649.GA29395@opensource.wolfsonmicro.com>
	<AANLkTik_VdzUEZ0+079iZciOryRbFNDyjE-jdzJXztcW@mail.gmail.com>
	<20100819143555.GB29453@opensource.wolfsonmicro.com>
	<AANLkTikUN0xDGnDPk7Jxk9YihOD3mPxRzxhv+s+A5Fsz@mail.gmail.com>
	<20100819144841.GC29453@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <20100819144841.GC29453@opensource.wolfsonmicro.com>
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
Cc: alsa-devel@vger.kernel.org, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Thu, Aug 19, 2010 at 4:48 PM, Mark Brown
<broonie@opensource.wolfsonmicro.com> wrote:
> On Thu, Aug 19, 2010 at 04:39:17PM +0200, Manuel Lauss wrote:
>
>> True, but I don't see how one can pass instance data to
>> the ac97_read/write/whatever functions.
>
> The struct snd_ac97 * passed in to them has a pointer to the struct
> snd_card * for the card which should (via some further indirection)
> allow you to get back to the ASoC specific structures.

Are there an in-tree examples I could look at?  (and for example on how
to pass per-instance platform data around?  It's not immediately obvious
to me how to get data allocated in a platform_driver.probe() callback to
the various dai_ops and pcm_ops).

Thanks!
       Manuel Lauss
