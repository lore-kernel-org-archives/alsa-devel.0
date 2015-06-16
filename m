From: Qais Yousef <qais.yousef@imgtec.com>
Subject: Re: [PATCH v2 1/2] ASoC: soc-compress: add a config
 item for soc-compress
Date: Tue, 16 Jun 2015 17:29:20 +0100
Message-ID: <55804EE0.1000807@imgtec.com>
References: <1434338445-31992-1-git-send-email-yang.jie@intel.com>
 <s5hmw01gq9c.wl-tiwai@suse.de>
 <E7B1D079BA13FB44A978CC8F69C7D6A90554AA25@SHSMSX101.ccr.corp.intel.com>
 <s5h4mm9gi8h.wl-tiwai@suse.de>
 <E7B1D079BA13FB44A978CC8F69C7D6A90554AA81@SHSMSX101.ccr.corp.intel.com>
 <20150615150556.GQ18309@sirena.org.uk>
 <E7B1D079BA13FB44A978CC8F69C7D6A90554ACF5@SHSMSX101.ccr.corp.intel.com>
 <20150616105429.GI18309@sirena.org.uk>
 <E7B1D079BA13FB44A978CC8F69C7D6A90554B0BF@SHSMSX101.ccr.corp.intel.com>
 <20150616160607.GT18309@sirena.org.uk> <s5hlhfj8wb3.wl-tiwai@suse.de>
 <s5hioan8w6v.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailapp01.imgtec.com (mailapp01.imgtec.com [195.59.15.196])
 by alsa0.perex.cz (Postfix) with ESMTP id 12EF626585A
 for <alsa-devel@alsa-project.org>; Tue, 16 Jun 2015 18:29:22 +0200 (CEST)
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
 by Websense Email Security Gateway with ESMTPS id 8D72AB0182B1F
 for <alsa-devel@alsa-project.org>; Tue, 16 Jun 2015 17:29:18 +0100 (IST)
In-Reply-To: <s5hioan8w6v.wl-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 06/16/2015 05:17 PM, Takashi Iwai wrote:
> At Tue, 16 Jun 2015 18:14:40 +0200,
> Takashi Iwai wrote:
>> At Tue, 16 Jun 2015 17:06:07 +0100,
>> Mark Brown wrote:
>>> On Tue, Jun 16, 2015 at 12:36:16PM +0000, Jie, Yang wrote:
>>>
>>>>> OK, that should have been in the commit message.
>>>> OK, so let me add it to the commit message and resend?
>>> Well, there's still the stubs to consider.  Should we really be
>>> returning an error or should we silently ignore the error and hide the
>>> DAI if the user deconfigured compressed audio?  Or rearrange things so
>>> we don't need stubs?  Given that the machine driver has to select
>>> compressed support it's not something that should ever really hit the
>>> stubs, it's not truly a runtime thing...
>> Yes, I guess that leaving without dummy function will give unresolved
>> symbol errors at module link time, so the user can catch before
>> actually running it.  Of course, this should be checked actually.
> Oh, scratch this.  It won't work well in the current code.
> Possibly with weak linking, but...

I don't know if I am missing something, but am I the only one who thinks 
these patches and the proposed changes are too complex for what seems to 
be little gain? Why is it that bad to always compile in soc-compress?

Qais

>
> Takashi
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
