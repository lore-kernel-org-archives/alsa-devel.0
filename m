From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH v2 2/6] ASoC: Allow the DAPM routes to be
 stored in device tree
Date: Tue, 13 Dec 2011 12:07:29 +0800
Message-ID: <20111213040728.GA4565@opensource.wolfsonmicro.com>
References: <1323291510-22338-1-git-send-email-swarren@nvidia.com>
	<1323291510-22338-2-git-send-email-swarren@nvidia.com>
	<20111208043149.GA31372@opensource.wolfsonmicro.com>
	<74CDBE0F657A3D45AFBB94109FB122FF17518605B1@HQMAIL01.nvidia.com>
	<20111210124921.GA20568@opensource.wolfsonmicro.com>
	<74CDBE0F657A3D45AFBB94109FB122FF1751860838@HQMAIL01.nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 418E1103815
	for <alsa-devel@alsa-project.org>; Tue, 13 Dec 2011 05:07:35 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <74CDBE0F657A3D45AFBB94109FB122FF1751860838@HQMAIL01.nvidia.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Stephen Warren <swarren@nvidia.com>
Cc: "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Rob Herring <robherring2@gmail.com>, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

On Mon, Dec 12, 2011 at 11:34:13AM -0800, Stephen Warren wrote:
> Mark Brown wrote at Saturday, December 10, 2011 5:49 AM:

> > It's starting to get an idiomatic way of representing the external
> > nodes, HDA is probably a good source of inspiration :)  We do need to
> > have a think about the jacks, though - simple ones are fine but
> > multifinction is more fun.

> I just wanted to confirm that you're talking about multiple audio
> functions here (e.g. mic+headphones), rather than mixing audio with
> other features (e.g. s-video + line out). I don't think the latter has

Both.

> any kind of representation in the kernel right now though? That said,

Depends; if you listen to Lennart and Kay it's totally there already and
there's nothing to worry about.

> it might be a good idea to represent jacks outside any audio complex
> DT node, so that they could host functionality of different types if
> the HW does so...

Clearly, and even audio jacks have non-audio functionality like buttons.
