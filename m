From: Guillaume Desclaux <guillaume@desclaux.fr>
Subject: hda problem on Gigabyte GA-Z87X-UD3H motherboard
Date: Mon, 23 Dec 2013 14:21:56 +0100
Message-ID: <52B838F4.3030701@desclaux.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail01.one2net.net (mail5.one2net.net [5.39.67.68])
 by alsa0.perex.cz (Postfix) with ESMTP id 680612608B7
 for <alsa-devel@alsa-project.org>; Mon, 23 Dec 2013 14:21:58 +0100 (CET)
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

Hi,

I've reported an issue with snd-hda-intel with my Gigabyte GA-Z87X-UD3H
motherboard on Launchpad but it seems not the best place to that

See :https://bugs.launchpad.net/bugs/1248116

In "Volume control PulseAudio", I can see pulseaudio changing the audio
output "Internal Audio Analogic Stereo". The port switch rapidly from
"Analogic output" to "Analogic headphones" making a jerky sound.

You can find the trace.log file here :

https://bugs.launchpad.net/ubuntu/+source/pulseaudio/+bug/1248116/+attachment/3934401/+files/trace.log

It seems that there are many hda_power_count

1/ This problem appears with the front connector on the motherboard connected to a HDA front panel on the case (I've double-checked the connection)
2/ The problem still appears when the front connector on the motherboard is not connected at all to the case !
3/ This bug seems quite common with Gigabyte motherboard : If you search with Google "Gigabyte Z87X hda" you will find other descriptions of this same strange behavior :

https://bugs.launchpad.net/ubuntu/+source/alsa-driver/+bug/1242302
https://bugs.launchpad.net/ubuntu/+source/alsa-driver/+bug/1067434


If I disable jack detection by specifying a hint for early patching (jack_detect = no), the sound is cristal clear !

If there is anything I can do to help you understand what happens, don't hesitate to ask.

Best regards

Guillaume
