From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: Dynamically registering a codec
Date: Thu, 14 May 2009 20:13:58 +0100
Message-ID: <20090514191358.GA14067@rakim.wolfsonmicro.main>
References: <9e4733910905131218t174b3b7cxc0e5c2fd5f5a0a06@mail.gmail.com>
	<20090513224424.GB24973@sirena.org.uk>
	<9e4733910905140844h1899bb60p19309953905b51d3@mail.gmail.com>
	<1242317750.31458.1782.camel@finisterre>
	<9e4733910905140943u7f8e5151tbaba86938bf9e77e@mail.gmail.com>
	<1242322832.31458.1911.camel@finisterre>
	<9e4733910905141057t64c515a2n8473a26da852fdfd@mail.gmail.com>
	<20090514183850.GA13483@rakim.wolfsonmicro.main>
	<9e4733910905141156j576c059ci653d0acd3e45e156@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 3F085103947
	for <alsa-devel@alsa-project.org>;
	Thu, 14 May 2009 21:13:59 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <9e4733910905141156j576c059ci653d0acd3e45e156@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jon Smirl <jonsmirl@gmail.com>
Cc: alsa-devel mailing list <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Thu, May 14, 2009 at 02:56:32PM -0400, Jon Smirl wrote:
> On Thu, May 14, 2009 at 2:38 PM, Mark Brown

> > Please re-read my comments about the specific problems with AC97 - this
> > is key here.

> So I need to make fabric drivers for Efika and Phytec that statically
> link to the respective AC97 codecs? And the core is going to get

They just need to reference a symbol that's exported by the codec driver
such as the DAI.

> updated so that I can remove these static links?

As I said in my original mail there is currently little work on AC97 in
general so unless someone steps forward to enhance the AC97
infrastructure something like that is going to have to remain for the
time being with AC97 CODECs.
