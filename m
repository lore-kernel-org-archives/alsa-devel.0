From: Lukas Wunner <lukas@wunner.de>
Subject: Re: [PATCH v2 3/3] ALSA: hda: Disabled unused audio
 controller for Dell platforms with Switchable Graphics
Date: Sat, 10 Mar 2018 07:50:39 +0100
Message-ID: <20180310065039.GA6633@wunner.de>
References: <20180308091023.9061-1-kai.heng.feng@canonical.com>
 <20180308091023.9061-3-kai.heng.feng@canonical.com>
 <20180309090223.xb55ltac4pfesdrh@pali>
 <723DA929-C9FA-4F69-8D3A-03D8A75D09A6@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bmailout2.hostsharing.net (bmailout2.hostsharing.net
 [83.223.90.240])
 by alsa0.perex.cz (Postfix) with ESMTP id 8976B267662
 for <alsa-devel@alsa-project.org>; Sat, 10 Mar 2018 07:50:40 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <723DA929-C9FA-4F69-8D3A-03D8A75D09A6@canonical.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Kai Heng Feng <kai.heng.feng@canonical.com>
Cc: mjg59@srcf.ucam.org, alsa-devel@alsa-project.org, Mario Limonciello <mario.limonciello@dell.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, tiwai@suse.com, platform-driver-x86@vger.kernel.org, Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>, dvhart@infradead.org, andy@infradead.org
List-Id: alsa-devel@alsa-project.org

On Fri, Mar 09, 2018 at 05:30:15PM +0800, Kai Heng Feng wrote:
> >On Thursday 08 March 2018 17:10:23 Kai-Heng Feng wrote:
> >>Some Dell platforms (Preicsion 7510/7710/7520/7720) have a BIOS option
> >>"Switchable Graphics" (SG).
> >>
> >>When SG is enabled, we have:
> >>00:02.0 VGA compatible controller: Intel Corporation Device 591b (rev 04)
> >>00:1f.3 Audio device: Intel Corporation CM238 HD Audio Controller (rev 31)
> >>01:00.0 VGA compatible controller: Advanced Micro Devices, Inc.
> >>[AMD/ATI] Ellesmere [Polaris10]
> >>01:00.1 Audio device: Advanced Micro Devices, Inc. [AMD/ATI] Ellesmere
> >>[Radeon RX 580]
> >>
> >>The Intel Audio outputs all the sound, including HDMI audio. The audio
> >>controller comes with AMD graphics doesn't get used.
> >>
> >>When SG is disabled, we have:
> >>00:1f.3 Audio device: Intel Corporation CM238 HD Audio Controller (rev 31)
> >>01:00.0 VGA compatible controller: Advanced Micro Devices, Inc.
> >>[AMD/ATI] Ellesmere [Polaris10]
> >>01:00.1 Audio device: Advanced Micro Devices, Inc. [AMD/ATI] Ellesmere
> >>[Radeon RX 580]
> >>
> >>Now it's a typical discrete-only system. HDMI audio comes from AMD audio
> >>controller, others from Intel audio controller.
> >>
> >>When SG is enabled, the unused AMD audio controller still exposes its
> >>sysfs, so userspace still opens the control file and stream. If
> >>userspace tries to output sound through the stream, it hangs when
> >>runtime suspend kicks in:
> >>[ 12.796265] snd_hda_intel 0000:01:00.1: Disabling via vga_switcheroo
> >>[ 12.796367] snd_hda_intel 0000:01:00.1: Cannot lock devices!
> >>
> >>Since the discrete audio controller isn't useful when SG enabled, we
> >>should just disable the device.
> 
> The platform does have a NVIDIA variant, but the discrete NVIDIA have a
> audio controller, hence it doesn't have the issue.

Sorry, I don't quite understand:  The AMD variant *also* has an audio
controller, so what's the difference?  Or did you mean the Nvidia
variant *doesn't* have an audio controller?

Pretty much all modern Nvidia GPUs do have an integrated HDA
controller, however it's possible to hide it by clearing a bit
at offset 0x488 in the GPU's config space.  Some BIOSes hide
the HDA if no external display is attached.

I could imagine that the BIOS of the Dell machines in question
hides the HDA if Switchable Graphics is enabled.  If that is the
case, be aware that there's an ongoing discussion to always expose
the HDA controller because the behavior of some BIOSes to only
expose the HDA when a display is attached causes massive problems
with Linux' HDA driver:
https://bugs.freedesktop.org/show_bug.cgi?id=75985

If we decide to always expose the HDA controller on Nvidia cards,
you may need to also match for the Nvidia vendor ID here.

Thanks,

Lukas
