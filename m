From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] sound: drop support for PlayPaq with WM8510
Date: Wed, 23 Nov 2011 10:29:34 +0000
Message-ID: <20111123102933.GI4332@opensource.wolfsonmicro.com>
References: <1322041150.1753.25.camel@x61.thuisdomein>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 6911A103AE7
	for <alsa-devel@alsa-project.org>; Wed, 23 Nov 2011 11:29:36 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1322041150.1753.25.camel@x61.thuisdomein>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Paul Bolle <pebolle@tiscali.nl>
Cc: Takashi Iwai <tiwai@suse.de>, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

On Wed, Nov 23, 2011 at 10:39:10AM +0100, Paul Bolle wrote:
> SoC Audio support for PlayPaq with WM8510 got added in commit 9aaca9683b
> ("[ALSA] Revised AT32 ASoC Patch"). That support depends on
> BOARD_PLAYPAQ. That Kconfig symbol didn't exist when that support got
> added in v2.6.27. It still doesn't. It has never been possible to even
> build this driver. Drop it.

Applied, thanks.  Please do always use subject lines which match the
subsystem you're submitting against.
