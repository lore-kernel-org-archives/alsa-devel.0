From: Stephen Warren <swarren@nvidia.com>
Subject: Re: [PATCH v3 3/4] ARM: tegra: Platform data fixes for
 ASoC driver updates
Date: Fri, 21 Jan 2011 09:45:56 -0800
Message-ID: <74CDBE0F657A3D45AFBB94109FB122FF0310AD4251@HQMAIL01.nvidia.com>
References: <1295393859-3396-1-git-send-email-swarren@wwwdotorg.org>
	<1295556731-25165-4-git-send-email-swarren@nvidia.com>,
	<20110120212259.GA21324@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from hqemgate03.nvidia.com (hqemgate03.nvidia.com [216.228.121.140])
	by alsa0.perex.cz (Postfix) with ESMTP id 28B391037F5
	for <alsa-devel@alsa-project.org>; Fri, 21 Jan 2011 18:46:13 +0100 (CET)
In-Reply-To: <20110120212259.GA21324@opensource.wolfsonmicro.com>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>, "Erik Gilling
	(konkers@google.com)" <konkers@google.com>, "Colin Cross (ccross@google.com)" <ccross@google.com>
Cc: "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "lrg@slimlogic.co.uk" <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

[I apologize if the email formatting is terrible; my usual system is broken
right now. I hope this is plain text]

Mark Brown wrote on Thursday, January 20, 2011 14:22:
> On Thu, Jan 20, 2011 at 01:52:10PM -0700, Stephen Warren wrote:
> > The WM8903 driver now needs platform data in order to correctly expose its
> > GPIOs through gpiolib.
> 
> This isn't really a fix - it's enabling a new feature that wasn't
> previously supported

Agreed. I'll reword this when I submit it for inclusion in the Tegra tree.

> I'm happy with this version of the series, I guess Liam will be too.
> Ideally someone from the Tegra side should sign off on the arch/arm
> side - that'll need to go through the same tree as the ASoC side for
> build dependencies.

I assume you're only talking about:

a882c75eadfcdc56f47962dd3f7870d6def62847
ARM: tegra: Add Harmony sound platform data type

The other arch/arm patches won't apply anywhere yet since they build
on top of various other patches that haven't been submitted for or
applied to the linux-tegra tree yet.

CC += Colin/Erik to ack/nack the header addition mentioned above.

Thanks

-- 
nvpublic
