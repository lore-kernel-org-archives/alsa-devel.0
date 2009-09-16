From: =?UTF-8?B?T3phbiDDh2HEn2xheWFu?= <ozan@pardus.org.tr>
Subject: alsamixer is not able to set pulseaudio master volume
Date: Wed, 16 Sep 2009 10:13:30 +0300
Message-ID: <4AB0901A.6040200@pardus.org.tr>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from lider.pardus.org.tr (lider.pardus.org.tr [193.140.100.216])
	by alsa0.perex.cz (Postfix) with ESMTP id 497C82432C
	for <alsa-devel@alsa-project.org>;
	Wed, 16 Sep 2009 09:09:21 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, General PulseAudio Discussion <pulseaudio-discuss@mail.0pointer.de>
List-Id: alsa-devel@alsa-project.org

Hi,

I've just noticed that using alsamixer to set pulseaudio's master volume
is not working anymore. I switched back to an earlier alsa-utils
snapshot (20090624) still the same.

I didn't do any changes to pulseaudio for a long time, it's 0.9.15 with
the proposed patchset of Lennart.

alsamixer is launched, the master channel is displayed but pressing Up
and Down doesn't change anything on the UI. Pressing M changes 'OO' to 'MM'.

Here's what happens on PA's side when I click UP/DOWN:

I: alsa-source.c: Device suspended...
I: module-suspend-on-idle.c: Sink alsa_output.pci_8086_3a3e_sound_card_0
idle for too long, suspending ...
I: alsa-sink.c: Device suspended...
I: client.c: Created 1 "Native client (UNIX socket client)"
D: protocol-native.c: Protocol version: remote 15, local 15
I: protocol-native.c: Got credentials: uid=1000 gid=100 success=1
D: protocol-native.c: SHM possible: yes
D: protocol-native.c: Negotiated SHM: yes
D: module-augment-properties.c: Looking for .desktop file for alsamixer
I: module-device-restore.c: Storing volume/mute for device
sink:alsa_output.pci_8086_3a3e_sound_card_0.
I: module-device-restore.c: Storing volume/mute for device
sink:alsa_output.pci_8086_3a3e_sound_card_0.
I: module-device-restore.c: Storing volume/mute for device
sink:alsa_output.pci_8086_3a3e_sound_card_0.
I: module-device-restore.c: Storing volume/mute for device
sink:alsa_output.pci_8086_3a3e_sound_card_0.
I: module-device-restore.c: Storing volume/mute for device
sink:alsa_output.pci_8086_3a3e_sound_card_0.
I: module-device-restore.c: Storing volume/mute for device
sink:alsa_output.pci_8086_3a3e_sound_card_0.
I: module-device-restore.c: Storing volume/mute for device
sink:alsa_output.pci_8086_3a3e_sound_card_0.
I: module-device-restore.c: Storing volume/mute for device
sink:alsa_output.pci_8086_3a3e_sound_card_0.
I: module-device-restore.c: Storing volume/mute for device
sink:alsa_output.pci_8086_3a3e_sound_card_0.
I: module-device-restore.c: Storing volume/mute for device
sink:alsa_output.pci_8086_3a3e_sound_card_0.
I: module-device-restore.c: Storing volume/mute for device
sink:alsa_output.pci_8086_3a3e_sound_card_0.
..
..
Synced.
