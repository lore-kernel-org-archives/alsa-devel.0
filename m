From: Dennis Mungai <dmngaie@gmail.com>
Subject: Re: Bug report for: [P7xxDM2(-G), Realtek ALC898,
 issue: Headphone Jack, External] No sound at all
Date: Sat, 20 Jan 2018 10:03:04 +0100
Message-ID: <CAKKYfmEOcPfvgWxN5veHNr6ReEE_Z_VYe2+C7SC+-kzRjf_1qA@mail.gmail.com>
References: <CAKKYfmEHpTina=bzw_vpSx8inwHUKuhUgfo9C1t+YHCLGcnMOQ@mail.gmail.com>
 <s5h8td3pesk.wl-tiwai@suse.de>
 <CAKKYfmGMjEjhuo_MgKUgSS2KWHCGzJMJpPeBGbiuSJD=FoNeoQ@mail.gmail.com>
 <s5h4lnkybyn.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qt0-f193.google.com (mail-qt0-f193.google.com
 [209.85.216.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 812D126719C
 for <alsa-devel@alsa-project.org>; Sat, 20 Jan 2018 10:03:46 +0100 (CET)
Received: by mail-qt0-f193.google.com with SMTP id d8so1044980qtm.0
 for <alsa-devel@alsa-project.org>; Sat, 20 Jan 2018 01:03:46 -0800 (PST)
In-Reply-To: <s5h4lnkybyn.wl-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hello there,

To override the pins, I used a method similar to what hdajackretask
does, which is to write a firmware patch, as shown below:

The second action, dac_fixup, is a two-step process, inferred from the
actions.py subroutine:

(a). Create a /lib/firmware/clevo-audio-patch with the following entry:

[codec]
0x{vendor_id:08x} 0x{subsystem_id:08x} 0

[pincfg]
0x1b 0x01111060
0x19 0x23A11040

[verb]
0x1b 0x707 0x0004

(b). Create an /etc/modprobe.d/clevo-alsa-base.conf file with the
following entries:

 options snd-hda-intel patch=clevo-audio-patch

Then reboot the system. Confirm the successful override by grepping
dmesg on boot:

 dmesg | grep clevo

Here are my pin configs:

sudo cat /sys/devices/pci0000:00/0000:00:1f.3/sound/card0/hwC0D0/init_pin_configs

list:

0x11 0x4004d000
0x12 0x90a60140
0x14 0x90170110
0x15 0x411111f0
0x16 0x411111f0
0x17 0x01011050
0x18 0x01a11030
0x19 0x411111f0
0x1a 0x0181103f
0x1b 0x411111f0
0x1c 0x411111f0
0x1d 0x40350d29
0x1e 0x01441120
0x1f 0x411111f0

As at the moment, I'm running the latest kernel available to Ubuntu 16.04LTS.



On 17 January 2018 at 12:13, Takashi Iwai <tiwai@suse.de> wrote:
> On Tue, 16 Jan 2018 23:33:06 +0100,
> Dennis Mungai wrote:
>>
>> Cool, thanks!
>>
>> Rewiring the pins via hdajack retask tool fixes the detection, but still no
>> sound from the headphones jack is heard.
>
> And what exactly did you change, i.e. which pin config has to be
> modified?
>
>> Only the temporary click off the
>> audio jack when plugged in.
>
> Did you try with the latest Linus kernel?
>
>
> Takashi
>
>> On Jan 12, 2018 11:11, "Takashi Iwai" <tiwai@suse.de> wrote:
>>
>> > On Thu, 11 Jan 2018 19:21:03 +0100,
>> > Dennis Mungai wrote:
>> > >
>> > > Hello there,
>> > >
>> > > I have Ubuntu 16.04LTS installed on the Clevo P751DM2-G, also marketed
>> > > as the Origin Eon 15-X (Late 2016 model), the System76's Serval WS
>> > > (2017 model), the Eurocom Sky X4E2, among others.
>> > >
>> > > The sound card is the Realtek ALC898 with the following output
>> > configuration:
>> > >
>> > > 1. One SPDIF/headphone combo jack (to the right)
>> > > 2. One Line Out.
>> > > 3. One Line-In.
>> > > 4. One Mic-In.
>> > >
>> > > Background information:
>> > >
>> > > On Windows, one can use the Realtek HD Audio control panel pop-up menu
>> > > on jack detection to set the output type when an audio device is
>> > > plugged in to an appropriate jack, combined with Sound Blaster X-Fi
>> > > MB5 software to enable post-processing effects such as Bass, noise
>> > > cancellation, etc.
>> > >
>> > > What I have tried so far:
>> > >
>> > > 1. Setting the model definition at /etc/modprobe.d/sound.conf with the
>> > > following entries:
>> > >
>> > > options snd-hda-intel model=no-primary-hp enable=1 index=0
>> > >
>> > > Using such a line worked before on an MSI GS43VR 6RE Phantom Pro that
>> > > also has the same (or a similar) ESS Sabre Audio DAC component.
>> > >
>> > > Expected behavior:
>> > >
>> > > When plugged into the microphone jack, the ESS Sabre DAC should be
>> > > activated and sound should be routed to the headset.
>> > >
>> > > Observed anomaly:
>> > >
>> > > Sound comes out through the speakers instead.
>> > >
>> > > However, the line-out output works. In that case, when plugged into
>> > > the line out, Audio works as expected.
>> >
>> > Judging from alsa-info.sh output, BIOS doesn't seem to give the proper
>> > headphone pin (or the headset output), and that's the culprit.
>> > It's a bug of BIOS.  You can try to figure out the pin and override
>> > the pin config via hdajackretask or such a tool.
>> >
>> >
>> > Takashi
>> >
