From: David Henningsson <david.henningsson@canonical.com>
Subject: Re: [WIP PATCH] Scarlett mixer interface for 6i6, 18i6,
 18i8 and 18i20.
Date: Mon, 13 Oct 2014 15:30:29 +0200
Message-ID: <543BD3F5.8040406@canonical.com>
References: <1412694986-2537-1-git-send-email-david.henningsson@canonical.com>
 <54358AA6.7040205@zonque.org> <5435BF95.2040909@googlemail.com>
 <543647D3.9070004@zonque.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id B07BE260463
 for <alsa-devel@alsa-project.org>; Mon, 13 Oct 2014 15:30:31 +0200 (CEST)
In-Reply-To: <543647D3.9070004@zonque.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Daniel Mack <daniel@zonque.org>, Tobias Hoffmann <smilingthax@googlemail.com>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, robin@gareus.org, clemens@ladisch.de
List-Id: alsa-devel@alsa-project.org


On 2014-10-09 10:31, Daniel Mack wrote:
> Hi Tobias,
>
> On 10/09/2014 12:49 AM, Tobias Hoffmann wrote:
>> And some more comments from me:
>>
>> On 08/10/14 21:04, Daniel Mack wrote:
>>> +
>>> +/* #define WITH_METER */
>>> +/* #define WITH_LOGSCALEMETER */
>>> These should either be converted to module parameters, or removed
>>> alltogether. Why are they configurable, anyway?
>> As I've said in my earlier mail, code is current not working: Metering
>> should be removed from this patch (or rewritten to use hwdep-API).
>>
>>>> +#define LEVEL_BIAS 128  /* some gui mixers can't handle negative ctl values (alsamixergui, qasmixer, ...) */
>>>> +
>>>> +#ifndef LEVEL_BIAS
>>>> +	#define LEVEL_BIAS 0
>>>> +#endif
>>> Same here.
>> As LEVEL_BIAS = 0 definitely causes problems with some mixer GUIs, the
>> #ifndef ... #endif should be removed completely.
> Alright. David, will you be working on new version of the patch?

Yes, time permitting.

Thanks for the comments - so far they have mostly been about polishing 
and cleanup, and that's not too difficult, if that's all that's needed. 
But at this point, it would be nice if the maintainer(s) took a 
birds-eye view of this driver and looked at the over all structure. I e, 
so I don't spend time polishing things, that would anyway need a big 
rewrite before they are accepted.

// David
