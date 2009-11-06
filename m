From: Victor Stinner <victor.stinner@haypocalc.com>
Subject: (SCH Poulsbo) HD Audio Controller
Date: Fri, 06 Nov 2009 18:25:03 +0100
Message-ID: <4AF45BEF.8050503@haypocalc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp6-g21.free.fr (smtp6-g21.free.fr [212.27.42.6])
	by alsa0.perex.cz (Postfix) with ESMTP id 2F05E244F5
	for <alsa-devel@alsa-project.org>; Fri,  6 Nov 2009 18:50:08 +0100 (CET)
Received: from smtp6-g21.free.fr (localhost [127.0.0.1])
	by smtp6-g21.free.fr (Postfix) with ESMTP id DCD62E080C2
	for <alsa-devel@alsa-project.org>; Fri,  6 Nov 2009 18:50:06 +0100 (CET)
Received: from [192.168.0.11] (mol67-2-88-164-127-124.fbx.proxad.net
	[88.164.127.124])
	by smtp6-g21.free.fr (Postfix) with ESMTP id EDC9FE08017
	for <alsa-devel@alsa-project.org>; Fri,  6 Nov 2009 18:50:03 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi,

I bought a new Eee PC 1101HA. It uses the "Intel System Controller Hub 
(SCH) US15W" chipset which includes the "ALC269" (Intel "HD" audio 
chipset). The pci identifier of the audio sound card is 8086:811b. On 
Fedora, the snd-hda-intel kernel (from ALSA 1.0.20) module is loaded, 
but i don't hear anything.

On IRC (#alsa on Freenode), gnubien gave me the trick to make it 
working: write the following configuration in /etc/modprobe.d/alsa.conf 
file:

    options snd-hda-intel model=eeepc-p901

Without the model trick, my playback controls are:

- Master
- Headphone
- PCM
- Front
- Front Mic
- Front Mic Boost
- Beep

With model=eeepc-p901, playback controls are:

- LineOut
- Mic Boost
- Beep
- iSpeaker

Thanks to model=eeepc-p901, the sound works correctly.

Here is the output of alsa-info.sh script:

http://www.alsa-project.org/db/?f=3ae0754e841558e9b88a51ceebd5e7a491639750

PS: Please "CC" me to your anwsers.

Victor Stinner
