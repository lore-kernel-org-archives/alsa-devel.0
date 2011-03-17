From: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/2 v4] ALSA: Add snd_ctl_replace()
	to	dynamically replace a control
Date: Thu, 17 Mar 2011 14:26:18 +0000
Message-ID: <20110317142618.GA27744@opensource.wolfsonmicro.com>
References: <1300277800-610-1-git-send-email-dp@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id A3708243B6
	for <alsa-devel@alsa-project.org>; Thu, 17 Mar 2011 15:26:20 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1300277800-610-1-git-send-email-dp@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>, lrg@ti.com, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, Clemens Ladisch <clemens@ladisch.de>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

On Wed, Mar 16, 2011 at 12:16:39PM +0000, Dimitris Papastamos wrote:
> Add a function to dynamically replace a given control.  If the
> control does not already exist, a third parameter is used to determine
> whether to actually add that control.  This is useful in cases where
> downloadable firmware at runtime can add or replace existing controls.
> A separate patch needs to be made to allow ALSA Mixer to render the
> replaced controls on the fly.
> 
> Signed-off-by: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>

Hi,

What's the status with this patch?

Thanks,
Dimitris
