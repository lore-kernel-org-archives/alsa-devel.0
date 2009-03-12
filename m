From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 3/5] ASoC: Replace remaining uses of
	snd_soc_cnew with	snd_soc_add_controls.
Date: Thu, 12 Mar 2009 10:11:51 +0000
Message-ID: <20090312101151.GA4038@rakim.wolfsonmicro.main>
References: <20090311224439.GB9001@sirena.org.uk>
	<1236852474-15930-1-git-send-email-philipp.zabel@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id F2ABA1038C7
	for <alsa-devel@alsa-project.org>; Thu, 12 Mar 2009 11:11:52 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1236852474-15930-1-git-send-email-philipp.zabel@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Philipp Zabel <philipp.zabel@gmail.com>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Thu, Mar 12, 2009 at 11:07:54AM +0100, Philipp Zabel wrote:
> The drivers are basically duplicating the same code over and over.
> As snd_soc_cnew is going to be made static some time after the next
> merge window, we might as well convert them now.

> Signed-off-by: Philipp Zabel <philipp.zabel@gmail.com>

Applied, thanks.
