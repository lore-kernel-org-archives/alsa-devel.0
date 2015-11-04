From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: wm9713: add gpio chip
Date: Wed, 4 Nov 2015 18:33:22 +0000
Message-ID: <20151104183322.GD2549@ck-lbox>
References: <1446657164-25012-1-git-send-email-robert.jarzmik@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com
 [67.231.152.168])
 by alsa0.perex.cz (Postfix) with ESMTP id 725312606B8
 for <alsa-devel@alsa-project.org>; Wed,  4 Nov 2015 19:49:18 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1446657164-25012-1-git-send-email-robert.jarzmik@free.fr>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Robert Jarzmik <robert.jarzmik@free.fr>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, patches@opensource.wolfsonmicro.com, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

On Wed, Nov 04, 2015 at 06:12:44PM +0100, Robert Jarzmik wrote:
> The Wolfson WM9713 provides 8 GPIOs. If the gpiolib is compiled in the
> kernel, declare a gpio chip.
> 
> Signed-off-by: Robert Jarzmik <robert.jarzmik@free.fr>
> ---

You should probably make a seperate driver within GPIO for this
and then tie the two together, using an MFD. I appreciate that is
more work but it is likely a nicer solution overall.

Thanks,
Charles
