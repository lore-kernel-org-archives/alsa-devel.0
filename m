From: Jon Smirl <jonsmirl@gmail.com>
Subject: Re: [PATCH] ASoC: MPC5200: Support for buffer wrap
	around
Date: Wed, 5 Aug 2009 14:34:38 -0400
Message-ID: <9e4733910908051134n1ff97b47udb7645b6a714e4e3@mail.gmail.com>
References: <20090729153844.18131.68062.stgit@riker>
	<1249490672.4582.65.camel@riker>
	<20090805170519.GA26086@rakim.wolfsonmicro.main>
	<fa686aa40908051105sad236fj29301d1b11ece0d7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qy0-f185.google.com (mail-qy0-f185.google.com
	[209.85.221.185])
	by alsa0.perex.cz (Postfix) with ESMTP id 03BCC24570
	for <alsa-devel@alsa-project.org>;
	Wed,  5 Aug 2009 20:34:39 +0200 (CEST)
Received: by qyk15 with SMTP id 15so274707qyk.16
	for <alsa-devel@alsa-project.org>; Wed, 05 Aug 2009 11:34:39 -0700 (PDT)
In-Reply-To: <fa686aa40908051105sad236fj29301d1b11ece0d7@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Grant Likely <grant.likely@secretlab.ca>
Cc: John Bonesio <bones@secretlab.ca>, alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Eric Millbrandt <emillbrandt@dekaresearch.com>
List-Id: alsa-devel@alsa-project.org

On Wed, Aug 5, 2009 at 2:05 PM, Grant Likely<grant.likely@secretlab.ca> wrote:
> The patch looks correct and I know that it works because John got me
> to help with testing.
>
> Acked-by: Grant Likely <grant.likely@secretlab.ca>
>
> An Ack from Jon would be nice too.

It looks ok to me. I have my hardware torn up so I can't run anything.
I am rebuilding it to work on I2S.

I wish the upper layers would deal with appl_ptr instead of making the
drivers do it.

-- 
Jon Smirl
jonsmirl@gmail.com
