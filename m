From: Felix Homann <linuxaudio@showlabor.de>
Subject: Re: Alsa Support for Korg Pandora Mini, Vox ToneLab ST
Date: Mon, 16 May 2011 14:57:16 +0200
Message-ID: <4DD11F2C.2010500@showlabor.de>
References: <BANLkTikGDzzhXQLTpsHvqqJ=b30JgkumJQ@mail.gmail.com>	<BANLkTinXgstKju=8-Ow7o542-zZxvKZdTQ@mail.gmail.com>	<loom.20110514T184918-282@post.gmane.org>	<BANLkTi=uT5xEJ1xtOqXFqPAH6ghRcJhEhg@mail.gmail.com>	<BANLkTimWe6OJjRLjNFKKSKyPuSjuZcBLgQ@mail.gmail.com>	<BANLkTin7JRp6wZeX049Atqn+zmZdkQ1vGQ@mail.gmail.com>	<BANLkTikUS1qcLa_OdCkW68cwFLRB7qqFbg@mail.gmail.com>	<BANLkTinUrXN6KiYLOT=F=jdPmn=2t5F5OQ@mail.gmail.com>
	<BANLkTikjU3KiL9HJJSwjHQ8qO-eLG3HWzQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from vwp5738.webpack.hosteurope.de (vwp5738.webpack.hosteurope.de
	[83.169.30.203])
	by alsa0.perex.cz (Postfix) with ESMTP id 66720103828
	for <alsa-devel@alsa-project.org>;
	Mon, 16 May 2011 14:57:21 +0200 (CEST)
In-Reply-To: <BANLkTikjU3KiL9HJJSwjHQ8qO-eLG3HWzQ@mail.gmail.com>
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

Hi Daniel,

I've just stumbled across this thread and saw that it relates to the =

Fast Track Ultra devices. I wanted to give your patch a try but the =

combination of alsa-driver/alsa-kernel from git won't build at the =

moment (error: implicit declaration of function =

'fw_iso_resource_manage'). I let you know about the patch when this =

issue is resolved!

Regards,

Felix

Am 16.05.2011 08:56, schrieb Daniel Mack:
> 2011/5/15 Daniel Mack<zonque@gmail.com>:
>> 2011/5/14 Fr=E9d=E9ric Jaume<frederic.jaume@gmail.com>:
>>> Hi!
>>>
>>> Here's the "lsusb -v" for the Korg Pandora PX5D, attached. Hope this he=
lps.
>> The MIDI part of the descriptors is clearly marked as vendor specific,
>> so there is nothing the driver can do about this, except for adding a
>> quirk.
>>
>> Assuming the MIDI interface is class compliant, the following patch
>> should help. Can you give it a try?
> For the Pandora PX5D, we also have to use the USB_DEVICE_VENDOR_SPEC
> macro, so the class compliant audio interfaces are not ignored by
> adding the quirk.
>
> Daniel
>
>
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
