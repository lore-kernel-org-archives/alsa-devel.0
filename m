From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: txx9aclc: dynamically
	allocate	dmaengine devname
Date: Thu, 25 Jun 2009 21:05:13 +0100
Message-ID: <20090625200512.GA16600@sirena.org.uk>
References: <1245937018-4830-1-git-send-email-anemo@mba.ocn.ne.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 2123A24474
	for <alsa-devel@alsa-project.org>;
	Thu, 25 Jun 2009 22:05:16 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1245937018-4830-1-git-send-email-anemo@mba.ocn.ne.jp>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Thu, Jun 25, 2009 at 10:36:58PM +0900, Atsushi Nemoto wrote:
> Use kasprintf to allocate temporary devname string instead of a
> fixed size string.
> This fixes "FIXME" introduced on removal of BUS_ID_SIZE.

> Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>

Applied, thanks.
