From: Dennis Mungai <dmngaie@gmail.com>
Subject: Issue with the Realtek ALC 898 codec on the Clevo
 P751DM2-G and the ESS Sabre Audio Jack for the headphone output.
Date: Sun, 26 Nov 2017 23:18:12 +0300
Message-ID: <CAKKYfmGZN42wTKoknuSyWZmAmce+2SgBaTpf+56evCzJJ2a8bg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qk0-f174.google.com (mail-qk0-f174.google.com
 [209.85.220.174])
 by alsa0.perex.cz (Postfix) with ESMTP id 0FFEF266E6C
 for <alsa-devel@alsa-project.org>; Sun, 26 Nov 2017 21:18:54 +0100 (CET)
Received: by mail-qk0-f174.google.com with SMTP id a194so30004826qkc.9
 for <alsa-devel@alsa-project.org>; Sun, 26 Nov 2017 12:18:54 -0800 (PST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hello there,

I have Ubuntu 16.04LTS installed on the Clevo P751DM2-G, also marketed
as the Schenker XMG U507, the System76's Serval WS (2017 model), the
Eurocom Sky X4E2, among others.

The sound card is the Realtek ALC898 with the following output
configuration:

1. One SPDIF/headphone combo jack (to the right)
2. One Line Out.
3. One Line-In.
4. One Mic-In.

Background information:

On Windows, one can use the Realtek HD Audio control panel pop-up menu
on jack detection to set the output type when an audio device is plugged
in to an appropriate jack, combined with Sound Blaster X-Fi MB5 software
to enable post-processing effects such as Bass, noise cancellation, etc.

What I have tried so far:

1. Setting the model definition at /etc/modprobe.d/sound.conf with the
following entries:

options snd-hda-intel model=no-primary-hp enable=1 index=0

Using such a line worked before on an MSI GS43VR 6RE Phantom Pro that
also has the same (or a similar) ESS Sabre Audio DAC component.

Expected behavior:

When plugged into the microphone jack, the ESS Sabre DAC should be
activated and sound should be routed to the headset.

Observed anomaly:

Sound comes out through the speakers instead.

However, the line-out output works. In that case, when plugged into the
line out, Audio works as expected.

I was able to report this as a bug to Launchpad, with the information below:

https://bugs.launchpad.net/bugs/1731940

ProblemType: Bug
DistroRelease: Ubuntu 16.04
Package: alsa-base 1.0.25+dfsg-0ubuntu5
Uname: Linux 4.14.0 x86_64
NonfreeKernelModules: nvidia_uvm nvidia_drm nvidia_modeset nvidia
ApportVersion: 2.20.1-0ubuntu2.10
Architecture: amd64
AudioDevicesInUse:
 USER        PID ACCESS COMMAND
 /dev/snd/controlC1:  lin        2199 F.... pulseaudio
 /dev/snd/controlC0:  lin        2199 F.... pulseaudio
CurrentDesktop: GNOME
Date: Mon Nov 13 17:34:53 2017
InstallationDate: Installed on 2017-07-25 (111 days ago)
InstallationMedia: Ubuntu 16.04.2 LTS "Xenial Xerus" - Release amd64
(20170215.2)
PackageArchitecture: all
SourcePackage: alsa-driver
Symptom: audio
Symptom_AlsaPlaybackTest: ALSA playback test through plughw:PCH failed
Symptom_Card: Built-in Audio - HDA Intel PCH
Symptom_DevicesInUse:
 USER        PID ACCESS COMMAND
 /dev/snd/controlC1:  gdm        1812 F.... pulseaudio
                      lin        2199 F.... pulseaudio
 /dev/snd/controlC0:  gdm        1812 F.... pulseaudio
                      lin        2199 F.... pulseaudio
Symptom_Jack: Speaker, Internal
Symptom_Type: No sound at all
Title: [P7xxDM2(-G), Realtek ALC898, Speaker, Internal] No sound at all
UpgradeStatus: No upgrade log present (probably fresh install)
dmi.bios.date: 12/21/2016
dmi.bios.vendor: American Megatrends Inc.
dmi.bios.version: 1.06.04
dmi.board.asset.tag: Tag 12345
dmi.board.name: P7xxDM2(-G)
dmi.board.vendor: Notebook
dmi.board.version: Not Applicable
dmi.chassis.asset.tag: No Asset Tag
dmi.chassis.type: 10
dmi.chassis.vendor: No Enclosure
dmi.chassis.version: N/A
dmi.modalias: dmi:bvnAmericanMegatrendsInc.:bvr1.06.04:bd12/21/2016:svnNotebook:pnP7xxDM2(-G):pvrNotApplicable:rvnNotebook:rnP7xxDM2(-G):rvrNotApplicable:cvnNoEnclosure:ct10:cvrN/A:
dmi.product.family: Not Applicable
dmi.product.name: P7xxDM2(-G)
dmi.product.version: Not Applicable
dmi.sys.vendor: Notebook

** Affects: alsa-driver (Ubuntu)
     Importance: Undecided
         Status: New


Regards,

Dennis.
