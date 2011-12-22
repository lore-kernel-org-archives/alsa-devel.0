From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: how to enumerate useful ALSA devices?
Date: Thu, 22 Dec 2011 14:27:49 +0800
Message-ID: <CAN8cciYWLPDQ5-1nXWQt91Y_+u1WYDcNCFJduNqvND2u7nw+hQ@mail.gmail.com>
References: <8E4C156DA5797D418DBFADFD8CE655A4153362B9D3@HE113481.emea1.cds.t-internal.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ww0-f41.google.com (mail-ww0-f41.google.com [74.125.82.41])
	by alsa0.perex.cz (Postfix) with ESMTP id B6F3E103C76
	for <alsa-devel@alsa-project.org>; Thu, 22 Dec 2011 07:27:52 +0100 (CET)
Received: by wgbdt12 with SMTP id dt12so10706819wgb.2
	for <alsa-devel@alsa-project.org>; Wed, 21 Dec 2011 22:27:50 -0800 (PST)
In-Reply-To: <8E4C156DA5797D418DBFADFD8CE655A4153362B9D3@HE113481.emea1.cds.t-internal.com>
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

2011/12/21, Joerg-Cyril.Hoehle@t-systems.com <Joerg-Cyril.Hoehle@t-systems.=
com>:
> Hi,
>
> The 2008 audio guide recommends
> http://0pointer.de/blog/projects/guide-to-sound-apis.html
> "Do not use the snd_card_xxx() APIs. For enumerating use
>  snd_device_name_hint() (and related functions).
>  snd_card_xxx() is obsolete... Bluetooth audio are not included"
>
> Is that correct advice?

The only correct item is "Bluetooth audio are not included"

AFAIK, snd_card_xxx() is not obsoleted


>
> Wine still uses snd_card, so it knows only about "default" and
> "plughw:x,y".  I believe that's wrong but don't know what should be
> used instead in order not to come up with a long list of artificial
> names mentioned in /usr/share/alsa/alsa.conf such as surround51 when
> the poor on-board card knows nothing but 16 bit stereo.
>

For those MATX size motherboard with 3 audio jacks at rear panel or
those high-end notebook with 3 or 4 jacks

the user need to use "channel mode" or "smart5.1" to retask the two
input pins for output for surroun51

http://git.alsa-project.org/?p=3Dalsa-kernel.git;a=3Dblob_plain;f=3DDocumen=
tation/sound/alsa/HD-Audio-Controls.txt

do wine need AC3 pass-though SPDIF ? ( IEC958 )

It is still not clear how to find a valid HDMI device ?


> I'm looking for a list of working devices on this machine, which likely
> should contain "default" (usually leading to PA on a recent Ubuntu
> machine),
> "plug:dmix" (PA getting out of the way when trying to use other devices),
> "hw:0,0" and presumably not much more.
>
> Thank you for your help,
> 	J=F6rg H=F6hle
