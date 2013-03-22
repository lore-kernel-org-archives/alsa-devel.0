From: Daniel Mack <zonque@gmail.com>
Subject: Re: [PATCH 2/2 resend] ASoC: cs4271: preserve "Master
 Playback Switch" setting
Date: Fri, 22 Mar 2013 11:23:32 +0100
Message-ID: <514C3124.8010806@gmail.com>
References: <1363895035-20356-1-git-send-email-zonque@gmail.com>
 <1363895035-20356-2-git-send-email-zonque@gmail.com>
 <20130322101820.GC22890@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-we0-f178.google.com (mail-we0-f178.google.com
 [74.125.82.178])
 by alsa0.perex.cz (Postfix) with ESMTP id 1F3F52664B0
 for <alsa-devel@alsa-project.org>; Fri, 22 Mar 2013 11:23:35 +0100 (CET)
Received: by mail-we0-f178.google.com with SMTP id o45so3022758wer.23
 for <alsa-devel@alsa-project.org>; Fri, 22 Mar 2013 03:23:34 -0700 (PDT)
In-Reply-To: <20130322101820.GC22890@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, subaparts@yandex.ru, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

Hi Mark,

On 22.03.2013 11:18, Mark Brown wrote:
> On Thu, Mar 21, 2013 at 08:43:55PM +0100, Daniel Mack wrote:
>> Currently, both the ALSA control for "Digital Master Playback Switch"
>> and the ALSA core (by calling dai_ops->mute_stream()) control the same
>> bits in the CS4271_VOL[AB]_MUTE registers.
> 
>> That's a problem for applications which intentionally want to keep the
>> flag switched off from userspace, even though the stream is already
>> playing.
> 
>> Fix this by keeping track of the states on both sides - the ALSA
>> control and the ASoC core - and actually mute the Codec if either one
>> of the two flags is set.
> 
> The usual fix for this is to just not have the mute operation if it's
> important.  Otherwise this seems like something we ought to implement in
> the core, it's not a silly feature by any stretch of the imagination but
> it applies to any device with a DAI mute unless there's some device
> specific thing I'm missing here.
> 

Well, the thing is about different use cases. If you leave everything
untouched as of the ALSA controls (unmuted), the codec will enter its
mute state just as expected by the core. The register bit also has
implications to external mute stages btw, which board designers usually
implement with MOSFETs.

It's just that if the user intentionally mutes the stream via the ALSA
control, the core will override it, thus changing the state of the
actual control unexpectedly.

So I'd say having a simple OR logic in this case is reasonable and
serves all the needs I can think of, no?


Thanks,
Daniel
