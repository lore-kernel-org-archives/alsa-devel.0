From: "Alexander E. Patrakov" <patrakov@gmail.com>
Subject: Re: [PATCH alsa-lib] pcm: dmix: Handle slave PCM xrun
 and unexpected states properly
Date: Fri, 30 Oct 2015 21:36:31 +0500
Message-ID: <56339C8F.5060306@gmail.com>
References: <1446221936-8327-1-git-send-email-tiwai@suse.de>
 <56339BEC.5090204@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wi0-f174.google.com (mail-wi0-f174.google.com
 [209.85.212.174])
 by alsa0.perex.cz (Postfix) with ESMTP id F1A6026051B
 for <alsa-devel@alsa-project.org>; Fri, 30 Oct 2015 17:36:33 +0100 (CET)
Received: by wicfv8 with SMTP id fv8so14533809wic.0
 for <alsa-devel@alsa-project.org>; Fri, 30 Oct 2015 09:36:33 -0700 (PDT)
In-Reply-To: <56339BEC.5090204@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

30.10.2015 21:33, Alexander E. Patrakov wrote:
> [resending to the list, sorry for the duplicate]
>
> 30.10.2015 21:18, Takashi Iwai wrote:
>> Currently, dmix & co plugins ignore the XRUN state of the slave PCM.
>> It's (supposedly) because dmix deals with the PCM in a free-wheel
>> mode, which is equivalent with XRUN.  But, this difference (whether
>> the correct freewheel or XRUN) should be done by the kernel, and we
>> may have an XRUN state indeed (e.g. via xrun injection).
>>
>> This patch fixes this lack of behavior, to handle PCM xrun and does
>> prepare when the slave PCM is in such a state.
>>
>> Also, the patch consolidates the prepare callback for all dmix, dsnoop
>> and dshare plugins, and fix/cleanup a bit for dshare/dsnoop codes to
>> align with dsnoop code.
>>
>> Signed-off-by: Takashi Iwai <tiwai@suse.de>
>
> Just a nitpick.
>
> In snd_pcm_direct_prepare(), you use snd_pcm_state(...) directly in the
> switch statement, but in other places of the patch you introduce a
> temporary variable for the state. Why?

Sorry for the noise - you do need a temporary variable, because you 
return its value.

>
> Also, in snd_pcm_direct_prepare(), the "dmix" variable name is confusing.
>

So, other than that, the patch looks OK.

-- 
Alexander E. Patrakov
