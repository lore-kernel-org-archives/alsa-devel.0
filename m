From: Daniel Mack <daniel@zonque.org>
Subject: Re: [PATCH] ALSA: usb-audio: Recurse before saving
 terminal properties
Date: Tue, 18 Aug 2015 10:09:35 +0200
Message-ID: <55D2E83F.5030704@zonque.org>
References: <1439410499-28630-1-git-send-email-julian@jusst.de>
 <s5hr3n6t3wt.wl-tiwai@suse.de> <55CDEC38.7000006@jusst.de>
 <55D077D0.90005@zonque.org> <55D19CB4.3080208@jusst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.zonque.de (svenfoo.org [82.94.215.22])
 by alsa0.perex.cz (Postfix) with ESMTP id 516D62604A9
 for <alsa-devel@alsa-project.org>; Tue, 18 Aug 2015 10:09:37 +0200 (CEST)
In-Reply-To: <55D19CB4.3080208@jusst.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Julian Scheel <julian@jusst.de>, alsa-devel@alsa-project.org
Cc: Takashi Iwai <tiwai@suse.de>
List-Id: alsa-devel@alsa-project.org

On 08/17/2015 10:35 AM, Julian Scheel wrote:
> On 16.08.2015 13:45, Daniel Mack wrote:

>> Hmm, good point. It' been a while since I worked on this, but looking at
>> the code right now, you're right, the mixer unit for input terminal is
>> indeed just overridden by the information of the clock selector on UAC2.
>> That doesn't seem right.
>>
>> I guess what we really want is to add a 2nd mixer control in such cases,
>> and that would mean we need to call into parse_audio_selector_unit()
>> instead.
> 
> I just had another look at this. In fact all mixer controls are properly 
> created with the current code. This happens in the loop over all 
> descriptors in snd_usb_mixer_controls. parse_audio_unit is called for 
> each of them. For clock selectors and selector units it calls 
> parse_audio_selector_unit where the actual clock selector/selector units 
> are parsed and mixer ctls are created.
> So I'd renew my first comment about the recursion. It is only needed to 
> verify the integrity of descriptors and hence shall not overwrite any 
> values.

Yes, you're right. So your first patch on this is actually correct, but
given it caused confusion, I guess it deserves a comment in both the
code and the commit log :)

Care to resend with those comments added?



Thanks,
Daniel
