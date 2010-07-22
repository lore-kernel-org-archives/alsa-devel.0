From: <matti.j.aaltonen@nokia.com>
Subject: Re: [PATCH v2 0/1] *** SUBJECT HERE ***
Date: Thu, 22 Jul 2010 13:37:06 +0200
Message-ID: <A1C7E76B4973664FBB6C554A75234AC62BEEEB72A6@NOK-EUMSG-02.mgdnok.nokia.com>
References: <1279791534-20028-1-git-send-email-matti.j.aaltonen@nokia.com>
	<20100722094832.GC4737@rakim.wolfsonmicro.main>
	<A1C7E76B4973664FBB6C554A75234AC62BEEEB72A5@NOK-EUMSG-02.mgdnok.nokia.com>,
	<201007221425.20270.peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx03.nokia.com (smtp.nokia.com [192.100.122.230])
	by alsa0.perex.cz (Postfix) with ESMTP id 3040E2435F
	for <alsa-devel@alsa-project.org>;
	Thu, 22 Jul 2010 13:37:26 +0200 (CEST)
In-Reply-To: <201007221425.20270.peter.ujfalusi@nokia.com>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: peter.ujfalusi@nokia.com
Cc: alsa-devel@alsa-project.org, broonie@opensource.wolfsonmicro.com, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

Hi.

________________________________________
>From: Ujfalusi Peter (Nokia-MS/Tampere)
>Sent: Thursday, July 22, 2010 1:25 PM
>To: Aaltonen Matti.J (Nokia-MS/Tampere)
>Cc: ext Mark Brown; alsa-devel@alsa-project.org; lrg@slimlogic.co.uk
>Subject: Re: [PATCH v2 0/1] *** SUBJECT HERE ***
>
>On Thursday 22 July 2010 14:18:32 Aaltonen Matti.J (Nokia-MS/Tampere) wrot=
e:
>> >Could you please be a little more specific - what do you mean when you
>> >say "the CODEC stopped working?  The set_dai_fmt() function has always
>> >been optional.
>>
>> I get this error message:
>>
>> aplay  -f dat -Dhw:wl1273 /root/sumppi.wav
>> [  297.179626] Can't set codec DAI configuration: -22
>> [  297.184539] asoc: BT/FM PCM startup failed
>
>If you remove the wl1273_set_dai_fmt, than you should not call
>snd_soc_dai_set_fmt(codec_dai, ...); in the machine driver.
>
>The snd_soc_dai_set_fmt checks, if the codec provides the callback, and if=
 it is
>missing, than it returns -EINVAL.

Yes, I fixed the soc_card driver and now it works.

Thank you...

Matti A.

>--
>P=E9ter
