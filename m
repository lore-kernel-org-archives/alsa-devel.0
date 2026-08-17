Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F534C5DF81
	for <alsa-devel@archiver.kernel.org>; Thu, 20 Aug 2026 14:35:23 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 0094E6027C;
	Thu, 20 Aug 2026 16:35:08 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 0094E6027C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1787236519;
	bh=nd+yg1pzO2Adr4+Jl6X/4tAxQQUhyJgSW1HjHqdtY1A=;
	h=Date:From:To:CC:Subject:In-Reply-To:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=SH2gvB4bv2UYlIrsVDsgbb7ShHjDxeipeaZLI7Lvs5RjNvNho/vhB4hv981yn05fs
	 79gRAJge+HlxZos6FcMHgvWT98o8eL1ZkEF5gnccK1Rgnv4s28yW7qdRnqIoyQ3nCE
	 iksgiwsvO1uEsnLWr+4jd4RDiP2ctjJKtVQ7mwIo=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id A2987F805FF; Thu, 20 Aug 2026 16:34:42 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id ED46CF805EC;
	Thu, 20 Aug 2026 16:34:41 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 38F27F8047D; Mon, 17 Aug 2026 19:06:35 +0200 (CEST)
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=93.190.126.19
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1786986393;
	b=ZBaDk2I3uPmx07rS7E1Dl92in4Sp3KX1XIclMCe7Dt7lVvhZMUzQioXuLtDPWTbFPbwA
	 iLMZt/Qb2vM3Mrvw/ZioakWIiwXqzpRmPINgqp6bNtPu5bComz4Fq+O2v+msExDGvLgSF
	 dwiDf4n+g5im8K0Bpik7ShXd6d4T5mltPydw4/oKtr03V1DbEweDedL21tJFi7ZXpquvg
	 gD2UJEbOsG01RwH2OjKDdHqa58nXQMPvq0Yqh+3uKkksnVW8j+mw18IRhuGaxG6+0pM/z
	 rR46SffmVDcUEj52JC+OD6M9m2wRCUb8hdHm7E+hzX9ZH/s3Fm+JZClitusW4pq+ymA==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1786986393;
	h=DKIM-Signature:Date:From:To:Subject:Message-ID:MIME-Version;
	bh=nd+yg1pzO2Adr4+Jl6X/4tAxQQUhyJgSW1HjHqdtY1A=;
	b=m0FdhcXzen8L+msybISnw8OT3IDd3Oa7Puv3cVSn7PnWUwoBnm9/LPKMMfhf/6RfxHAf
	 BLw7nS6DguZcIpIEX7H66qhmEDueKlarpmsoBrLGsJbApvmSydu1Q//r5bbKBcvewuBbm
	 zBGWhOSpaBpVzz1eCKmR3hZJefl7kYbLLLq7CTIOnOWbdZKqrEUHjKZR9mzFT9b2BSnIO
	 d0top6GSXyA3pAMdb/wKoi+luN6NfdkqCqQkypavfcRAG+ci6gSpul6GA/XhDR3Ery3p1
	 jOLMKBQ9HBMv2T57lwUiWm0TDtJiXM6KnXancJJd5KwdcZDdFQvYHU7J342yebi0+CQ==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 dkim=pass header.d=grrlz.net header.i=@grrlz.net header.a=rsa-sha256
 header.s=stigmate header.b=TdTfyGWr;
	arc=none smtp.remote-ip=93.190.126.19
Received: from confino.investici.org (confino.investici.org [93.190.126.19])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 7407EF800FA
	for <alsa-devel@alsa-project.org>; Mon, 17 Aug 2026 19:06:28 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 7407EF800FA
Authentication-Results: alsa1.perex.cz;
	dkim=pass (1024-bit key,
 unprotected) header.d=grrlz.net header.i=@grrlz.net header.a=rsa-sha256
 header.s=stigmate header.b=TdTfyGWr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=grrlz.net;
	s=stigmate; t=1786986388;
	bh=IFEC4hQz+z7ZKusXtk8zx2ZRz8Os3GL8ikOszyeJ++g=;
	h=Date:From:To:CC:Subject:In-Reply-To:From;
	b=TdTfyGWrAuXg4UvihAnZWAVgi0cXjY2DV1mE8sJQR5f0OHZiKOygRy0kr2fxjR6AM
	 G6V/kuiUDRc8xoa/Fa5tWjhlR1SCUFKZ+6SnsQg508M/zkQftP/COZm73DBH0E/Z+/
	 VLfJIn3PGzuwdI4y8pasW1uGfT52ff20OLAUabc4=
Received: from mx1.investici.org (unknown [127.0.0.1])
	by confino.investici.org (Postfix) with ESMTP id 4hNzkr15d7z10j7;
	Mon, 17 Aug 2026 17:06:28 +0000 (UTC)
Received: by mx1.investici.org (Postfix) id 4hNzkq0Dvfz10nt;
	Mon, 17 Aug 2026 17:06:27 +0000 (UTC)
Date: Mon, 17 Aug 2026 18:06:28 +0100
From: Bradley Morgan <include@grrlz.net>
To: lightning1111111@proton.me
CC: alsa-devel@alsa-project.org
Subject: Re: LINUX AUDIO FIX FOR HUAWEI AMD LAPTOPS
In-Reply-To: 
 <3pZ5MOlm5zlq8xTJrCBs8rDuBniv3lHY1MgF9oAmFstfU7-lFF_j8fo-ZvLhxBaSkFEBp_FyrLZ8LLozvL4tsUZEBrgDrs_EZbQxMBImzIo=@proton.me>
Message-ID: <F01B0507-A667-4CE5-9B2C-A6E624B7D2A2@grrlz.net>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8bit
X-MailFrom: include@grrlz.net
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; emergency; member-moderation
Message-ID-Hash: L44LAICXLWANFOS27HE7KM5POYAMPLHW
X-Message-ID-Hash: L44LAICXLWANFOS27HE7KM5POYAMPLHW
X-Mailman-Approved-At: Thu, 20 Aug 2026 14:34:36 +0000
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/L44LAICXLWANFOS27HE7KM5POYAMPLHW/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On 15 August 2026 18:47:06 BST, Walther White <Lightning1111111@proton.me>
wrote:
>================================================================================LINUX
>AUDIO FIX FOR HUAWEI AMD LAPTOPS
>================================================================================
>
>Author: Linux Community / Michael Lorentz

Cheers for all this, but may I ask what this has to do with the Linux
kernel? 

Maybe using some sort of blog site to post this is more beneficial?

But who bloody knows, I just popped up to some driver complaining for no
reason to this thing that sounds blatantly like AI.


>Date: July 2026
>Hardware: Huawei MateBook with AMD Ryzen processor (CX11970 audio codec)
>System: Linux Mint / Ubuntu / Other distributions with PipeWire
>
>================================================================================
>STEP-BY-STEP SOLUTION
>================================================================================
>
>PROBLEM DESCRIPTION:
>Audio on built-in laptop speakers does NOT work.
>Audio on headphones connected to the mini-jack DOES work.
>
>================================================================================
>STEP 1: CHECK AUDIO DEVICE STATUS
>================================================================================
>
>Open a terminal and run:
>
>$ pactl list short sinks
>
>If you see "SUSPENDED" status for the speaker device, this confirms the
>problem.
>
>Check if the sound card is detected:
>
>$ aplay -l
>
>You should see a card with the CX11970 codec (or similar).
>
>================================================================================
>STEP 2: IMMEDIATE AUDIO RESTORATION (QUICKEST METHOD)
>================================================================================
>
>Perform a full system restart:
>
>$ sudo reboot
>
>After restart, speaker audio should be restored.
>
>NOTE: If this doesn't work, proceed to Step 3.
>
>================================================================================
>STEP 3: MANUAL FIX (IF RESTART DID NOT HELP)
>================================================================================
>
>Run the following commands in the given order:
>
>$ sudo alsactl init
>$ sudo alsactl store
>$ systemctl --user restart pipewire pipewire-pulse
>$ pactl set-default-sink alsa_output.pci-0000_02_00.6.analog-stereo
>$ pactl set-sink-volume alsa_output.pci-0000_02_00.6.analog-stereo 80%
>
>Test if audio works:
>
>$ speaker-test -t wav -c 2
>
>================================================================================
>STEP 4: CHECK IF SPEAKERS ARE MUTED IN ALSA MIXER
>================================================================================
>
>$ alsamixer
>
>Press F6 and select your sound card (Generic_1 or CX11970).
>
>Check these channels:
>- Master
>- PCM
>- Speaker
>- Headphone
>
>If any shows "MM" (muted), press M on the keyboard to unmute.
>Use the arrow keys to set volume to approximately 80%.
>
>================================================================================
>STEP 5: AUTOMATIC STARTUP SCRIPT
>================================================================================
>
>To automate the fix at every system startup, create a script:
>
>$ mkdir -p ~/bin
>$ nano ~/bin/fix-audio.sh
>
>Paste the following content:
>-----------------------------------------------------------------------------
>#!/bin/bash
># Audio fix script for Huawei AMD
>
>sleep 30
>
># Reset ALSA
>sudo alsactl init 2>/dev/null
>
># Restart PipeWire
>systemctl --user restart pipewire pipewire-pulse 2>/dev/null
>
># Force speaker output
>pactl set-card-profile alsa_card.pci-0000_02_00.6
>output:analog-stereo+input:analog-stereo 2>/dev/null
>pactl set-default-sink alsa_output.pci-0000_02_00.6.analog-stereo
>2>/dev/null
>pactl set-sink-volume alsa_output.pci-0000_02_00.6.analog-stereo 80%
>2>/dev/null
>pactl set-sink-mute alsa_output.pci-0000_02_00.6.analog-stereo 0
>2>/dev/null
>
>echo "$(date) - Audio fixed" >> /tmp/fix-audio.log
>-----------------------------------------------------------------------------
>
>$ chmod +x ~/bin/fix-audio.sh
>
>================================================================================
>STEP 6: ADD SCRIPT TO AUTOSTART
>================================================================================
>
>$ nano ~/.config/autostart/fix-audio.desktop
>
>Paste (replace [USER] with your username):
>-----------------------------------------------------------------------------
>[Desktop Entry]
>Type=Application
>Name=Fix Audio
>Exec=/home/[USER]/bin/fix-audio.sh
>Icon=audio-card
>X-GNOME-Autostart-enabled=true
>-----------------------------------------------------------------------------
>
>================================================================================
>STEP 7: ALLOW SUDO WITHOUT PASSWORD (OPTIONAL)
>================================================================================
>
>To allow the script to run without asking for a password:
>
>$ sudo visudo -f /etc/sudoers.d/fix-audio
>
>Add (replace [USER] with your username):
>-----------------------------------------------------------------------------
>[USER] ALL=(ALL) NOPASSWD: /home/[USER]/bin/fix-audio.sh
>-----------------------------------------------------------------------------
>
>================================================================================
>STEP 8: DESKTOP SHORTCUT FOR QUICK FIX
>================================================================================
>
>Create a desktop shortcut to fix audio with one click:
>
>$ nano ~/Desktop/Fix-Audio.desktop
>
>Paste:
>-----------------------------------------------------------------------------
>[Desktop Entry]
>Type=Application
>Name=Fix Audio
>Exec=gnome-terminal -- bash -c "sudo alsactl init; systemctl --user
>restart pipewire pipewire-pulse; pactl set-default-sink
>alsa_output.pci-0000_02_00.6.analog-stereo; pactl set-sink-volume
>alsa_output.pci-0000_02_00.6.analog-stereo 80%; echo 'Audio fixed!'; read
>-p 'Press Enter'"
>Icon=audio-card
>Terminal=true
>-----------------------------------------------------------------------------
>
>$ chmod +x ~/Desktop/Fix-Audio.desktop
>
>================================================================================
>STEP 9: RESET PIPEWIRE CONFIGURATION (IF OTHER METHODS FAIL)
>================================================================================
>
>If none of the above methods work, perform a full PipeWire reset:
>
>$ systemctl --user stop pipewire pipewire-pulse
>$ rm -rf ~/.config/pipewire
>$ rm -rf ~/.config/pulse
>$ rm -rf ~/.local/state/wireplumber
>$ rm -rf ~/.cache/pipewire
>$ systemctl --user start pipewire pipewire-pulse
>
>Then repeat Step 3.
>
>================================================================================
>STEP 10: INSTALL PAVUCONTROL (GRAPHICAL AUDIO MANAGEMENT TOOL)
>================================================================================
>
>$ sudo apt install pavucontrol
>
>Run:
>$ pavucontrol
>
>Go to the "Output Devices" tab:
>- Find the CX11970 device (or similar)
>- Click the green checkmark (Set as default)
>- In the "Port" dropdown, select "Speaker" instead of "Headphones"
>
>================================================================================
>DIAGNOSTICS - HOW TO CHECK WHAT'S WRONG
>================================================================================
>
>Check if the sound card is detected:
>$ aplay -l
>
>Check device status:
>$ pactl list short sinks
>
>Check available ports:
>$ pactl list cards | grep -A 20 "CX11970"
>
>Check kernel logs:
>$ dmesg | grep -i "snd\|audio\|hda"
>
>Check loaded modules:
>$ lsmod | grep snd
>
>================================================================================
>COMPARING "GOOD" AND "BAD" STATES
>================================================================================
>
>Save "good" state (when audio works):
>$ sudo cp -r /etc/modprobe.d /tmp/modprobe.d.good
>$ sudo cp -r /etc/modules-load.d /tmp/modules-load.d.good
>$ sudo cp -r /etc/pulse /tmp/pulse-system.good
>$ sudo cp -r /usr/share/pipewire /tmp/pipewire-share.good
>$ lsmod | grep snd > /tmp/snd-modules.good
>
>Save "bad" state (when audio does NOT work):
>$ sudo cp -r /etc/modprobe.d /tmp/modprobe.d.bad
>$ sudo cp -r /etc/modules-load.d /tmp/modules-load.d.bad
>$ sudo cp -r /etc/pulse /tmp/pulse-system.bad
>$ sudo cp -r /usr/share/pipewire /tmp/pipewire-share.bad
>$ lsmod | grep snd > /tmp/snd-modules.bad
>
>Compare states:
>$ diff -r /tmp/modprobe.d.good /tmp/modprobe.d.bad
>$ diff -r /tmp/modules-load.d.good /tmp/modules-load.d.bad
>$ diff -r /tmp/pulse-system.good /tmp/pulse-system.bad
>$ diff -r /tmp/pipewire-share.good /tmp/pipewire-share.bad
>$ diff /tmp/snd-modules.good /tmp/snd-modules.bad
>
>If diff shows no differences - the problem is in hardware registers.
>
>================================================================================
>WHAT DOES NOT WORK - WHAT NOT TO TRY
>================================================================================
>
>The following solutions have been tested and failed:
>
>| Method | Why It Failed |
>|--------|---------------|
>| Cron @reboot with delay | Runs too early |
>| Systemd service after sound.target | Runs before BIOS state is fully
>applied |
>| Disabling suspend in WirePlumber | Does not address hardware register
>state |
>| Blacklisting ACP modules | Does not reset hardware state |
>| Kernel parameters | Cannot override hardware register state |
>| Watchdog scripts | BIOS does not create configuration files |
>
>================================================================================
>ADDITIONAL INFORMATION - ROOT CAUSE OF THE PROBLEM
>================================================================================
>
>The problem occurs because BIOS/UEFI during initialization writes the
>audio
>controller state to hardware registers. Linux reads this state and applies
>it,
>which causes speakers to be marked as "unavailable."
>
>The state is stored in HARDWARE REGISTERS which:
>- Are not accessible via software tools
>- Are only reset during a full POST (Power-On Self-Test)
>- Are not dependent on configuration files
>
>This is why software solutions (scripts, file modifications) cannot fix
>the
>problem if the cause is in the hardware registers.
>
>================================================================================
>SUMMARY - MOST EFFECTIVE SOLUTIONS
>================================================================================
>
>1. SYSTEM RESTART - always restores audio
>   $ sudo reboot
>
>2. MANUAL FIX - when restart doesn't help
>   $ sudo alsactl init
>   $ systemctl --user restart pipewire pipewire-pulse
>   $ pactl set-default-sink alsa_output.pci-0000_02_00.6.analog-stereo
>
>3. STARTUP SCRIPT - automate the fix
>   Create ~/bin/fix-audio.sh and add to autostart
>
>4. DESKTOP SHORTCUT - one-click quick fix
>
>================================================================================
>IMPORTANT NOTE - THE F12 / F2 BIOS ISSUE
>================================================================================
>
>During extensive testing, a critical discovery was made regarding how the
>problem is triggered:
>
>| BIOS Entry Method | Effect on Audio |
>|-------------------|-----------------|
>| F12 (boot device selection menu) | ❌ Speaker audio STOPS WORKING |
>| F2 (BIOS configuration / boot order) | ✅ Audio remains INTACT |
>
>THIS MEANS:
>- Entering BIOS itself is NOT the problem
>- The problem is the SPECIFIC hardware initialization mechanism used by F12
>- If you need to change boot settings - use F2, not F12
>
>HOW THIS WORKS:
>1. BIOS/UEFI via F12 initializes the audio controller in a specific mode
>2. This state is written to hardware registers
>3. Linux reads and applies this state
>4. The state causes speakers to be marked as "unavailable"
>5. The system defaults to headphones as output
>
>RECOMMENDATION:
>- Avoid using F12 (boot menu) unless absolutely necessary
>- Use F2 (BIOS configuration) to change boot order
>- If you must use F12, perform a full restart without entering BIOS afterward
>
>================================================================================
>END OF REPORT
>================================================================================


Thanks!
