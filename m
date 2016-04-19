From: Rick Mann <rmann@latencyzero.com>
Subject: Re: mcasp: stream has more channels (2) than are
	enabled in mcasp (0)
Date: Tue, 19 Apr 2016 02:32:45 -0700
Message-ID: <65C7800B-EB96-4407-9174-488B368A890B@latencyzero.com>
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
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com
 [66.111.4.26]) by alsa0.perex.cz (Postfix) with ESMTP id C51BE26581B
 for <alsa-devel@alsa-project.org>; Tue, 19 Apr 2016 11:32:46 +0200 (CEST)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
 by mailout.nyi.internal (Postfix) with ESMTP id 60A3E20853
 for <alsa-devel@alsa-project.org>; Tue, 19 Apr 2016 05:32:46 -0400 (EDT)
In-Reply-To: <5715F8CF.5000101@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: Alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org


> On Apr 19, 2016, at 02:22 , Peter Ujfalusi <peter.ujfalusi@ti.com> wrote:
> 
> On 04/19/16 12:04, Rick Mann wrote:
>> 
>>> On Apr 19, 2016, at 01:37 , Peter Ujfalusi <peter.ujfalusi@ti.com> wrote:
>>> 
>>> You can try to remove the mcasp module, do the DT fragment magic, reload the
>>> mcasp driver if it is not loaded automatically.
>> 
>> I don't quite understand how to do what you're suggesting here.
> 
> rmmod snd-soc-davinci-mcasp
> ...
> DT patching
> ...
> modprobe snd-soc-davinci-mcasp

Ah, straightforward enough. Thanks.

>>> But if you want to get it working properly you need to find the dts(i) file
>>> which set the mcasp0 and mcasp1 nodes to status = "okay";
>>> In upstream we do not do this, so it must come from the bone changes.
>> 
>> The DTB (prior to the BB-BONE-AUDI-02 overlay) starts with this file:
>> 
>> 	http://pastebin.com/5vVEdAKt
>> 
>> That file first includes the following files in this order, before adding
>> its own entries (sorry about the line length):
>> 
>> https://github.com/RobertCNelson/dtb-rebuilder/blob/4.4.x/src/arm/am33xx.dtsi
>> https://github.com/RobertCNelson/dtb-rebuilder/blob/4.4.x/src/arm/am33xx-es2.dtsi
>> https://github.com/RobertCNelson/dtb-rebuilder/blob/4.4.x/src/arm/am335x-bone-common.dtsi
>> https://github.com/RobertCNelson/dtb-rebuilder/blob/4.4.x/src/arm/am33xx-overlay-edma-fix.dtsi
>> 
>> The last of these files sets spi0, spi1, mcasp0, mcasp1 to "okay".
> 
> Interesting, why an include file called am33xx-overlay-edma-fix.dtsi would
> enable spi and mcasp??? What it is fixing regarding to eDMA?

I wish I knew. I've often wished they'd put a block of text
at the start of each of these files explaining their existence.

> 
>> If I understand what you're saying, this is causing the driver to load
>> before other things have been set in the DT, and they should be moved
>> to later, perhaps in the overlay? In fact, the overlay (which gets loaded
>> after login) does also set the mcasp0 to "okay" (I think):
> 
> Yes, since the DT blob you are booting with have mcasp0/1 enabled, the driver
> will load using the boot DTB. You later patch the DTB, but the driver is
> already loaded so it will have no effect to the driver.

Okay, that makes sense.

Should I be able to make a single, combined DTB that's loaded
at boot, and have it work, not worrying about where in the DTB the mcasp0/1
are enabled? Or do I still want the status="okay" to appear no earlier than
the specific mcasp configuration?

> 
>> https://github.com/RobertCNelson/bb.org-overlays/blob/master/src/arm/BB-BONE-AUDI-02-00A0.dts#L72
>> 
>> I rebuilt the .dtb by commenting out the enabling of the macasp0/1 in
>> that .dtsi, and now it seems to work! davinci_mcasp_probe is entered
>> when I apply the overlay, and I get this logged:
>> 
>> [   35.868324] davinci-mcasp 48038000.mcasp: davinci_mcasp_probe: enter
>> [   35.874741] davinci-mcasp 48038000.mcasp: serial-dir: 64
>> [   43.469254] davinci-mcasp 48038000.mcasp: Slots: 2,
>> 	max_active_serializers: 1, active_serializers: 1,
>> 	channels: 2, mcasp->num_serializer: 16
>> [   78.846314] davinci-mcasp 48038000.mcasp: Slots: 2,
>> 	max_active_serializers: 1, active_serializers: 1,
>> 	channels: 2, mcasp->num_serializer: 16
> 
> Great!

Should I change the DT to use only four serializers? I noticed that
a) your DTS doesn't specify the number of serializers explicitly,
and b) has the active/inactive ones set differently from mine:

https://github.com/RobertCNelson/bb.org-overlays/blob/master/src/arm/BB-BONE-AUDI-02-00A0.dts#L75

> 
>> By default, speaker-test only outputs to the left channel, and I get
>> noise out that channel. If I invoke speaker-test -c 2, it claims to
>> cycle between Front Left and Front Right, but there is only silence
>> out the Front Right. This is probably due to issues in asound.state,
>> right (I'd sure love some help getting that straightened out)?
> 
> I'll try to take a look at the speaker-test, it should work fine AFAIK.

Yeah, I don't think the problem is in speaker-test, per se. I think it's
in the ALSA configuration, or perhaps the routing entries in the DTB?

-- 
Rick Mann
rmann@latencyzero.com
