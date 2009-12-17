From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: 2.6.30-rc8 skipping regression also affects cmipci
Date: Thu, 17 Dec 2009 10:46:03 +0800
Message-ID: <4f3252890912161846nee2a6bfmf882a7d7b0200a5a@mail.gmail.com>
References: <hgbiph$4kr$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-px0-f173.google.com (mail-px0-f173.google.com
	[209.85.216.173])
	by alsa0.perex.cz (Postfix) with ESMTP id 8D29D243C7
	for <alsa-devel@alsa-project.org>; Thu, 17 Dec 2009 03:46:05 +0100 (CET)
Received: by pxi3 with SMTP id 3so1109988pxi.16
	for <alsa-devel@alsa-project.org>; Wed, 16 Dec 2009 18:46:04 -0800 (PST)
In-Reply-To: <hgbiph$4kr$1@ger.gmane.org>
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

2009/12/17 Fr=E9d=E9ric Bri=E8re <fbriere@fbriere.net>

> Hi everybody,
>
> I was only recently able to upgrade from 2.6.26 to 2.6.32 (long story).
> In so doing, I noticed infrequent occurrences of audio skipping, which I
> managed to bisect down to c87d973.  It would appear that this commit
> also affects cmipci (CMI8738), albeit not as badly as it did for
> intel8x0.  (I guess I'm the only person left on Earth still using a
> stand-alone PCI sound card, which is why this was never reported.  <g>)
>


http://git.alsa-project.org/?p=3Dalsa-kernel.git;a=3Dcommit;h=3Dc87d9732004=
b3f8fd82d729f12ccfb96c0df279e

The patch seem just fix the problem of the usb audio card in

https://bugtrack.alsa-project.org/alsa-bug/view.php?id=3D4523


This patch actually cause pulseaudio 0.9.14 server abort on my au8830

E: memblock.c: Assertion 'length' failed at pulsecore/memblock.c:356,
function pa_memblock_new_fixed(). Aborting.

https://bugtrack.alsa-project.org/alsa-bug/view.php?id=3D4455#c20892

and the output by using 48000 x 256 Hz Clock in Vortex chip

https://bugtrack.alsa-project.org/alsa-bug/view.php?id=3D4455#c20905


That's why I still stay with the driver come with Fedora 10
2.6.27.41-170.2.117.fc10.i686
