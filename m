From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: [PATCH] TWL4030: Add event callback to enable
	hands-free.
Date: Thu, 11 Dec 2008 12:53:48 +0000
Message-ID: <20081211125347.GC30808@sirena.org.uk>
References: <1228960321-27827-1-git-send-email-stanley.miao@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id A3ABB103802
	for <alsa-devel@alsa-project.org>; Thu, 11 Dec 2008 13:53:54 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1228960321-27827-1-git-send-email-stanley.miao@windriver.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "Stanley.Miao" <stanley.miao@windriver.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Thu, Dec 11, 2008 at 09:52:01AM +0800, Stanley.Miao wrote:
> A special sequence is required to enable hands-free on TWL4030.
> 
> Signed-off-by: Stanley.Miao <stanley.miao@windriver.com>

I've applied this but I'm a bit nervous about this:

> +	} else {
> +		twl4030_write(w->codec, e->reg, 0x0);
> +	}

since that's clearing bits other than those which were enabled.  It
looks like there aren't any other bits in the register but it'd be good
to be more explicit about this.
