From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: ChromeBook machine will lose MIC JD
Date: Thu, 14 Mar 2019 08:43:52 +0100
Message-ID: <89722d76-b678-779e-2ffb-4ba7a91cc6cf@perex.cz>
References: <6FAB7C47BCF00940BB0999A99BE3547A18DB9E4D@RTITMBSVM07.realtek.com.tw>
 <31d98868-e037-6ad4-6e11-d770129090f9@perex.cz>
 <6FAB7C47BCF00940BB0999A99BE3547A18DB9E67@RTITMBSVM07.realtek.com.tw>
 <3d8c7930-607f-b048-db37-66de22b87810@perex.cz>
 <s5hlg1jujxy.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (mail1.perex.cz [77.48.224.245])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id D5D87F8963C
 for <alsa-devel@alsa-project.org>; Thu, 14 Mar 2019 08:43:56 +0100 (CET)
In-Reply-To: <s5hlg1jujxy.wl-tiwai@suse.de>
Content-Language: en-US
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Kailang <kailang@realtek.com>
List-Id: alsa-devel@alsa-project.org

Dne 13. 03. 19 v 11:50 Takashi Iwai napsal(a):
> On Thu, 07 Mar 2019 20:49:22 +0100,
> Jaroslav Kysela wrote:
>>
>> Dne 07. 03. 19 v 9:11 Kailang napsal(a):
>>> Hi Jaroslav,
>>>
>>> I need to check with Intel chrome audio team for the name change.
>>> But chrome OS used 'alc-sense-combo' for early patch file.
>>
>> But with your patch, the ALC225_FIXUP_HEADSET_JACK and
>> ALC295_FIXUP_CHROME_BOOK do a different thing, so it's not a simple
>> replacement. Your chrome book fixup is not universal, so it should be
>> distinguished in my opinion.
> 
> Yeah, ideally this should be implemented in another model name.
> 
> But, in this particular case, the original quirk was provided
> specifically for Chromebook (despite of its generic model name
> "alc-sense-combo"), and since Chromebook is already using this string,
> it's better to keep the string as before.  That is, the risk of
> breakage for other users of this model name is much lower than the
> burden of changes of the fixed string for Chrome, I suppose.\
> 
> So I'm going to take the patch as is -- as an exception.

It would be better to move the new code to
alc_fixup_headset_jack() then, because ALC225_FIXUP_HEADSET_JACK is not
reused and we don't have a model name for it now. I would create new
fixup routines only when really necessary.

					Jaroslav

-- 
Jaroslav Kysela <perex@perex.cz>
Linux Sound Maintainer; ALSA Project; Red Hat, Inc.
