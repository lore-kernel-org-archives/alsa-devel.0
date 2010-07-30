From: Adrian Pardini <pardo.bsso@gmail.com>
Subject: Re: [PATCH - usb: Headphone support for cm6206 1/2]
	usb: move snd_usb_cm106_write_int_reg to mixer_quirks.c
Date: Fri, 30 Jul 2010 11:39:45 -0300
Message-ID: <AANLkTi=aaNuyw6xqcX763nBwVGR=SaAhtt6-JSHGcOoX@mail.gmail.com>
References: <201007201942.28942.pardo.bsso@gmail.com>
	<s5hocdpp376.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bw0-f51.google.com (mail-bw0-f51.google.com
	[209.85.214.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 4B8991037EC
	for <alsa-devel@alsa-project.org>;
	Fri, 30 Jul 2010 16:39:46 +0200 (CEST)
Received: by bwz4 with SMTP id 4so844830bwz.38
	for <alsa-devel@alsa-project.org>; Fri, 30 Jul 2010 07:39:46 -0700 (PDT)
In-Reply-To: <s5hocdpp376.wl%tiwai@suse.de>
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

On 30/07/2010, Takashi Iwai <tiwai@suse.de> wrote:
> At Tue, 20 Jul 2010 19:42:28 -0300,
> Adrian Pardini wrote:
>>
>> Hi all, this series of patches adds another control to cm6206 based cards
>> to
>> let the user select wich ouput the "Headphone" jack mirrors. Please
>> review.
>
> You can just remove "static" instead of moving the whole function,
> right?

Aww nuts you are right, sorry about that. Now i'm working with the
mapping of volume controls values, will resend next week when / if
everything works fine.

Thanks.


-- 
Adrian.
http://elesquinazotango.com.ar
http://www.noalcodigodescioli.blogspot.com/
