From: Daniel Mack <zonque@gmail.com>
Subject: Re: How to add a new MIDI device to the usbaudio driver
Date: Wed, 24 Aug 2011 14:05:16 +0200
Message-ID: <CACTFLAPWTtGvmWbjSnfTMBud55MoY-pSx2vqRMF=NT_6vOqnMg@mail.gmail.com>
References: <4E5234F0.8000502@amlie.name>
	<CACTFLAMA08qqaNALA1dksxVN_yAwXnONxXadeuUb1Owkz6VwsA@mail.gmail.com>
	<4E52401C.8030605@amlie.name> <4E537524.9010303@ladisch.de>
	<4E537BE9.4050004@amlie.name>
	<CACTFLAPzug5yxmhxDKocdLt-eoHXr6nOwmyOqWkEJ_vjqNff6w@mail.gmail.com>
	<4E53959A.7090702@amlie.name> <4E54E437.7020209@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pz0-f43.google.com (mail-pz0-f43.google.com
	[209.85.210.43]) by alsa0.perex.cz (Postfix) with ESMTP id 87592249FC
	for <alsa-devel@alsa-project.org>;
	Wed, 24 Aug 2011 14:05:18 +0200 (CEST)
Received: by pzk1 with SMTP id 1so739773pzk.2
	for <alsa-devel@alsa-project.org>; Wed, 24 Aug 2011 05:05:17 -0700 (PDT)
In-Reply-To: <4E54E437.7020209@ladisch.de>
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

On Wed, Aug 24, 2011 at 1:44 PM, Clemens Ladisch <clemens@ladisch.de> wrote:
> This is not MIDI. =A0However, these value might by explained by
> a 31250-baud signal sampled at 38400 baud.
>
>> Daniel Mack wrote:
>> > I think that requires a special divider setup that is not
>> > supported by the ftdi_sio driver.
>
> Indeed.

OTOH - the devices only produces MIDI events internally, so there's
actually no evidence that it operates at 31250 baud. It could be
anything else. Kristian, I think you need to investigate a little more
:)


Daniel
