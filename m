From: "jonsmirl@gmail.com" <jonsmirl@gmail.com>
Subject: Re: ASoC MPC5xxx PSC AC97 audio driver
Date: Thu, 8 Sep 2011 06:28:02 -0400
Message-ID: <CAKON4OzsMd0T6KyDK_5P_pz8R5Pax+Bd+f5+00cO5E0OMCYQpQ@mail.gmail.com>
References: <20110908121600.267dee07@archvile>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ww0-f51.google.com (mail-ww0-f51.google.com [74.125.82.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 45986244D8
	for <alsa-devel@alsa-project.org>;
	Thu,  8 Sep 2011 12:28:03 +0200 (CEST)
Received: by wwi18 with SMTP id 18so493316wwi.20
	for <alsa-devel@alsa-project.org>; Thu, 08 Sep 2011 03:28:03 -0700 (PDT)
In-Reply-To: <20110908121600.267dee07@archvile>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: David Jander <david.jander@protonic.nl>
Cc: Grant Likely <grant.likely@secretlab.ca>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Thu, Sep 8, 2011 at 6:16 AM, David Jander <david.jander@protonic.nl> wro=
te:
>
> Dear Jon,

Here's the device tree...
http://git.digispeaker.com/?p=3Ddigispeaker-kernel.git;a=3Dblob;f=3Darch/po=
werpc/boot/dts/dspeak01.dts;h=3D50cc247b4da0eb2bc4deb315b1b5348af87e5979;hb=
=3D9166a4a4141ab7c8d7a7b97fa5b726e11a8d0ca4

Grant can comment on the current bindings.

We switched onto ARM based hardware a couple of years ago. We're
looking the the iMX502 for a current design.


>
> I am busy writing an AC97 ASoC driver for the MPC5121e processor from
> Freescale, and was using your MPC5200 driver as a starting point. I would
> really like to make the driver as unified as possible, but I was encounte=
ring
> some problems that make me think that maybe your driver as included in cu=
rrent
> mainline linux (3.1-rc2 for me atm) is not working anymore. Do you know i=
f it
> is still working?
> Unfortunately I have little experience with ALSA drivers, so I might not
> be doing things entirely in the correct way. Nevertheless I was unable to=
 get
> the driver/device binding working the way you did, and I don't have a MPC=
5200
> platform with AC97 codec to try out your code :-(
>
> Here's what I don't quite get:
>
> mpc5200_dma.c seems to be the proper PCM driver, which has an OF compatib=
le
> string of "fsl,mpc5200-pcm", but I can't find any DTS which declares such=
 a
> node. Apparently the driver is somehow bound by ALSA via the platform name
> "mpc5200-pcm-audio" via the specific fabric drivers, but that seems to ha=
ppen
> in the opposite order than it is supposed to: In my case, first the AC97 =
driver
> is probed (i.e. mpc5200_psc_ac97.c), which expects the driver data to be
> already initialized by the dma part, which it isn't, so the kernel oopses=
 in
> line 288 of mpc5200_psc_ac97.c:
>
> =A0 =A0static int __devinit psc_ac97_of_probe(struct platform_device *op)
> =A0 =A0{
> =A0 =A0 =A0 =A0...
> 287 =A0 =A0 psc_dma =3D dev_get_drvdata(&op->dev);
> 288 =A0 =A0 regs =3D psc_dma->psc_regs;
> 289 =A0 =A0 ac97.private_data =3D psc_dma;
> =A0 =A0 =A0 =A0...
>
> Am I doing something wrong or has this indeed changed in recent versions =
of
> the kernel?
>
> I do have the driver working now, but I had to turn things around and kza=
lloc()
> the drvdata struct "psc_dma" in the AC97 part of the driver. Of course th=
is
> makes unifying the driver quite an ugly job.
>
> Also, currently, my driver is not using DMA, but a work-queue to keep the=
 FIFO
> filled ;-)
>
> To get DMA working, I still need to extend the existing DMA driver which =
can
> only do memory->memory transfers right now. Unfortunately this part is to=
tally
> different from the MPC5200B, which uses a bestcomm DMA controller, so I w=
ould
> like to end up creating a new file "mpc5121_dma.c" and extending
> "mpc5200_psc_ac97.c" so it does the mpc5121e-specific cold-reset. The res=
t is
> basically the same.... except for the fact that I get the oops mentioned =
above
> unless I do the PSC register setup and drvdata allocation in
> psc_ac97_of_probe()! Is this also broken for the MPC5200B and do I need t=
o fix
> it for both?
>
> Also, I'd like to work towards generic fabric code for all the cases of
> "generic AC97 codec connected to a PSC". Maybe this can be OF-ified someh=
ow?
>
> Thanks a lot for any hint.
>
> Best regards,
>
> --
> David Jander
> Protonic Holland.
>



-- =

Jon Smirl
jonsmirl@gmail.com
