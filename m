From: Pavel Hofman <pavel.hofman@ivitera.com>
Subject: Re: M-Audio Audiophile 192 (ice1724)'s broken spdif
 capture
Date: Wed, 30 Jan 2013 16:34:31 +0100
Message-ID: <51093D87.8010809@ivitera.com>
References: <CAF+J8LeejgAx6vs0Ee8svWpmGYyk3-7SK+mE1ev-bWXYy-7v6Q@mail.gmail.com>
 <51042EE5.5070900@perex.cz>
 <7adcf466397b198e2e079e35b47686bc.squirrel@mail.insite.cz>
 <CAF+J8LduUEPqaguteL0oyiACXa4jVXGTVVTCm4Tw=jMxRTmLWA@mail.gmail.com>
 <510670CC.2090904@ivitera.com> <5107188F.3060001@gmail.com>
 <510798CC.3080006@ivitera.com> <51081FA7.70907@gmail.com>
 <5108F541.3010300@ivitera.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cable.insite.cz (static-84-242-75-189.net.upcbroadband.cz
 [84.242.75.189])
 by alsa0.perex.cz (Postfix) with ESMTP id D693F264F8F
 for <alsa-devel@alsa-project.org>; Wed, 30 Jan 2013 16:34:31 +0100 (CET)
In-Reply-To: <5108F541.3010300@ivitera.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jonas Petersen <jnsptrsn1@gmail.com>
Cc: alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org


On 30.1.2013 11:26, Pavel Hofman wrote:
> On 29.1.2013 20:14, Jonas Petersen wrote:
>> Am 29.01.2013 10:39, schrieb Pavel Hofman:
>>
>> I did that with no success. Same behaviour, no change, still no ak4114.
>> The only difference I got was:
>>
>> $ diff ~/Audiophile192-proc-a.txt ~/Audiophile192-proc-b.txt
>> 90c90
>> <   MT05     : 0x08
>> ---
>>>   MT05     : 0x00
>>
>> I printk'ed a message in ap192_ak4114_init() and it's definitely being
>> called.
>>
> 
> I see, ak4114 support in revo.c is incomplete. ak4114 controls incl. the
> proc file are never built. Please try the following patch (applicable to
> clean git checkout):


Sorry, of course

> +               err = snd_ak4114_build(ice->spec->ak4114, NULL,


instead of

> +               spec = ice->spec;
> +               err = snd_ak4114_build(spec->ak4114, NULL,

Pavel.
