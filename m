From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [RFC_i/iv 3/3] ASoC: Decouple DAPM from CODECs.
 Part platforms (will be squashed)
Date: Fri, 29 Oct 2010 13:47:26 -0700
Message-ID: <20101029204725.GF3921@opensource.wolfsonmicro.com>
References: <1288353618-21753-1-git-send-email-jhnikula@gmail.com>
	<1288353618-21753-4-git-send-email-jhnikula@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 9135710386B
	for <alsa-devel@alsa-project.org>;
	Fri, 29 Oct 2010 22:47:20 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1288353618-21753-4-git-send-email-jhnikula@gmail.com>
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

On Fri, Oct 29, 2010 at 03:00:18PM +0300, Jarkko Nikula wrote:
> This patch de-couples DAPM from the CODEC in order for other components to
> have DAPM widgets.

> Signed-off-by: Jarkko Nikula <jhnikula@gmail.com>

I suspect this also needs squashing in with the previous patch.  If
we're going to split the series it'd be better to split things to move
field by field rather than introduce bisection issues like this.
