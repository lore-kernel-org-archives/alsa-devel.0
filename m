From: Daniel Wagner <wagi@monom.org>
Subject: Re: [RFC][PATCH 00/13] bebob: a new driver for
 BridgeCo BeBoB based device
Date: Sun, 15 Dec 2013 17:17:25 +0100
Message-ID: <52ADD615.4090003@monom.org>
References: <1385186965-8303-1-git-send-email-o-takashi@sakamocchi.jp>
 <529A2691.4000401@monom.org> <529ABE4F.6070406@sakamocchi.jp>
 <52A0EB5F.9090003@monom.org> <52A8553C.3050205@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from hotel311.server4you.de (hotel311.server4you.de [85.25.146.15])
 by alsa0.perex.cz (Postfix) with ESMTP id A2387261AF9
 for <alsa-devel@alsa-project.org>; Sun, 15 Dec 2013 17:17:26 +0100 (CET)
In-Reply-To: <52A8553C.3050205@sakamocchi.jp>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Cc: alsa-devel@alsa-project.org, linux1394-devel@lists.sourceforge.net, ffado-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi Takashi,

On 12/11/2013 01:06 PM, Takashi Sakamoto wrote:
> I'm sorry to be late for reply but I was hard to prepare series of patch
> for Fireworks driver.

No problemo. I am also slow as a heavy droged slug :)

>> I have uploaded some two logs. The first one is for the fa-66
>> (fw-fa66.txt) and the second one is for the Audio5 (fw-a5.txt).
>>
>> There seems to be an issue with the Audio5, though I haven't
>> looked into it yet (quite busy, sorry) For that device I
>> even got a serial console to it) Maybe you see the problem
>> already from the log.
>
> In the log of Audio5, there were much lock transaction for
> iPCR[0]/oPCR[0]. This means that snd-bebob tried to establish connection
> several times to start transmitting/receiving streams.

IIRC, I loaded the ALSA module by issuing

$ pactl load-module module-alsa-sink device=hw:X,X

> I guess that the module-alsa-sink of PulseAudio retried
> snd_pcm_prepare() several times due to get err. When snd_pcm_prepare()
> failed, snd_bebob_stream_start_duplex() is failed inner snd-bebob.
> Establishing connections is done by make_both_connections() so we should
> notice the codes after this function.
>
> There are four possibilities, two of them are related to start_stream()
> and the others are related to amdtp_stream_wait_callback(). But the
> former generates log output. So amdtp_stream_wait_callback() causes this
> issue;
>
> This function return false when snd-bebob cannot receive AMDTP
> in-packets within 100 msec after establishing connection. Please see
> amdtp.c in detail. I programmed this to prevent snd-bebob from waiting
> forever to receive in-packets.
>
> So I guess you can playback/capture with your device when you expand the
> time (200 msec or more). Or there are some bugs of snd-bebob to handle
> your device.

The A5 is basically the SDK from BridgeCo. It is surprising to see that
this device shows these kind of generic errors.

> Would you test and get logs again after expand waiting time? Then please
> use aplay/arecord to test. I believe simple tools help our investigating.

I'll give it a try coming week. Sorry for my really slow
debugging/testing cycles.

> And I hope you to give me an advice for my headache. As long as I
> investigated, snd-bebob can support 64 device and models (I count the
> devices to which the same expansion card can apply). But there are some
> devices which I can't identify its vendor_id/model_id.

You mean the vendor_id/model_id is not unique?

> [Identified devices and models]
> * Edirol FA-66/FA-101
> * PreSonus FIREBOX/FIREPOD
> * BridgeCo RDAudio1/Audio5
> * Mackie Onyx 820/1220/1620/1640 (Firewire I/O Card)
> * Mackie d.2 (Firewire Option)
> * Stanton FinalScratch 2 (ScratchAmp)
> * Tascam  IF-FW DM
> * Apogee Rosetta 200/400 (X-FireWire card)
> * Apogee DA/AD/DD-16X (X-FireWire card)
> * ESI Quotafire610
> * AcousticReality eARMasterOne
> * CME MatrixKFW
> * Phonic HB 12/12 MkII/12 Universal
> * Phonic HB 18/18 MkII/18 Universal
> * Phonic HB 24/24 MkII/24 Universal
> * Phonic FireFly 202/302
> * Lynx Aurora 8/16 (LT-FW)
> * ICON FireXon
> * PrismSound Orpheus/ADA-8XR
> * Yamaha GO44/GO46
> * TerraTec PHASE 24 FW/PHASE X24 FW/PHASE 88 Rack FW
> * Terratec EWS MIC2/EWS MIC4
> * Terratec Aureon 7.1 Firewire
> * Focusrite Saffire/Saffire LE/SaffirePro10 IO/SaffirePro26 IO
> * M-Audio Firewire410/AudioPhile/Solo/Ozonic/NRV10
> * M-Audio Firewire1814/ProjectMix IO/ProfireLightBridge
>
> [Unidentified devices and models]
> * PreSonus, Inspire 1394
> * Mackie, Digital X Bus x.200
> * Mackie, Digital X Bus x.400
> * CME, UF400e
> * Infrasonic, DewX
> * Infrasonic, Windy6
> * Rolf Spuler, Firewire Guitar
>
> Do you have any idea to identify them?

If the vendor/model id is not unique, maybe a more heuristic approach
is needed, e.g. by reading the number of in/out streams which makes
the device unique. But as you see, I don't have a good idea here.

cheers,
daniel
