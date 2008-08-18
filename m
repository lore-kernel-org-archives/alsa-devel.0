From: Rene Herman <rene.herman@keyaccess.nl>
Subject: Re: [PATCH] wss_lib: snd_wss_calibrate_mute improvement
Date: Mon, 18 Aug 2008 13:04:16 +0200
Message-ID: <48A95730.20505@keyaccess.nl>
References: <20080817223827.d3250ef5.krzysztof.h1@poczta.fm>	<48A937C7.2040600@keyaccess.nl>
	<s5h1w0m7hnh.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtpq2.groni1.gr.home.nl (smtpq2.groni1.gr.home.nl
	[213.51.130.201])
	by alsa0.perex.cz (Postfix) with ESMTP id 7336424429
	for <alsa-devel@alsa-project.org>;
	Mon, 18 Aug 2008 13:03:19 +0200 (CEST)
In-Reply-To: <s5h1w0m7hnh.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Alsa-devel <alsa-devel@alsa-project.org>, Krzysztof Helt <krzysztof.h1@poczta.fm>
List-Id: alsa-devel@alsa-project.org

On 18-08-08 12:16, Takashi Iwai wrote:

> At Mon, 18 Aug 2008 10:50:15 +0200,
> Rene Herman wrote:
>> On 17-08-08 22:38, Krzysztof Helt wrote:
>>
>>> From: Krzysztof Helt <krzysztof.h1@wp.pl>
>>>
>>> Mute sound by setting mute bit without
>>> setting volume to 0. It makes both source code
>>> and binary shorter.
>>>
>>> Signed-off-by: Krzysztof Helt <krzysztof.h1@wp.pl>
>> Grmmbbled-over-by: Rene Herman <rene.herman@gmail.com>
>>
>> This should be safe and the current function indeed generates crap code 
>> but in the sense of always expecting the worst broken hardware variants 
>> to be out there I must say I'd rather have seen that GCC were beter. But 
>> yes, sure.
> 
> Yeah, the slightest concern is the intention of using 0x80 there.

Yes, shared that same concern but it's very likely not significant. The 
original thought may just have been that you have to write _something_ 
so you might as well simply write 0x80 instead or or-ing in a bit and 
with volume at 0, your're even "doubly safe"...

> If this patch was already tested on some real hardwares (and I guess
> it should work), I'm willing to apply it.  Krzystof, was this tested
> on your machines?

Not (yet) on any of mine at least but actually having something where it 
does not work would be surprising. I could sort of imagine something 
being out there that ignores the mute bit but I doubt that either of us 
is actually going to have it even if it is.

Avoiding cargo-cult programming isn't unimportant so let's not be _too_ 
cautious I guess. It does currently make for crap code (GCC could be 
using cmov here it seems but it doesn't) which is an excuse...

Rene.
