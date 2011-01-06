From: Stephen Warren <swarren@nvidia.com>
Subject: Re: [PATCH 07/11] ASoC: tegra: Add tegra-das driver
Date: Thu, 6 Jan 2011 13:58:22 -0800
Message-ID: <74CDBE0F657A3D45AFBB94109FB122FF0310567C04@HQMAIL01.nvidia.com>
References: <20101217220029.GD25609@sirena.org.uk>
	<74CDBE0F657A3D45AFBB94109FB122FF030FD78D90@HQMAIL01.nvidia.com>
	<20101222201118.GA8167@opensource.wolfsonmicro.com>
	<74CDBE0F657A3D45AFBB94109FB122FF0310567AAE@HQMAIL01.nvidia.com>
	<20110105231812.GC5476@opensource.wolfsonmicro.com>
	<74CDBE0F657A3D45AFBB94109FB122FF0310567AC4@HQMAIL01.nvidia.com>
	<20110105233338.GA5714@opensource.wolfsonmicro.com>
	<74CDBE0F657A3D45AFBB94109FB122FF0310567AE9@HQMAIL01.nvidia.com>
	<20110106005951.GC12153@opensource.wolfsonmicro.com>
	<74CDBE0F657A3D45AFBB94109FB122FF0310567B85@HQMAIL01.nvidia.com>
	<20110106210238.GD8018@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from hqemgate04.nvidia.com (hqemgate04.nvidia.com [216.228.121.35])
	by alsa0.perex.cz (Postfix) with ESMTP id 16070103807
	for <alsa-devel@alsa-project.org>; Thu,  6 Jan 2011 22:58:34 +0100 (CET)
In-Reply-To: <20110106210238.GD8018@opensource.wolfsonmicro.com>
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
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Mark Brown wrote:
> On Thu, Jan 06, 2011 at 09:46:10AM -0800, Stephen Warren wrote:
> > Finally, all the above is really talking about what a machine driver
> > "allows". It'd still be nice if the default (in the absence of any
> > alsamixer or UCM setup) was that opening e.g. hw:0,0 would allow some
> > simple use of the audio, e.g. playback to primary output, capture from
> > primary input, so that simple testing could be performed without having
> 
> Define "primary output" and "primary input" and what a sensible setup
> for them is; it's not terribly clear what they are always.  Besides,
> it's not like ALSA supports *any* use without alsa-lib or equivalent and
> if you've got that far you've already got the infrastructure you need to
> do configuration anyway more or less.  You'd need to do that to develop
> the default settings anyway, and once you've done that you've then got
> to translate them back into kernel space.
> 
> Probably the only people who'd get much from this are people who are
> using a reference system with no userspace provided, which is fairly
> unusual.  If a userspace is being shipped then including config there
> generally isn't much of an issue, and if you're bringing up a board then
> you're in the situation where you need to work out what the setup that's
> needed is.

People who're bringup up a board without expecting they need to know
anything about alsa-lib would get a bit out of this:-) :-)

So I guess what'd help me through this the most is knowing exactly how
the user-space is configured; is this all stuff in /etc/asound.conf or
some other config file? When you were talking about user-space earlier,
I was thinking of writing a custom application per board/machine to
configure the system at e.g. boot time (or libraries that apps would use),
which didn't sound appealing; maybe that's part of my misunderstanding.

Are there any public examples for ASoC in particular that I can read in
concert with the driver source to get the idea? I did find
alsa-lib.git/src/conf but that seems to only cover desktop PCs, not
ASoC drivers.

Thanks.

-- 
nvpublic
