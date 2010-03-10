From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: Reforming S3C I2S towards supporting I2Sv4
Date: Wed, 10 Mar 2010 14:23:15 +0000
Message-ID: <20100310142314.GD6850@sirena.org.uk>
References: <1268207335-9947-1-git-send-email-jassi.brar@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id CAB5B2439C
	for <alsa-devel@alsa-project.org>; Wed, 10 Mar 2010 15:23:16 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1268207335-9947-1-git-send-email-jassi.brar@samsung.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jassi Brar <jassi.brar@samsung.com>
Cc: alsa-devel@alsa-project.org, ben-linux@fluff.org
List-Id: alsa-devel@alsa-project.org

On Wed, Mar 10, 2010 at 04:48:55PM +0900, Jassi Brar wrote:

>  I have prepared some patches that debug and modify the behaviour of
> extant S3C I2S support towards managing I2Sv4 controllers as well.

OK, I think that's everything.  I've not applied anything after the
header move yet due to the need for an ack from Ben.  Any patches I
didn't specifically comment on are OK.  Overall it's all good, most of
the issues are minor.

In future could you please use --no-chain-reply-to when sending patches
to avoid massively deep threads in threaded mail readers (the git
default is changing in 1.7.0 for this very reason).  It's also best to
send the cover letter first and tell git send-email that everything
should be sent in reply to that - this way people are likely to see the
cover letter before the patches.
