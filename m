From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH v3 3/4] ARM: tegra: Platform data fixes for
 ASoC driver updates
Date: Fri, 21 Jan 2011 18:27:25 +0000
Message-ID: <20110121182725.GD22414@opensource.wolfsonmicro.com>
References: <1295393859-3396-1-git-send-email-swarren@wwwdotorg.org>
	<1295556731-25165-4-git-send-email-swarren@nvidia.com>
	<20110120212259.GA21324@opensource.wolfsonmicro.com>
	<74CDBE0F657A3D45AFBB94109FB122FF0310AD4251@HQMAIL01.nvidia.com>
	<20110121175034.GC6200@opensource.wolfsonmicro.com>
	<74CDBE0F657A3D45AFBB94109FB122FF0310AD4252@HQMAIL01.nvidia.com>
	<20110121181103.GA22414@opensource.wolfsonmicro.com>
	<74CDBE0F657A3D45AFBB94109FB122FF0310AD4254@HQMAIL01.nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id EDF8A103B16
	for <alsa-devel@alsa-project.org>; Fri, 21 Jan 2011 19:27:28 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <74CDBE0F657A3D45AFBB94109FB122FF0310AD4254@HQMAIL01.nvidia.com>
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
Cc: "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "Erik Gilling (konkers@google.com)" <konkers@google.com>, "Colin Cross (ccross@google.com)" <ccross@google.com>, "lrg@slimlogic.co.uk" <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Fri, Jan 21, 2011 at 10:22:11AM -0800, Stephen Warren wrote:
> Mark Brown wrote:

> Sorry, I don't follow. Possibly not what? Are you saying:

> a) Possibly not the only dependency? It's certainly the only one I know of.

> b) Possibly not that it needs to be checked into the ASoC git repo, even though
> the header is located somewhere the Tegra git repo owns?

You said in <74CDBE0F657A3D45AFBB94109FB122FF0310AD4251@HQMAIL01.nvidia.com>:

| The other arch/arm patches won't apply anywhere yet since they build
| on top of various other patches that haven't been submitted for or
| applied to the linux-tegra tree yet.

referring to patches 2 and 3 of the series.  To me that says that these
patches won't apply to either the Tegra or ASoC trees as they stand as
they depend on patches you have not yet submitted.
