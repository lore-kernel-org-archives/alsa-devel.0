From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: mcasp: stream has more channels (2) than are
 enabled in mcasp (0)
Date: Tue, 19 Apr 2016 10:00:05 +0300
Message-ID: <5715D775.8030303@ti.com>
References: <14D46C39-5FDF-40DD-A16B-2DA7BDE930CB@latencyzero.com>
 <5714FEE5.5070002@ti.com>
 <5D6815AB-B3DF-4F4F-BC0D-33612A202975@latencyzero.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from devils.ext.ti.com (devils.ext.ti.com [198.47.26.153])
 by alsa0.perex.cz (Postfix) with ESMTP id EB9FA2651DB
 for <alsa-devel@alsa-project.org>; Tue, 19 Apr 2016 09:00:12 +0200 (CEST)
In-Reply-To: <5D6815AB-B3DF-4F4F-BC0D-33612A202975@latencyzero.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Rick Mann <rmann@latencyzero.com>
Cc: Alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On 04/19/16 03:25, Rick Mann wrote:
> Thanks for the suggestions, Peter, I really appreciate the help. Here's
> what I get:
> =

> [  256.743991] davinci-mcasp 48038000.mcasp: Slots: 2,
> max_active_serializers: 1, active_serializers: 0, channels: 2
> =

> I rebuilt the 4.4.7-bone-rt-r9 kernel using Robert C Nelson's bb-kernel
> repo scripts. I modified sound/soc/davinci/davinci-mcasp.c to print some
> diagnostics. Rebooted, then executed the following. Note that
> BB-BONE-AUDI-02.dts is
> <https://github.com/RobertCNelson/bb.org-overlays/blob/master/src/arm/BB-=
BONE-AUDI-02-00A0.dts>,
> and the base DTB is <http://pastebin.com/5vVEdAKt>:

Looks OK.

FWIW: I have the following patch on top of linux-next to get the BBW's
AudioCape RevA working:
https://github.com/omap-audio/linux-audio/commit/37d2421c321762360a6982b371=
07b617b0f74bee

> $ sudo su # echo BB-BONE-AUDI-02 > $SLOTS # aplay -l **** List of PLAYBACK
> Hardware Devices **** card 0: B [AudioCape Rev B], device 0:
> davinci-mcasp.0-tlv320aic3x-hifi tlv320aic3x-hifi-0 [] Subdevices: 1/1 =

> Subdevice #0: subdevice #0 # speaker-test
> =

> speaker-test 1.0.28
> =

> Playback device is default Stream parameters are 48000Hz, S16_LE, 1
> channels Using 16 octaves of pink noise Rate set to 48000Hz (requested
> 48000Hz) Buffer size range from 16 to 32768 Period size range from 8 to
> 16384 Using max buffer size 32768 Periods =3D 4 Unable to set hw params f=
or
> playback: Invalid argument Setting of hwparams failed: Invalid argument
> =

> speaker-test caused the following to be logged:
> =

> [  256.743991] davinci-mcasp 48038000.mcasp: Slots: 2,
> max_active_serializers: 1, active_serializers: 0, channels: 2

Now this is odd... Can you print also the mcasp->num_serializer here? If it=
 is
0, then something really strange is going on.
We set this up in davinci_mcasp_set_pdata_from_of() when reading the
serial-dir array.

> [256.754343] davinci-mcasp 48038000.mcasp: ASoC: can't set 48038000.mcasp=
 hw
> params: -22
> =

> =

> Full logs:
> =

> http://pastebin.com/HGhu9CPk
> =

> =

> =

> =



-- =

P=E9ter
