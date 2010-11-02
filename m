From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: [PATCH] ALSA: add support for disabling period irq
Date: Tue, 2 Nov 2010 08:14:53 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1011020807560.29422@eeebox2.perex-int.cz>
References: <1288649573-31545-1-git-send-email-pierre-louis.bossart@intel.com>
	<alpine.LNX.2.00.1011012325540.29422@eeebox2.perex-int.cz>
	<AANLkTik_9eh2=TkCjTCOoxp5PMtdxpZ6qk7Eio8ABfmd@mail.gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323584-107547989-1288682093=:29422"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (unknown [212.20.107.53])
	by alsa0.perex.cz (Postfix) with ESMTP id 50A331037EC
	for <alsa-devel@alsa-project.org>; Tue,  2 Nov 2010 08:14:54 +0100 (CET)
In-Reply-To: <AANLkTik_9eh2=TkCjTCOoxp5PMtdxpZ6qk7Eio8ABfmd@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: pl bossart <bossart.nospam@gmail.com>
Cc: ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323584-107547989-1288682093=:29422
Content-Type: TEXT/PLAIN; charset=UTF-8; format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Mon, 1 Nov 2010, pl bossart wrote:

> Thanks Jaroslav for this quick review.
>
>> Use one 'if' and a goto behind the last condition to simplify things.
> will do
>
>>> struct snd_interval {
>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0unsigned int min, max;
>>
>> The PCM protocol version should be increased.
>
> Humm, this one I don't understand. I didn't change anything, just used
> a bit in an existing flag? What are you specifically referring to?

Increase subminor in SNDRV_PCM_VERSION . It allows alsa-lib to check if=20
the feature is implemented in the driver (although I admit that this=20
change does not require special checks against the protocol version, but=20
it's standard procedure to change the subminor when the API is extended).

>>> @@ -297,6 +297,7 @@ struct snd_pcm_runtime {
>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0unsigned int info;
>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0unsigned int rate_num;
>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0unsigned int rate_den;
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0bool no_period_irq;
>>
>> I would use an unsigned int bit field rather than bool in this case to m=
ake
>> addition in-line with other structures in this file.
>
> will do.

Thanks.

 =09=09=09=09=09Jaroslav

-----
Jaroslav Kysela <perex@perex.cz>
Linux Kernel Sound Maintainer
ALSA Project, Red Hat, Inc.

--8323584-107547989-1288682093=:29422
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--8323584-107547989-1288682093=:29422--
