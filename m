From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: soc multi chip support
Date: Mon, 17 May 2010 21:16:46 +0100
Message-ID: <1274127406.3185.53.camel@odin>
References: <AANLkTiniGB0A4n_Q_E54jOTnG9I5TNfykQTR1z9klYIl@mail.gmail.com>
	<1273866350.3069.30.camel@odin>
	<AANLkTinN_2faDOB01eaRjorFoLI6E_vVXpBBO-XZvrqH@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-fx0-f51.google.com (mail-fx0-f51.google.com
	[209.85.161.51]) by alsa0.perex.cz (Postfix) with ESMTP id 3EC952476D
	for <alsa-devel@alsa-project.org>;
	Mon, 17 May 2010 22:16:49 +0200 (CEST)
Received: by fxm18 with SMTP id 18so278425fxm.38
	for <alsa-devel@alsa-project.org>; Mon, 17 May 2010 13:16:49 -0700 (PDT)
In-Reply-To: <AANLkTinN_2faDOB01eaRjorFoLI6E_vVXpBBO-XZvrqH@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Attila RS <avgrind911@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Mon, 2010-05-17 at 10:29 -0700, Attila RS wrote:
> Thanks. I pulled down the multi-component branch and am looking
> through it. I started with TI's latest PSP, which is based on 2.6.32,
> but as expected there are numerous changes between it and the the
> multi-component branch.
> 
> 
> Are there any devices in the multi-component branch that are using
> multiple audio codecs? Just looking for a good example.
> 

None public atm, just create your machine driver with 2 DAI links and
set the individual DAI link codec driver entries to different codecs. 

Liam

-- 
Freelance Developer, SlimLogic Ltd
ASoC and Voltage Regulator Maintainer.
http://www.slimlogic.co.uk
