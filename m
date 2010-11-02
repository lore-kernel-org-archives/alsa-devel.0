From: pl bossart <bossart.nospam@gmail.com>
Subject: Re: [PATCH] ALSA: add support for disabling period irq
Date: Mon, 1 Nov 2010 19:16:42 -0500
Message-ID: <AANLkTik_9eh2=TkCjTCOoxp5PMtdxpZ6qk7Eio8ABfmd@mail.gmail.com>
References: <1288649573-31545-1-git-send-email-pierre-louis.bossart@intel.com>
	<alpine.LNX.2.00.1011012325540.29422@eeebox2.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-iw0-f179.google.com (mail-iw0-f179.google.com
	[209.85.214.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 92CD110385E
	for <alsa-devel@alsa-project.org>; Tue,  2 Nov 2010 01:16:45 +0100 (CET)
Received: by iwn2 with SMTP id 2so7034791iwn.38
	for <alsa-devel@alsa-project.org>; Mon, 01 Nov 2010 17:16:42 -0700 (PDT)
In-Reply-To: <alpine.LNX.2.00.1011012325540.29422@eeebox2.perex-int.cz>
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
Cc: ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Thanks Jaroslav for this quick review.

> Use one 'if' and a goto behind the last condition to simplify things.
will do

>> struct snd_interval {
>> =A0 =A0 =A0 =A0unsigned int min, max;
>
> The PCM protocol version should be increased.

Humm, this one I don't understand. I didn't change anything, just used
a bit in an existing flag? What are you specifically referring to?

>> @@ -297,6 +297,7 @@ struct snd_pcm_runtime {
>> =A0 =A0 =A0 =A0unsigned int info;
>> =A0 =A0 =A0 =A0unsigned int rate_num;
>> =A0 =A0 =A0 =A0unsigned int rate_den;
>> + =A0 =A0 =A0 =A0bool no_period_irq;
>
> I would use an unsigned int bit field rather than bool in this case to ma=
ke
> addition in-line with other structures in this file.

will do.
-Pierre
