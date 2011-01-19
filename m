From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 0/3] Tegra: Add internal speaker support
Date: Wed, 19 Jan 2011 11:30:42 +0000
Message-ID: <20110119113041.GA15965@opensource.wolfsonmicro.com>
References: <1295393859-3396-1-git-send-email-swarren@wwwdotorg.org>
	<20110119002513.GB4337@opensource.wolfsonmicro.com>
	<74CDBE0F657A3D45AFBB94109FB122FF0310955319@HQMAIL01.nvidia.com>
	<AANLkTi=m585PZum2NQUOqq1PiqP84LuT-qCruzaO7x7t@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 40F5024407
	for <alsa-devel@alsa-project.org>; Wed, 19 Jan 2011 12:30:25 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <AANLkTi=m585PZum2NQUOqq1PiqP84LuT-qCruzaO7x7t@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Colin Cross <ccross@google.com>
Cc: "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Stephen Warren <swarren@nvidia.com>, "lrg@slimlogic.co.uk" <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Tue, Jan 18, 2011 at 04:43:33PM -0800, Colin Cross wrote:
> On Tue, Jan 18, 2011 at 4:29 PM, Stephen Warren <swarren@nvidia.com> wrote:

> > I'll go read up on gpiolib some more to see how those API-level numbers get
> > mapped to a specific controller and GPIO number.

> They usually come in through platform data from the board file.  See
> Olof's recent Tegra sdhci patches for an example.  Tegra GPIO names
> are defined in arch/arm/mach-tegra/gpio-names.h.

Yup, and gpiolib also supports automatic assignment of numbers if you
specify -1 as the base number though that's a lot less useful within the
kernel.
