From: Olaf Hering <olaf@aepfle.de>
Subject: Re: hdmi audio on Shuttle XS35GS V3L
Date: Fri, 20 Sep 2013 17:27:27 +0200
Message-ID: <20130920152727.GA16734@aepfle.de>
References: <20130919142333.GA29383@aepfle.de>
 <20130920122546.GA9628@aepfle.de> <523C481F.8050703@ladisch.de>
 <20130920135446.GA29307@aepfle.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mo-p00-ob.rzone.de (mo-p00-ob.rzone.de [81.169.146.162])
 by alsa0.perex.cz (Postfix) with ESMTP id B130126569A
 for <alsa-devel@alsa-project.org>; Fri, 20 Sep 2013 17:27:30 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20130920135446.GA29307@aepfle.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Clemens Ladisch <clemens@ladisch.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Fri, Sep 20, Olaf Hering wrote:

> On Fri, Sep 20, Clemens Ladisch wrote:
> 
> > Olaf Hering wrote:
> > > Does anyone happen to know if HDMI audio is supposed to work on the
> > > Shuttle XS35GS V3L? I have tried an AOC E2260Pwhu monitor and also a
> > > Philips 22PFL3805H/12 TV, both show the picture but no sound is played
> > > via HDMI.
> > >
> > > ==> /proc/asound/card0/eld#1.0 <==
> > > monitor_present         0
> > > eld_valid               0
> > 
> > > ==> /proc/asound/card1/eld#0.0 <==
> > > monitor_present         0
> > > eld_valid               0
> > 
> > Is this with some monitor present?
> 
> Yes, the AOC monitor is connected to the Shuttle with an HDMI cable (EAN
> 4043718042692, if that matters).

I just realized snd has a debug= parameter, this is what I get:


[    8.907799] input: PC Speaker as /devices/platform/pcspkr/input/input3
[    8.927950] snd_hda_intel 0000:00:1b.0: irq 47 for MSI/MSI-X
[    8.953396] ALSA hda_auto_parser.c:393 autoconfig: line_outs=1 (0xd/0x0/0x0/0x0/0x0) type:speaker
[    8.953407] ALSA hda_auto_parser.c:397    speaker_outs=0 (0x0/0x0/0x0/0x0/0x0)
[    8.953414] ALSA hda_auto_parser.c:401    hp_outs=1 (0xb/0x0/0x0/0x0/0x0)
[    8.953419] ALSA hda_auto_parser.c:402    mono: mono_out=0x0
[    8.953424] ALSA hda_auto_parser.c:406    inputs:
[    8.953431] ALSA hda_auto_parser.c:410      Mic=0xa
[    8.956379] input: HDA Digital PCBeep as /devices/pci0000:00/0000:00:1b.0/input/input4
[    9.034729] ALSA patch_hdmi.c:1301 HDMI status: Codec=1 Pin=3 Presence_Detect=0 ELD_Valid=0
[    9.036489] input: HDA Intel HDMI/DP,pcm=3 as /devices/pci0000:00/0000:00:1b.0/sound/card0/input5
[    9.037841] input: HDA Intel Front Headphone as /devices/pci0000:00/0000:00:1b.0/sound/card0/input6
[    9.038085] input: HDA Intel Mic as /devices/pci0000:00/0000:00:1b.0/sound/card0/input7
[    9.039520] ALSA hda_intel.c:3116 0000:01:00.1: Handle VGA-switcheroo audio client
[    9.039532] ALSA hda_intel.c:3317 0000:01:00.1: Using LPIB position fix
[    9.039644] snd_hda_intel 0000:01:00.1: irq 48 for MSI/MSI-X
[    9.042396] ALSA hda_intel.c:1787 0000:01:00.1: Enable sync_write for stable communication
[    9.043985] ALSA patch_hdmi.c:1301 HDMI status: Codec=0 Pin=3 Presence_Detect=0 ELD_Valid=0
[    9.045871] input: HD-Audio Generic HDMI/DP,pcm=3 as /devices/pci0000:00/0000:00:1c.0/0000:01:00.1/sound/card1/input8

So monitor_present remains 0 and hdmi_setup_audio_infoframe is skipped
(if that matters).

Perhaps hdmi_present_sense should also dump present to see the actual
response.

Olaf
