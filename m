From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [asoc:for-3.7 95/95]
 sound/soc/codecs/wm0010.c:850:7-27: ERROR: Threaded IRQ with no primary
 handler requested without IRQF_ONESHOT
Date: Wed, 5 Sep 2012 06:40:25 +0100
Message-ID: <20120905054024.GA16276@sirena.org.uk>
References: <20120830151652.GB11964@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 926D32652C1
 for <alsa-devel@alsa-project.org>; Wed,  5 Sep 2012 07:40:28 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20120830151652.GB11964@localhost>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Fengguang Wu <fengguang.wu@intel.com>
Cc: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>, alsa-devel@alsa-project.org, kernel-janitors@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Thu, Aug 30, 2012 at 08:16:52AM -0700, Fengguang Wu wrote:

> [PATCH] wm0010: fix coccinelle warnings
> 
> /c/kernel-tests/src/linux/sound/soc/codecs/wm0010.c:850:7-27: ERROR: Threaded IRQ with no primary handler requested without IRQF_ONESHOT

Gah, just noticed the patch buried in here.  If you're generating stuff
like this I'd suggest restructuring the submission so it comes out as an
normal patch, it's not at all obvious that there's a patch in the mail
and even if one notices.  In this case I'd mostly ignored your mail as I
expected Dimitris to fix it, will apply now.

Julia generally does a pretty good job of formatting her mails, perhaps
there's some scripts she uses whcih would help?
