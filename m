From: giggzounet <giggzounet@gmail.com>
Subject: Re: [Regression] With the new 2.6.33 when I plug in
 headphones, the speakers don't turn off anymore
Date: Fri, 26 Feb 2010 12:15:01 +0100
Message-ID: <hm8afm$shn$2@dough.gmane.org>
References: <hm82oh$1am$1@dough.gmane.org>	<1267176828.3751.12.camel@mattotaupa>
	<hm8aat$shn$1@dough.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from lo.gmane.org (lo.gmane.org [80.91.229.12])
	by alsa0.perex.cz (Postfix) with ESMTP id DBD12103806
	for <alsa-devel@alsa-project.org>; Fri, 26 Feb 2010 12:20:10 +0100 (CET)
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <glad-alsa-devel-2@m.gmane.org>) id 1NkyEm-0007lO-2K
	for alsa-devel@alsa-project.org; Fri, 26 Feb 2010 12:20:04 +0100
Received: from celsius02.unibw-hamburg.de ([139.11.215.121])
	by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Fri, 26 Feb 2010 12:20:04 +0100
Received: from giggzounet by celsius02.unibw-hamburg.de with local (Gmexim 0.1
	(Debian)) id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Fri, 26 Feb 2010 12:20:04 +0100
In-Reply-To: <hm8aat$shn$1@dough.gmane.org>
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

[snip]

>> I do not know why enable_msi is set to =BB-1=AB and not one since it sho=
uld
>> be enabled by default now [1]. Could you try to load the sound module
>> with `enable_msi` set to `0` and report back your findings, please.
>>
>>         $ sudo modinfo snd-hda-intel
>>         [=85]
>>         parm:           enable_msi:Enable Message Signaled Interrupt (MS=
I) (int)
>>         [=85]
>>
> =

> I have modified /etc/modprobe.d/sound with :
> snd-hda-intel index=3D0 enable_msi=3D0
> =

> I attach the log of alsa-info.
> =


I have forgotten to say that the problem is always here with
enable_msi=3D0

[snip]
