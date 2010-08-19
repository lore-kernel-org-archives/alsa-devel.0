From: David Henningsson <david.henningsson@canonical.com>
Subject: Re: [PATCH] Show processing coefficients in codec proc
	file
Date: Thu, 19 Aug 2010 20:48:56 +0200
Message-ID: <4C6D7C98.5030207@canonical.com>
References: <4C6D7546.4000506@canonical.com> <s5h4oeqfoe7.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from adelie.canonical.com (adelie.canonical.com [91.189.90.139])
	by alsa0.perex.cz (Postfix) with ESMTP id 77D9E2454C
	for <alsa-devel@alsa-project.org>;
	Thu, 19 Aug 2010 20:48:58 +0200 (CEST)
In-Reply-To: <s5h4oeqfoe7.wl%tiwai@suse.de>
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
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

2010-08-19 20:28, Takashi Iwai skrev:
> At Thu, 19 Aug 2010 20:17:42 +0200,
> David Henningsson wrote:
>>
>> This patch is helpful for tracking down bugs without having all
>> information about the chip.
> 
> I don't want to change coef index in reading a proc file in general.

Good point. But I think the solution to that problem would be to
- read current index
- do the loop
- restore current index

...and perhaps protect that with an appropriate mutex (which one)?

> If any, you should implement a codec-specific hook.

I'm sorry, but I don't really see how that would help...?

Another option would be to have a generic snd_hda_codec_write_coef(nid,
index, value) and snd_hda_codec_read_coef(nid, index) in hda_codec.c
(and perhaps protect it with a spin lock?), then remove all other code
that directly sets the coefficient index.

-- 
David Henningsson, Canonical Ltd.
http://launchpad.net/~diwic
