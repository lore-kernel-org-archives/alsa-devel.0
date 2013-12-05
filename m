From: Nicolin Chen <b42378@freescale.com>
Subject: Re: [PATCH] ASoC: fsl: imx-wm8962: Do FLL
 configuration in hw_params() and hw_kree()
Date: Thu, 5 Dec 2013 22:17:42 +0800
Message-ID: <20131205141741.GC14744@MrMyself>
References: <1386176048-6960-1-git-send-email-b42378@freescale.com>
 <20131204190211.GD29268@sirena.org.uk>
 <20131205025630.GG8609@MrMyself>
 <20131205111508.GM29268@sirena.org.uk>
 <20131205110727.GA14744@MrMyself>
 <20131205122113.GQ29268@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from tx2outboundpool.messaging.microsoft.com
 (tx2ehsobe004.messaging.microsoft.com [65.55.88.14])
 by alsa0.perex.cz (Postfix) with ESMTP id 4D0A8261A7B
 for <alsa-devel@alsa-project.org>; Thu,  5 Dec 2013 15:40:19 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20131205122113.GQ29268@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

On Thu, Dec 05, 2013 at 12:21:13PM +0000, Mark Brown wrote:
> On Thu, Dec 05, 2013 at 07:07:28PM +0800, Nicolin Chen wrote:
> 
> > Then I think it would be plausible if I could refine this patch to
> > allow both set_bias_level() and hw_params/free() to control the FLL
> > while making them not break each other but coexist, right?
> 
> Yes, that makes sense.  It might even be useful to have some support for
> this along the style of the bias level support in the core since modern
> CODECs all use things like charge pumps and class D amplifiers so this
> is becoming a more and more common problem.

That's a nice suggestion. But currently I don't think I have the proficiency
to do this task to the core. So I'd like to start revising from this machine
driver first to gain the knowledge :)

Thank you for your reply,
Nicolin Chen
