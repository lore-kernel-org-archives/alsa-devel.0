From: giggz <giggzounet@gmail.com>
Subject: Re: [Regression] With the new 2.6.33 when I plug in
 headphones, the speakers don't turn off anymore
Date: Sat, 27 Feb 2010 14:29:05 +0100
Message-ID: <hmb6ib$utb$1@dough.gmane.org>
References: <hm82oh$1am$1@dough.gmane.org>	<1267176828.3751.12.camel@mattotaupa>	<hm8aat$shn$1@dough.gmane.org>
	<hm8afm$shn$2@dough.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from lo.gmane.org (lo.gmane.org [80.91.229.12])
	by alsa0.perex.cz (Postfix) with ESMTP id 6B12D10382D
	for <alsa-devel@alsa-project.org>; Sat, 27 Feb 2010 14:26:53 +0100 (CET)
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <glad-alsa-devel-2@m.gmane.org>) id 1NlMgz-0001MC-Fr
	for alsa-devel@alsa-project.org; Sat, 27 Feb 2010 14:26:49 +0100
Received: from c165127.adsl.hansenet.de ([213.39.165.127])
	by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Sat, 27 Feb 2010 14:26:49 +0100
Received: from giggzounet by c165127.adsl.hansenet.de with local (Gmexim 0.1
	(Debian)) id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Sat, 27 Feb 2010 14:26:49 +0100
In-Reply-To: <hm8afm$shn$2@dough.gmane.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

giggzounet a =E9crit :
> [snip]
> =

>>> I do not know why enable_msi is set to =BB-1=AB and not one since it sh=
ould
>>> be enabled by default now [1]. Could you try to load the sound module
>>> with `enable_msi` set to `0` and report back your findings, please.
>>>
>>>         $ sudo modinfo snd-hda-intel
>>>         [=85]
>>>         parm:           enable_msi:Enable Message Signaled Interrupt (M=
SI) (int)
>>>         [=85]
>>>
>> I have modified /etc/modprobe.d/sound with :
>> snd-hda-intel index=3D0 enable_msi=3D0
>>
>> I attach the log of alsa-info.
>>
> =

> I have forgotten to say that the problem is always here with
> enable_msi=3D0
> =

> [snip]

I have tested with enable_msi=3D1. I always have the problem with the
headphone and speakers. But I don't know why I don't get enable_msi=3D1
automaticly, because it seems to work fine.
