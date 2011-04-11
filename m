From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: ASoC mixer control names v.s. well-known "Master"
Date: Mon, 11 Apr 2011 13:07:52 -0700
Message-ID: <20110411200751.GA29405@opensource.wolfsonmicro.com>
References: <74CDBE0F657A3D45AFBB94109FB122FF0493EB3C62@HQMAIL01.nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id CFC251038F4
	for <alsa-devel@alsa-project.org>;
	Mon, 11 Apr 2011 22:07:44 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <74CDBE0F657A3D45AFBB94109FB122FF0493EB3C62@HQMAIL01.nvidia.com>
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
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Mon, Apr 11, 2011 at 12:34:23PM -0700, Stephen Warren wrote:

> In ChromeOS, user-space attempts to manipulate controls with "well known
> names" to control e.g. output volume. The names it uses are probably based
> on Documentation/sound/alsa/ControlNames.txt, since the code was originally
> written for x86 platforms that use those names.

> Is that document relevant to ASoC, up-to-date, and binding on audio
> drivers, or more of a de-facto FYI?

This basically doesn't work for ASoC - it is kind of what you should do
if you can do things but it really only works for PC style sound cards
where there's relatively little flexibility in terms of routing and so
on.  With embedded systems the appropriate controls to use for a given
feature can vary substantially depending on board design and even use
case (the CPU to headphone case for MP3 playback may not share anything
at all with the voice call to earpiece) so it's difficult to do
anything.

The idea with ASoC is that you should use UCM for this.  What I'd
suggest is that ChromeOS implements UCM support and then falls back to
using control names if there isn't a UCM configuration for the device.

> Those names don't exist for Tegra, or rather the WM8903, and I imagine for
> any ASoC drivers. I had imagined this could be fixed by creating virtual
> mixer controls in asound.conf that re-direct requests to that real control.
> Is that how things typically work? Or, should the ASoC machine driver
> create controls with those names?

Typically embedded applications don't try to work with generic control
names at all - they're either specific to the physical system or use
configuration files.  A large part of what UCM does is abstract out the
generic bits of the configuration files approach from applications.
