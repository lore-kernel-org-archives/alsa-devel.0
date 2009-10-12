From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 0/1] ASoC: Serialize access to
	dapm_power_widgets()
Date: Mon, 12 Oct 2009 10:00:21 +0100
Message-ID: <20091012090021.GA3308@rakim.wolfsonmicro.main>
References: <1255326119-12281-1-git-send-email-ext-eero.nurkkala@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 23B43103836
	for <alsa-devel@alsa-project.org>;
	Mon, 12 Oct 2009 11:00:23 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1255326119-12281-1-git-send-email-ext-eero.nurkkala@nokia.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ext-eero.nurkkala@nokia.com
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Mon, Oct 12, 2009 at 08:41:58AM +0300, ext-eero.nurkkala@nokia.com wrote:
> From: Eero Nurkkala <ext-eero.nurkkala@nokia.com>
> 
> It was detected that in some rare instances the
> dapm powering cycles got out of order. That lead to
> investigation of the use of all the mutexes used
> in the ASoC core.
> 
> The patch is tested with 2.6.28 (with lockdep also)
> , but applies to v2.6.32-rc3. Please review.

Please don't send 0/1 mails like this - if there's anything to say about
the patch please include it in the patch itself.  If it shouldn't make
it into the commit message include it after the ---.  0/n mails are only
useful when introducing a longer series of patches.
