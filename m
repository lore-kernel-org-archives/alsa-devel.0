From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: mcasp: stream has more channels (2) than are
 enabled in mcasp (0)
Date: Tue, 19 Apr 2016 14:17:36 +0300
Message-ID: <571613D0.9060102@ti.com>
References: <14D46C39-5FDF-40DD-A16B-2DA7BDE930CB@latencyzero.com>
 <5714FEE5.5070002@ti.com>
 <5D6815AB-B3DF-4F4F-BC0D-33612A202975@latencyzero.com>
 <5715D775.8030303@ti.com>
 <DFF31AA6-67AF-429A-B108-6544180038F2@latencyzero.com>
 <5715E008.9000500@ti.com>
 <8D9D43D4-9239-4630-AF46-4732C97DBC42@latencyzero.com>
 <5715EE36.60906@ti.com>
 <7817DD4F-6BD2-4EBE-8AA6-CBC595B1FBBF@latencyzero.com>
 <5715F8CF.5000101@ti.com>
 <65C7800B-EB96-4407-9174-488B368A890B@latencyzero.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from comal.ext.ti.com (comal.ext.ti.com [198.47.26.152])
 by alsa0.perex.cz (Postfix) with ESMTP id 0DBF32665C8
 for <alsa-devel@alsa-project.org>; Tue, 19 Apr 2016 13:17:40 +0200 (CEST)
In-Reply-To: <65C7800B-EB96-4407-9174-488B368A890B@latencyzero.com>
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

On 04/19/16 12:32, Rick Mann wrote:
>> Interesting, why an include file called am33xx-overlay-edma-fix.dtsi wou=
ld
>> enable spi and mcasp??? What it is fixing regarding to eDMA?
> =

> I wish I knew. I've often wished they'd put a block of text
> at the start of each of these files explaining their existence.

The commit message is not much talkative either :(

>>> If I understand what you're saying, this is causing the driver to load
>>> before other things have been set in the DT, and they should be moved
>>> to later, perhaps in the overlay? In fact, the overlay (which gets load=
ed
>>> after login) does also set the mcasp0 to "okay" (I think):
>>
>> Yes, since the DT blob you are booting with have mcasp0/1 enabled, the d=
river
>> will load using the boot DTB. You later patch the DTB, but the driver is
>> already loaded so it will have no effect to the driver.
> =

> Okay, that makes sense.
> =

> Should I be able to make a single, combined DTB that's loaded
> at boot, and have it work, not worrying about where in the DTB the mcasp0=
/1
> are enabled? Or do I still want the status=3D"okay" to appear no earlier =
than
> the specific mcasp configuration?

You can make a static DTS file and not to use the DT overlay support - I'm
doing this with linux-next.

The important thing is to only enable the mcasp node when you add the needed
setup to it. You can have it in the overlay, but enable only in one place.

>>
>>> https://github.com/RobertCNelson/bb.org-overlays/blob/master/src/arm/BB=
-BONE-AUDI-02-00A0.dts#L72
>>>
>>> I rebuilt the .dtb by commenting out the enabling of the macasp0/1 in
>>> that .dtsi, and now it seems to work! davinci_mcasp_probe is entered
>>> when I apply the overlay, and I get this logged:
>>>
>>> [   35.868324] davinci-mcasp 48038000.mcasp: davinci_mcasp_probe: enter
>>> [   35.874741] davinci-mcasp 48038000.mcasp: serial-dir: 64
>>> [   43.469254] davinci-mcasp 48038000.mcasp: Slots: 2,
>>> 	max_active_serializers: 1, active_serializers: 1,
>>> 	channels: 2, mcasp->num_serializer: 16
>>> [   78.846314] davinci-mcasp 48038000.mcasp: Slots: 2,
>>> 	max_active_serializers: 1, active_serializers: 1,
>>> 	channels: 2, mcasp->num_serializer: 16
>>
>> Great!
> =

> Should I change the DT to use only four serializers? I noticed that
> a) your DTS doesn't specify the number of serializers explicitly,
> and b) has the active/inactive ones set differently from mine:
> =

> https://github.com/RobertCNelson/bb.org-overlays/blob/master/src/arm/BB-B=
ONE-AUDI-02-00A0.dts#L75
> =

>>
>>> By default, speaker-test only outputs to the left channel, and I get
>>> noise out that channel. If I invoke speaker-test -c 2, it claims to
>>> cycle between Front Left and Front Right, but there is only silence
>>> out the Front Right. This is probably due to issues in asound.state,
>>> right (I'd sure love some help getting that straightened out)?
>>
>> I'll try to take a look at the speaker-test, it should work fine AFAIK.
> =

> Yeah, I don't think the problem is in speaker-test, per se. I think it's
> in the ALSA configuration, or perhaps the routing entries in the DTB?

speaker-test will output noise by default.
speaker-test -c2 -t wav # will play samples to each channel

I have spent an hour to figure out why the channels are swapped for me using
the AudioCapeA1... The jack connector is wired up wrongly Left -> Right, Ri=
ght
-> Left. Aaargh.

Take a look at the alsamixer or start with no asound.state, the after reset
configuration should be fine for the codec to output stereo on the headphon=
e.

-- =

P=E9ter
