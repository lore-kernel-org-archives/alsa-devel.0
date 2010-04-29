From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH 1/2] powerpc: add platform registration for
	ALSA SoC drivers
Date: Wed, 28 Apr 2010 21:44:18 -0600
Message-ID: <v2gfa686aa41004282044m48ace5feqb1507968d4b147e4@mail.gmail.com>
References: <1272314980-23679-1-git-send-email-timur@freescale.com>
	<1272350168.24542.6.camel@pasglop>
	<20100427095440.GA15492@rakim.wolfsonmicro.main>
	<1272362955.24542.24.camel@pasglop>
	<j2qed82fe3e1004281335h4076b050jc2894d4c4d6eac65@mail.gmail.com>
	<z2xfa686aa41004281458u3a3048feh9d762e07f8052348@mail.gmail.com>
	<r2oed82fe3e1004281513k23b54b56v7904a4a34750c90b@mail.gmail.com>
	<1272502322.24542.135.camel@pasglop>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-gw0-f51.google.com (mail-gw0-f51.google.com [74.125.83.51])
	by alsa0.perex.cz (Postfix) with ESMTP id DD6E010388C
	for <alsa-devel@alsa-project.org>;
	Thu, 29 Apr 2010 05:44:39 +0200 (CEST)
Received: by gwb19 with SMTP id 19so2050398gwb.38
	for <alsa-devel@alsa-project.org>; Wed, 28 Apr 2010 20:44:38 -0700 (PDT)
In-Reply-To: <1272502322.24542.135.camel@pasglop>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: alsa-devel@alsa-project.org, kumar.gala@freescale.com, Mark Brown <broonie@opensource.wolfsonmicro.com>, linuxppc-dev@ozlabs.org, Timur Tabi <timur.tabi@gmail.com>, devicetree-discuss <devicetree-discuss@lists.ozlabs.org>, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

On Wed, Apr 28, 2010 at 6:52 PM, Benjamin Herrenschmidt
<benh@kernel.crashing.org> wrote:
> On Wed, 2010-04-28 at 17:13 -0500, Timur Tabi wrote:
>> On Wed, Apr 28, 2010 at 4:58 PM, Grant Likely <grant.likely@secretlab.ca> wrote:
>>
>> > The sound0 node needs a compatible value,
>>
>> I knew I was forgetting something
>>
>> > the sound-device node should
>> > probably have one too.
>>
>> The aliases, cpus, and memory node don't have a compatible property,
>> and I was modeling the design after the aliases node.
>
> aliases is a bad choice, it's very very special and is neither a device
> nor a virtual device, like chosen.
>
> cpus is more of a match in your case.
>
> In any case, I agree, you may not really need a compatible prop for the
> virtual device. In fact, Grant, do we really need an enclosing node like
> that ?

Mostly I'm concerned about 'polluting' the root node in a way that
we'd regret later; but perhaps I'm being overly conservative.  The
sound node will still be uniquely identified by it's compatible
property, so perhaps I'm fretting over nothing.

> In any case, it's no big deal and shouldn't have much impact on
> the design.

Right, the point has been reached of quibbling over trivialities.

g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
