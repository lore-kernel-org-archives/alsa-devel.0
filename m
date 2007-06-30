From: Adriano Grassi <califalcon@gmail.com>
Subject: hda-Intel Realtek ALC883 chipset support
Date: Fri, 29 Jun 2007 23:13:29 -0400
Message-ID: <1183173209.7821.6.camel@XT-LaptopMain.Xtgroups.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from wx-out-0506.google.com (wx-out-0506.google.com [66.249.82.239])
	by alsa0.perex.cz (Postfix) with ESMTP id 5C2FA1037F3
	for <alsa-devel@alsa-project.org>;
	Sat, 30 Jun 2007 05:13:37 +0200 (CEST)
Received: by wx-out-0506.google.com with SMTP id r21so1107301wxc
	for <alsa-devel@alsa-project.org>; Fri, 29 Jun 2007 20:13:36 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Alsa Development Project <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hi guys I have sound on different linux distro's however only the
spdif/headphone share output, no sound from the internal speakers

I have been trying to get this work for the last 5 days no success.



So i was wondering if the support for this chipset is in place.
I even tried the lastest candidate release alsa files 14rc4 with no
luck, this is a high definition audio card with multiple outputs analog
and digital and i have tried everything i can think of with no success,
I tried multiple distro's with the same result, I don't this it is a
driver issue is probably more like a configuration issue.

Can anyone help me figure this one out.

Thanks.


 0 [Intel          ]: HDA-Intel - HDA Intel
                      HDA Intel at 0xd2300000 irq 98
  2:        : timer
  3: [ 0- 2]: digital audio playback
  4: [ 0- 1]: digital audio capture
  5: [ 0- 0]: digital audio playback
  6: [ 0- 0]: digital audio capture
  7: [ 0]   : control
  8:        : sequencer
cat: /proc/asound/Intel: Is a directory
 0 snd_hda_intel
cat: /proc/asound/oss: Is a directory
00-02: ALC883 Digital : ALC883 Digital : playback 1
00-01: ALC883 Analog : ALC883 Analog : capture 2
00-00: ALC883 Analog : ALC883 Analog : playback 1 : capture 2
cat: /proc/asound/seq: Is a directory
G0: system timer : 4000.000us (10000000 ticks)
P0-0-0: PCM playback 0-0-0 : SLAVE
P0-0-1: PCM capture 0-0-1 : SLAVE
P0-0-3: PCM capture 0-0-3 : SLAVE
P0-1-1: PCM capture 0-1-1 : SLAVE
P0-1-3: PCM capture 0-1-3 : SLAVE
P0-2-0: PCM playback 0-2-0 : SLAVE
Advanced Linux Sound Architecture Driver Version 1.0.12rc1 (Thu Jun 22
13:55:50 2006 UTC).
