From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] Max98095: Move existing NULL check before
 pointer dereference.
Date: Wed, 18 May 2011 09:38:19 -0700
Message-ID: <20110518163819.GD16414@opensource.wolfsonmicro.com>
References: <1305680634-10484-1-git-send-email-thutt@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id B4C9F24499
	for <alsa-devel@alsa-project.org>;
	Wed, 18 May 2011 18:38:18 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1305680634-10484-1-git-send-email-thutt@chromium.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Taylor Hutt <thutt@chromium.org>
Cc: alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>, linux-kernel@vger.kernel.org, Peter Hsiang <peter.hsiang@maxim-ic.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Tue, May 17, 2011 at 06:03:54PM -0700, Taylor Hutt wrote:
> Visual inspection shows that max98095_put_eq_enum() and
> max98095_put_bq_enum() each have a possible NULL deref of 'pdata'.
> 
> This change moves the NULL check above the use.

Applied, thanks.  Please try to keep your subject line consistent with
the rest of the subsystem.
