From: David Henningsson <david.henningsson@canonical.com>
Subject: Re: ALSA: HDA: Enable subwoofer on Asus G73Jw
Date: Wed, 15 Dec 2010 09:52:15 +0100
Message-ID: <4D0881BF.6020000@canonical.com>
References: <4D087B10.8000809@canonical.com> <s5hzks7a0e3.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from adelie.canonical.com (adelie.canonical.com [91.189.90.139])
	by alsa0.perex.cz (Postfix) with ESMTP id 863682442B
	for <alsa-devel@alsa-project.org>; Wed, 15 Dec 2010 09:52:16 +0100 (CET)
In-Reply-To: <s5hzks7a0e3.wl%tiwai@suse.de>
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
Cc: ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On 2010-12-15 09:47, Takashi Iwai wrote:
> At Wed, 15 Dec 2010 09:23:44 +0100,
> David Henningsson wrote:
>>
>> Set default association/sequence right on pin 0x17 in order for
>> the automatic parser to recognize the subwoofer correctly.
>>
>> Patch rewritten to fit with the patch applied earlier today; let me know
>> if you want the original as well (might suit stable better?).
>
> Since the patch isn't applied cleanly to stable tree as is, I applied
> the patch without Cc to stable.
>
> Could you resend the patch (cleanly applicable one) to stable tree
> later once after the next pull to Linus tree is done?

Ok, do you know if I can keep track of when this is done? Or do I just 
have to make a daily check of linux-2.6 to see what's in there?

Thanks,

-- 
David Henningsson, Canonical Ltd.
http://launchpad.net/~diwic
