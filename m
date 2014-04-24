From: Jyri Sarha <jsarha@ti.com>
Subject: Re: [PATCH 1/3] ASoC: simple-card: Drop node->name
	checking
Date: Thu, 24 Apr 2014 16:05:40 +0300
Message-ID: <53590C24.7090506@ti.com>
References: <cover.1398337861.git.Guangyu.Chen@freescale.com>
 <ef6f96d375c8771c93469168790e0098610bd250.1398337861.git.Guangyu.Chen@freescale.com>
 <535907FF.3040303@ti.com> <20140424130341.GX12304@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from comal.ext.ti.com (comal.ext.ti.com [198.47.26.152])
 by alsa0.perex.cz (Postfix) with ESMTP id B105A261680
 for <alsa-devel@alsa-project.org>; Thu, 24 Apr 2014 15:05:45 +0200 (CEST)
In-Reply-To: <20140424130341.GX12304@sirena.org.uk>
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
Cc: moinejf@free.fr, alsa-devel@alsa-project.org, kuninori.morimoto.gx@renesas.com, tiwai@suse.de, lgirdwood@gmail.com, Nicolin Chen <Guangyu.Chen@freescale.com>
List-Id: alsa-devel@alsa-project.org

On 04/24/2014 04:03 PM, Mark Brown wrote:
> On Thu, Apr 24, 2014 at 03:47:59PM +0300, Jyri Sarha wrote:
>> On 04/24/2014 02:13 PM, Nicolin Chen wrote:
>
> Please delete unneeded context from your mails...
>
>>> -	if (!strcmp("sound", node->name))
>>> -		prefix = "simple-audio-card,";
>>> +	prefix = "simple-audio-card,";
>
>> I think you have missed the point of selecting the prefix based on the node
>> name.
>
> ...
>
>> Maybe the implementation could have been more explicit, but I think the old
>> behavior is more convenient. If we anyway decide to go with this change then
>> at least the DT binding document should be updated.
>
> Yes, the implementation needs to be *way* more explicit - I'd expect a
> parameter/variable saying which level we're at depending on where we're
> at in the parse rather than guessing based on the node name.
>

Ok, I'll come up with a patch soon.

Best regards,
Jyri
