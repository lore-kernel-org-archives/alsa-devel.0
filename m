From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: Add dapm_find_widget helper
Date: Wed, 27 Apr 2011 22:14:54 +0100
Message-ID: <20110427211454.GB30875@opensource.wolfsonmicro.com>
References: <1303922071-23466-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id B5B88103904
	for <alsa-devel@alsa-project.org>;
	Wed, 27 Apr 2011 23:14:45 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1303922071-23466-1-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Wed, Apr 27, 2011 at 06:34:31PM +0200, Lars-Peter Clausen wrote:
> This patch adds a helper function for searching DAPM widgets by name.
> This allows to streamline functions which operate on widgets by name.
> It also allows to get rid of copy'n'pasted code which was added to fallback to
> widgets from other contexts if the widget was not found in the current context.

Applied, thanks.
