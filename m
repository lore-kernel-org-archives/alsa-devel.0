From: pl bossart <bossart.nospam@gmail.com>
Subject: Re: [PATCH] ALSA: add support for disabling period irq
Date: Tue, 2 Nov 2010 07:57:42 -0500
Message-ID: <AANLkTimOUOB0vCJk-3eKdtUsvsASF3OCma_N6cFzNiCY@mail.gmail.com>
References: <1288649573-31545-1-git-send-email-pierre-louis.bossart@intel.com>
	<s5h8w1c18no.wl%tiwai@suse.de>
	<alpine.LNX.2.00.1011020850550.29422@eeebox2.perex-int.cz>
	<s5h4oc016eq.wl%tiwai@suse.de>
	<alpine.LNX.2.00.1011020923430.29422@eeebox2.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-iw0-f179.google.com (mail-iw0-f179.google.com
	[209.85.214.179])
	by alsa0.perex.cz (Postfix) with ESMTP id ABA38244F7
	for <alsa-devel@alsa-project.org>; Tue,  2 Nov 2010 13:57:43 +0100 (CET)
Received: by iwn2 with SMTP id 2so7780521iwn.38
	for <alsa-devel@alsa-project.org>; Tue, 02 Nov 2010 05:57:43 -0700 (PDT)
In-Reply-To: <alpine.LNX.2.00.1011020923430.29422@eeebox2.perex-int.cz>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jaroslav Kysela <perex@perex.cz>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

>>>
>>> #define SNDRV_PCM_INFO_NO_PERIOD_ACK =A0 =A00x00800000 =A0 =A0 =A0/* pe=
riod
>>> transfer acknowledge can be disabled */
>>
>> How about "period update"?
>> I don't mind much how it's called, though...
>
> ACK is smaller, but anything else than IRQ or INTERRUPT sounds good to me.

Anybody against WAKEUP?
