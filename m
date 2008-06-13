From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH][ASoC v2] Update Freescale
	MPC8610HPCD	fabric driver to support multiple codecs
Date: Fri, 13 Jun 2008 16:04:27 +0100
Message-ID: <20080613150427.GA32377@rakim.wolfsonmicro.main>
References: <1213315299-30592-1-git-send-email-timur@freescale.com>
	<9e4733910806121957y3a8a15dawb50af2d2bb0d7d0b@mail.gmail.com>
	<9e4733910806122016q4e10b56atc2fb9c91e129d6cb@mail.gmail.com>
	<9e4733910806122036g5b8d86f6wed526f29377a065d@mail.gmail.com>
	<48526566.8080400@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id CF8E9244DD
	for <alsa-devel@alsa-project.org>;
	Fri, 13 Jun 2008 17:04:28 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <48526566.8080400@freescale.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Timur Tabi <timur@freescale.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Fri, Jun 13, 2008 at 07:17:42AM -0500, Timur Tabi wrote:
> Jon Smirl wrote:
>> On 6/12/08, Jon Smirl <jonsmirl@gmail.com> wrote:

>> Instead the codec should make a module parameter for the clock rate.

> Ugh.  I'm not really crazy about parameters.

Yes, that doesn't seem too clever.

Besides, the codec drivers need to treat all the clocking configuration
as dynamic - for example, it's a fairly common pattern for systems that
derive the audio clocks from a PLL or similar source to reconfigure the
master clock rate depending on the sample rates currently in use,
disabling it when not required.
