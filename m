From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [RFC_i/iv 2/3] ASoC: Decouple DAPM from CODECs.
 Part codecs (will be squashed)
Date: Fri, 29 Oct 2010 13:45:39 -0700
Message-ID: <20101029204538.GE3921@opensource.wolfsonmicro.com>
References: <1288353618-21753-1-git-send-email-jhnikula@gmail.com>
	<1288353618-21753-3-git-send-email-jhnikula@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id DD2CB10386B
	for <alsa-devel@alsa-project.org>;
	Fri, 29 Oct 2010 22:45:37 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1288353618-21753-3-git-send-email-jhnikula@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jarkko Nikula <jhnikula@gmail.com>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Fri, Oct 29, 2010 at 03:00:17PM +0300, Jarkko Nikula wrote:
> Core implementation:
> Signed-off-by: Liam Girdwood <lrg@slimlogic.co.uk>

> [jhnikula@gmail.com: Fixes and conversions to 88pm860x-codec.c, alc5623,
> max98088.c, twl4060.c, uda1380.c, wm8731.c, wm8741.c, wm8753.c, wm8804,
> wm8904.c, wm8962.c, wm8971.c and wm8985.c.

This really needs a description of what the patch actually does.  Most
of this is a change to handle the code motion in patch 1 which needs to
be squashed in with that to avoid bisection issues.

> Field idle_bias_off removed from struct snd_soc_codec. Affected codecs fixed
> to use dapm->idle_bias_off]

This too.  If there's other changes in here I probably missed them.
