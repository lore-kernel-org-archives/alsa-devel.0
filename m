From: loody <miloody@gmail.com>
Subject: Re: how to create alsa nodes?
Date: Fri, 18 Mar 2011 17:03:36 +0800
Message-ID: <AANLkTi=0SKc+2vUH=DV+c1Vm5NwoeAcHMac=tdyi4E8w@mail.gmail.com>
References: <AANLkTinUA1R-oGhQwykLiY0j7-MoB=4oJBMT=PQUTzY4@mail.gmail.com>
	<4D821A18.30407@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-iw0-f179.google.com (mail-iw0-f179.google.com
	[209.85.214.179])
	by alsa0.perex.cz (Postfix) with ESMTP id EA06424453
	for <alsa-devel@alsa-project.org>; Fri, 18 Mar 2011 10:03:37 +0100 (CET)
Received: by iwc10 with SMTP id 10so3898075iwc.38
	for <alsa-devel@alsa-project.org>; Fri, 18 Mar 2011 02:03:36 -0700 (PDT)
In-Reply-To: <4D821A18.30407@ladisch.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Clemens Ladisch <clemens@ladisch.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

hi:

2011/3/17 Clemens Ladisch <clemens@ladisch.de>:
> loody wrote:
>> In destop x86 system, the udev will automatically create the nodes in
>> snd directory, such as pcmC0D0c, pcmC0D1c, etc.
>> I try to let the usb sound device work on mips platform, but I have no
>> idea what is the proper way to create these nodes.
>> Should I
>> 1. create them one by one by hand =A0from copying the attributes in my PC
>> =A0 =A0 (if I have 2 or more usb sound devices, I have to first plug them
>> in pc and monitor the nodes)
>
> This will not work if the device nodes' minor numbers are allocated
> dynamically.
>
>> 2. smarter way to do so?
>
> GregKH would tell you that the smart way would be to run udev. =A0;-)
>
> To use static device nodes,
> 1) make sure that CONFIG_SND_DYNAMIC_MINORS is disabled,
> 2) use the snddevices script in the alsa-driver package.
>
it works, thank U :-)
miloody
