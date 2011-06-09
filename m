From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/1] ASoC: codecs: max98088: Combined DAI
 operations for DAI1 and DAI2.
Date: Thu, 9 Jun 2011 20:07:28 +0100
Message-ID: <20110609190727.GC2821@opensource.wolfsonmicro.com>
References: <BANLkTik5m4Guvqq_UtDpCzEjZDdbMM1vZQ@mail.gmail.com>
	<BANLkTi=_3uKgTC1O7KSUPMKEVEGHC1e=Kw@mail.gmail.com>
	<B2150E1E4418E1438554A300EA5040E40DDEA37AB0@ITSVLEX06.it.maxim-ic.internal>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 8959F103BF5
	for <alsa-devel@alsa-project.org>;
	Thu,  9 Jun 2011 21:07:29 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <B2150E1E4418E1438554A300EA5040E40DDEA37AB0@ITSVLEX06.it.maxim-ic.internal>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Peter Hsiang <Peter.Hsiang@maxim-ic.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Jassi Brar <jassisinghbrar@gmail.com>, Jin Park <jinyoungp@nvidia.com>, "lrg@slimlogic.co.uk" <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Thu, Jun 09, 2011 at 11:55:11AM -0700, Peter Hsiang wrote:

> Mark, what's your thought on the use of id for this purpose here?
> Would it be better to have 2 wrapper DAI functions passing in the DAI number?

I think using the ids is fine; the ids originally come from the driver
anyway - they're essentially private to it.
