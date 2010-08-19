From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] tlv320aic3x symmetric rates
Date: Thu, 19 Aug 2010 12:08:44 +0100
Message-ID: <20100819110843.GB23404@rakim.wolfsonmicro.main>
References: <AANLkTimG1yR48_hZiKJrG_kuXK0d5EHXA8DnCun4Eq2A@mail.gmail.com>
	<20100818130010.GB15972@rakim.wolfsonmicro.main>
	<AANLkTimTWPzdneKAEShmriDG0gu72n-xUt7TRRXEEJuu@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id D7C83243AE
	for <alsa-devel@alsa-project.org>;
	Thu, 19 Aug 2010 13:08:45 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <AANLkTimTWPzdneKAEShmriDG0gu72n-xUt7TRRXEEJuu@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Randolph Chung <rchung42@gmail.com>
Cc: alsa-devel <alsa-devel@alsa-project.org>, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

On Thu, Aug 19, 2010 at 12:23:49PM +0800, Randolph Chung wrote:
> > This doesn't apply due to corruption, I've not checked the exact cause
> > but I suspect either whitespace damage or the lack of any separation
> > between the context and the signature.  Could you please resend?

> Sorry about that. Included as an attachment this time.

As with your other patch this is a base64 encoded binary so none of the
standard patch tools can apply it.  I did after some hacking manage to
apply it by hand - as well as the sending issues it seemed to have been
developed against something other than current ASoC:

 git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound-2.6.git for-2.6.37

but it's thre now.
