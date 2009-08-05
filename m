From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH] ASoC: MPC5200: Support for buffer wrap
	around
Date: Wed, 5 Aug 2009 12:05:55 -0600
Message-ID: <fa686aa40908051105sad236fj29301d1b11ece0d7@mail.gmail.com>
References: <20090729153844.18131.68062.stgit@riker>
	<1249490672.4582.65.camel@riker>
	<20090805170519.GA26086@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-yw0-f188.google.com (mail-yw0-f188.google.com
	[209.85.211.188])
	by alsa0.perex.cz (Postfix) with ESMTP id 0DA0124554
	for <alsa-devel@alsa-project.org>;
	Wed,  5 Aug 2009 20:06:16 +0200 (CEST)
Received: by ywh26 with SMTP id 26so427617ywh.5
	for <alsa-devel@alsa-project.org>; Wed, 05 Aug 2009 11:06:15 -0700 (PDT)
In-Reply-To: <20090805170519.GA26086@rakim.wolfsonmicro.main>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: John Bonesio <bones@secretlab.ca>, alsa-devel@alsa-project.org, Eric Millbrandt <emillbrandt@dekaresearch.com>
List-Id: alsa-devel@alsa-project.org

On Wed, Aug 5, 2009 at 11:05 AM, Mark
Brown<broonie@opensource.wolfsonmicro.com> wrote:
> On Wed, Aug 05, 2009 at 09:44:32AM -0700, John Bonesio wrote:
>
>> This is another patch for ALSA on the MPC5200 that was sent to the ALSA
>> devel list. I'm not sure if you noticed it.
>
>> Since I've submitted the patch to the list, we've been able to test it,
>> and audio continues to play right through appl_ptr wrapping back around
>> to the beginning of the buffer.
>
>> I've attached the patch, for your convenience.
>
> I've been waiting for one of the driver maintainers (Grant or Jon) to
> comment on it.

Heh.... helps if I post my approval publicly instead of just talking
to John over IM.

The patch looks correct and I know that it works because John got me
to help with testing.

Acked-by: Grant Likely <grant.likely@secretlab.ca>

An Ack from Jon would be nice too.
