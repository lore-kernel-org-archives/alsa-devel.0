From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC/multi-component: fix au1x platform
Date: Thu, 19 Aug 2010 15:48:41 +0100
Message-ID: <20100819144841.GC29453@opensource.wolfsonmicro.com>
References: <AANLkTikyZKhs6t8RRRd36KjW_Enb-+NGvUCraxEakHO5@mail.gmail.com>
	<20100819140649.GA29395@opensource.wolfsonmicro.com>
	<AANLkTik_VdzUEZ0+079iZciOryRbFNDyjE-jdzJXztcW@mail.gmail.com>
	<20100819143555.GB29453@opensource.wolfsonmicro.com>
	<AANLkTikUN0xDGnDPk7Jxk9YihOD3mPxRzxhv+s+A5Fsz@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Content-Disposition: inline
In-Reply-To: <AANLkTikUN0xDGnDPk7Jxk9YihOD3mPxRzxhv+s+A5Fsz@mail.gmail.com>
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

On Thu, Aug 19, 2010 at 04:39:17PM +0200, Manuel Lauss wrote:

> True, but I don't see how one can pass instance data to
> the ac97_read/write/whatever functions.

The struct snd_ac97 * passed in to them has a pointer to the struct
snd_card * for the card which should (via some further indirection)
allow you to get back to the ASoC specific structures.
