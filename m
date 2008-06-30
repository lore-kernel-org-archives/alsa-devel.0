From: "Kan-I Jyo" <cecilhsujp@gmail.com>
Subject: Re: [Fwd: [Alsa-user] Intel Poulsbo(SCH) chipset does
	not recognize Adi 1986 codec under linux]]
Date: Mon, 30 Jun 2008 22:20:17 +0900
Message-ID: <1e8a3dd0806300620i2be727afibc932c1df6744f7f@mail.gmail.com>
References: <1e8a3dd0806241840m76069ad8sa35058ad8ddb843b@mail.gmail.com>
	<s5hprq5onxz.wl%tiwai@suse.de>
	<1e8a3dd0806250500p6f7a343u89b11d42f556347@mail.gmail.com>
	<s5hhcbhogef.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from fk-out-0910.google.com (fk-out-0910.google.com [209.85.128.187])
	by alsa0.perex.cz (Postfix) with ESMTP id 4A58F246EC
	for <alsa-devel@alsa-project.org>;
	Mon, 30 Jun 2008 15:20:18 +0200 (CEST)
Received: by fk-out-0910.google.com with SMTP id b27so1409946fka.0
	for <alsa-devel@alsa-project.org>; Mon, 30 Jun 2008 06:20:17 -0700 (PDT)
In-Reply-To: <s5hhcbhogef.wl%tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Dear Takashi,

Thank you for your kind help all the time.

2008/6/25 Takashi Iwai <tiwai@suse.de>:
> The hardware sets the corresponding bits to this register when the
> codec is found on the slot.  So, this seems really like a hardware
> problem.

For all my try these days have all led to a non-working audio device,
I can not help thinking the high possibility of a hardware problem.
Just want to make sure that I have made good efforts before blaming on
hardware side.

>
> Or, if it's a timing issue, you can try to add some delays in
> azx_reset()...

Considering this kind of issue, I have increased the "msleep" in
azx_reset() from 1 to 1000.
With no luck, stiil there the "no codecs found" message.

Moreover, I have changed the "msleep" to "ssleep" with a even larger
value. As you may have expected, no recognization of the ADi 1986A
codec at all.

Though there might be no much left for trying, I just want to make
sure that I did not miss any import part.
And I would like say thank you as well for your timely advetise.

-- 
Sincerely,

Jyo
