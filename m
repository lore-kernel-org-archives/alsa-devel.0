From: "Risto Suominen" <risto.suominen@gmail.com>
Subject: Re: [Fwd: Re: Fwd: audio ovolume problem on powerbook
	G3 Lombard (PPC740)]
Date: Tue, 13 Jan 2009 20:37:21 +0200
Message-ID: <46e1c7760901131037r33299b1djcdab22c43dd2046b@mail.gmail.com>
References: <4960D674.60502@googlemail.com>
	<46e1c7760901060930m68c2c7c7v19bf59229f64db24@mail.gmail.com>
	<s5hvdsrsjl9.wl%tiwai@suse.de> <49646391.9030303@googlemail.com>
	<46e1c7760901070741h725674e7g2bbff82ec13d8277@mail.gmail.com>
	<496503D4.2070905@googlemail.com>
	<46e1c7760901071213k11d8716by38c34c4cc742e005@mail.gmail.com>
	<s5h1vvet3go.wl%tiwai@suse.de>
	<46e1c7760901080406g33784a1fo61a8640bde849d66@mail.gmail.com>
	<s5hy6xmrlan.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bw0-f20.google.com (mail-bw0-f20.google.com
	[209.85.218.20]) by alsa0.perex.cz (Postfix) with ESMTP id 7857724134
	for <alsa-devel@alsa-project.org>; Tue, 13 Jan 2009 19:37:23 +0100 (CET)
Received: by bwz13 with SMTP id 13so492301bwz.8
	for <alsa-devel@alsa-project.org>; Tue, 13 Jan 2009 10:37:22 -0800 (PST)
In-Reply-To: <s5hy6xmrlan.wl%tiwai@suse.de>
Content-Disposition: inline
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
Cc: alsa-devel@alsa-project.org, "Richard (MQ)" <osl2008@googlemail.com>
List-Id: alsa-devel@alsa-project.org

2009/1/8 Takashi Iwai <tiwai@suse.de>:
> At Thu, 8 Jan 2009 14:06:05 +0200,
> Risto Suominen wrote:
>>
>> 2009/1/8, Takashi Iwai <tiwai@suse.de>:
>> >
>> > We may use a virtual master control when all slave controls have the
>> >  identical volume resolution.
>> >
>>
>> Sounds good. Is it something configurable, so there is no need to
>> change the code?
>
> Look at sound/core/vmaster.c.
>
>
> Takashi
>

Ok, I've tried to implement this on snd-powermac.

Takashi, looks like there is a side effect: plugging in headphone
doesn't show on alsamixer, even though it works, i.e. the speaker is
silenced. Or have I forgotten something in my implementation?

http://ristosu.wippiespace.com/pub/alsa-awacs-1.0.18a-p13.diff

Richard, maybe you can try this? You should adjust Speaker and Line
out to 100% in order to have full scale in Master.

Risto
