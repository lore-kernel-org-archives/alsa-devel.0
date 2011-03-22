From: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/2 v4] ALSA: Add snd_ctl_replace()
	to	dynamically replace a control
Date: Tue, 22 Mar 2011 15:35:07 +0000
Message-ID: <20110322153507.GA7848@opensource.wolfsonmicro.com>
References: <1300277800-610-1-git-send-email-dp@opensource.wolfsonmicro.com>
	<s5hpqpjnq00.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id F2BBD2432E
	for <alsa-devel@alsa-project.org>; Tue, 22 Mar 2011 16:35:10 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <s5hpqpjnq00.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Mark Brown <broonie@opensource.wolfsonmicro.com>, Clemens Ladisch <clemens@ladisch.de>, lrg@ti.com, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

On Tue, Mar 22, 2011 at 04:17:51PM +0100, Takashi Iwai wrote:
> At Wed, 16 Mar 2011 12:16:39 +0000,
> Dimitris Papastamos wrote:
> > 
> > Add a function to dynamically replace a given control.  If the
> > control does not already exist, a third parameter is used to determine
> > whether to actually add that control.  This is useful in cases where
> > downloadable firmware at runtime can add or replace existing controls.
> > A separate patch needs to be made to allow ALSA Mixer to render the
> > replaced controls on the fly.
> > 
> > Signed-off-by: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>
> 
> Now I applied this one to topic/misc branch with slight coding-style
> fixes checkpatch complained.  But I didn't apply the patch for ASoC.

Hi,

The reason why I did not fix those was because I tried to match the
style of sound/core/control.c.

Thanks,
Dimitris
