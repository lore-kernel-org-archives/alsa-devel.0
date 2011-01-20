From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: Automatically disabling internal speakers when
 headphones are plugged in
Date: Thu, 20 Jan 2011 20:39:20 +0000
Message-ID: <20110120203920.GB1555@opensource.wolfsonmicro.com>
References: <74CDBE0F657A3D45AFBB94109FB122FF0310955716@HQMAIL01.nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 24417243DE
	for <alsa-devel@alsa-project.org>; Thu, 20 Jan 2011 21:39:04 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <74CDBE0F657A3D45AFBB94109FB122FF0310955716@HQMAIL01.nvidia.com>
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
Cc: "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "lrg@slimlogic.co.uk" <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Thu, Jan 20, 2011 at 11:17:08AM -0800, Stephen Warren wrote:

> However, I wonder if that's the correct approach; should the plug detect
> logic only control the headphone output (i.e. only include the first array
> entry in jack_pins[] above), and leave it up to user-space whether to
> disable the speaker in this case, using a custom Speaker Function control
> created by the machine driver, as I see many other drivers expose?

You really should leave the headphone alone unless there's a reason the
two can't be simultaneously active (eg, being wired in parallel to the
same outputs or power constraints) but it won't break anything from an
ASoC point of view.  It will disable some use cases, though, the main
one being that it won't be possible to play notifications to headphones
and speaker simultaneously.  This is often used for notifications on
portable devices as the user may have inserted headphones during music
playback but removed them for some reason, rendering tones played only
through the headphones inaudible.

> Do the jack reports make it up to user-space so that could be implemented?

The jacks appear in userspace as input devices.
