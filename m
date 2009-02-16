From: Joris van Rantwijk <jorispubl@xs4all.nl>
Subject: Re: [PATCH] Workaround for misdetected sample rate
	with	CM6207
Date: Mon, 16 Feb 2009 20:05:17 +0100
Message-ID: <68e293574cee836f06b83afad93adf30@xs4all.nl>
References: <20090214212205.GA4898@xs4all.nl> <s5h3aeeiqty.wl%tiwai@suse.de>
Mime-Version: 1.0 (Apple Message framework v624)
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-vbr2.xs4all.nl (smtp-vbr2.xs4all.nl [194.109.24.22])
	by alsa0.perex.cz (Postfix) with ESMTP id 6E5622412E
	for <alsa-devel@alsa-project.org>; Mon, 16 Feb 2009 20:05:23 +0100 (CET)
In-Reply-To: <s5h3aeeiqty.wl%tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hello Takashi,

On 16 feb 2009, at 12:06, Takashi Iwai wrote:
>> The CM6207 incorrectly advertises its 96 kHz playback setting as 48 
>> kHz
>> in its USB device descriptor. This patch extends an existing 
>> workaround
>> in usbaudio.c to also cover the CM6207.
> Basically your patch tries to fix multiple thing at once.
> It should be better split.

Thanks for picking this up.
Yes, I thought the min/max-rate fix was trivial enough to put in. I had 
no idea that you had something planned for it.

> For example, try the patch, and add 0d8c:0102 on that.
> Does it work?

Yes, that works fine. Could you make it like that?

Greetings, Joris.
