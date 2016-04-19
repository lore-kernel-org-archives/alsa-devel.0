From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: mcasp: stream has more channels (2) than are
 enabled in mcasp (0)
Date: Tue, 19 Apr 2016 10:36:40 +0300
Message-ID: <5715E008.9000500@ti.com>
References: <14D46C39-5FDF-40DD-A16B-2DA7BDE930CB@latencyzero.com>
 <5714FEE5.5070002@ti.com>
 <5D6815AB-B3DF-4F4F-BC0D-33612A202975@latencyzero.com>
 <5715D775.8030303@ti.com>
 <DFF31AA6-67AF-429A-B108-6544180038F2@latencyzero.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bear.ext.ti.com (bear.ext.ti.com [192.94.94.41])
 by alsa0.perex.cz (Postfix) with ESMTP id BFDA02651DB
 for <alsa-devel@alsa-project.org>; Tue, 19 Apr 2016 09:36:45 +0200 (CEST)
In-Reply-To: <DFF31AA6-67AF-429A-B108-6544180038F2@latencyzero.com>
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

On 04/19/16 10:18, Rick Mann wrote:
> =

>> On Apr 19, 2016, at 00:00 , Peter Ujfalusi <peter.ujfalusi@ti.com>
>> wrote:
>> =

>> On 04/19/16 03:25, Rick Mann wrote:
>>> Thanks for the suggestions, Peter, I really appreciate the help.
>>> Here's what I get:
>>> =

>>> [  256.743991] davinci-mcasp 48038000.mcasp: Slots: 2, =

>>> max_active_serializers: 1, active_serializers: 0, channels: 2
>>> =

>>> I rebuilt the 4.4.7-bone-rt-r9 kernel using Robert C Nelson's
>>> bb-kernel repo scripts. I modified sound/soc/davinci/davinci-mcasp.c to
>>> print some diagnostics. Rebooted, then executed the following. Note
>>> that BB-BONE-AUDI-02.dts is =

>>> <https://github.com/RobertCNelson/bb.org-overlays/blob/master/src/arm/B=
B-BONE-AUDI-02-00A0.dts>,
>>>
>>> =

and the base DTB is <http://pastebin.com/5vVEdAKt>:
>> =

>> Looks OK.
>> =

>> FWIW: I have the following patch on top of linux-next to get the BBW's =

>> AudioCape RevA working: =

>> https://github.com/omap-audio/linux-audio/commit/37d2421c321762360a6982b=
37107b617b0f74bee
>
>> =

> Interesting, I'll look at that when I start modifying the DTS again. I see
> that uses the '3106. My own cape has the '3104 on it, which is why I'm
> trying to get the AudioCape RevB working (my cape has additional GPIOs
> controlling regulators and resets that I'll have to accommodate).
>> =

>>> $ sudo su # echo BB-BONE-AUDI-02 > $SLOTS # aplay -l **** List of
>>> PLAYBACK Hardware Devices **** card 0: B [AudioCape Rev B], device 0: =

>>> davinci-mcasp.0-tlv320aic3x-hifi tlv320aic3x-hifi-0 [] Subdevices: 1/1
>>>  Subdevice #0: subdevice #0 # speaker-test
>>> =

>>> speaker-test 1.0.28
>>> =

>>> Playback device is default Stream parameters are 48000Hz, S16_LE, 1 =

>>> channels Using 16 octaves of pink noise Rate set to 48000Hz (requested =

>>> 48000Hz) Buffer size range from 16 to 32768 Period size range from 8
>>> to 16384 Using max buffer size 32768 Periods =3D 4 Unable to set hw
>>> params for playback: Invalid argument Setting of hwparams failed:
>>> Invalid argument
>>> =

>>> speaker-test caused the following to be logged:
>>> =

>>> [  256.743991] davinci-mcasp 48038000.mcasp: Slots: 2, =

>>> max_active_serializers: 1, active_serializers: 0, channels: 2
>> =

>> Now this is odd... Can you print also the mcasp->num_serializer here? If
>> it is 0, then something really strange is going on. We set this up in
>> davinci_mcasp_set_pdata_from_of() when reading the serial-dir array.
> =

> Yup, seems like it's 0:
> =

> [   67.876673] davinci-mcasp 48038000.mcasp: Slots: 2,
> max_active_serializers: 1, active_serializers: 0, channels: 2,
> mcasp->num_serializer: 0 [   67.889362] davinci-mcasp 48038000.mcasp: ASo=
C:
> can't set 48038000.mcasp hw params: -22

How can it be?
can you take a look of the davinci_mcasp_set_pdata_from_of() function where
the serial-dir is set up? Do we get the of_serial_dir32? What is the size of
the array we got (val)?

BTW: can you check your mail client to wrap the lines around 78 characters?

-- =

P=E9ter
