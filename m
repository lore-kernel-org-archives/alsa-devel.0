From: Tom Li <biergaizi2009@gmail.com>
Subject: broadwell-audio is unable to initialize on certain
	laptops
Date: Tue, 27 Jan 2015 00:52:33 +0800
Message-ID: <CAB6YEzXecp3nDsyN=Ppb1d1Rkejvkvp9G-zzVmdBAkcQ-z0U0Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ob0-f169.google.com (mail-ob0-f169.google.com
 [209.85.214.169])
 by alsa0.perex.cz (Postfix) with ESMTP id 1611C26064A
 for <alsa-devel@alsa-project.org>; Mon, 26 Jan 2015 17:52:55 +0100 (CET)
Received: by mail-ob0-f169.google.com with SMTP id va8so8716670obc.0
 for <alsa-devel@alsa-project.org>; Mon, 26 Jan 2015 08:52:53 -0800 (PST)
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

Hello everyone.

I'm here for reporting an issue.

I bought a new ThinkPad Helix 2, but I found that the built-in sound
output device is not recognize, only external HDMI sound output is
possible.

# aplay -l
**** List of PLAYBACK Hardware Devices ****
card 0: HDMI [HDA Intel HDMI], device 3: HDMI 0 [HDMI 0]
  Subdevices: 0/1
  Subdevice #0: subdevice #0
card 0: HDMI [HDA Intel HDMI], device 7: HDMI 1 [HDMI 1]
  Subdevices: 1/1
  Subdevice #0: subdevice #0
card 0: HDMI [HDA Intel HDMI], device 8: HDMI 2 [HDMI 2]
  Subdevices: 1/1
  Subdevice #0: subdevice #0

When I check dmesg output, I found some error message that indicated
that broadwell-audio is unable to initialize.

# dmesg | egrep "sound|audio"
[    1.827797] input: HDA Intel HDMI HDMI/DP,pcm=3 as
/devices/pci0000:00/0000:00:03.0/sound/card0/input8
[    1.827935] input: HDA Intel HDMI HDMI/DP,pcm=7 as
/devices/pci0000:00/0000:00:03.0/sound/card0/input9
[    1.828071] input: HDA Intel HDMI HDMI/DP,pcm=8 as
/devices/pci0000:00/0000:00:03.0/sound/card0/input10
[    1.952913] broadwell-audio broadwell-audio: ASoC: CPU DAI System
Pin not registered
[    1.952924] platform broadwell-audio: Driver broadwell-audio
requests probe deferral
[    2.062812] broadwell-audio broadwell-audio: ASoC: CPU DAI System
Pin not registered
[    2.062837] platform broadwell-audio: Driver broadwell-audio
requests probe deferral
[    2.350951] broadwell-audio broadwell-audio: ASoC: CPU DAI System
Pin not registered
[    2.350987] platform broadwell-audio: Driver broadwell-audio
requests probe deferral
[    2.375744] broadwell-audio broadwell-audio: ASoC: CPU DAI System
Pin not registered
[    2.375759] platform broadwell-audio: Driver broadwell-audio
requests probe deferral
[    2.386019] broadwell-audio broadwell-audio: ASoC: CPU DAI System
Pin not registered
[    2.386037] platform broadwell-audio: Driver broadwell-audio
requests probe deferral
[    2.706751] broadwell-audio broadwell-audio: ASoC: CPU DAI System
Pin not registered
[    2.706777] platform broadwell-audio: Driver broadwell-audio
requests probe deferral
[    3.042190] broadwell-audio broadwell-audio: ASoC: CPU DAI System
Pin not registered
[    3.042202] platform broadwell-audio: Driver broadwell-audio
requests probe deferral
[    3.048200] broadwell-audio broadwell-audio: ASoC: CPU DAI System
Pin not registered
[    3.048212] platform broadwell-audio: Driver broadwell-audio
requests probe deferral
[    3.048382] broadwell-audio broadwell-audio: ASoC: CPU DAI System
Pin not registered
[    3.048391] platform broadwell-audio: Driver broadwell-audio
requests probe deferral
[    3.199788] broadwell-audio broadwell-audio: ASoC: CPU DAI System
Pin not registered
[    3.199812] platform broadwell-audio: Driver broadwell-audio
requests probe deferral
[    3.208241] broadwell-audio broadwell-audio: ASoC: CPU DAI System
Pin not registered
[    3.208259] platform broadwell-audio: Driver broadwell-audio
requests probe deferral
[    3.216577] broadwell-audio broadwell-audio: ASoC: CPU DAI System
Pin not registered
[    3.216600] platform broadwell-audio: Driver broadwell-audio
requests probe deferral
[    3.270629] broadwell-audio broadwell-audio: ASoC: CPU DAI System
Pin not registered
[    3.270659] platform broadwell-audio: Driver broadwell-audio
requests probe deferral
[    3.324400] broadwell-audio broadwell-audio: ASoC: CPU DAI System
Pin not registered
[    3.324419] platform broadwell-audio: Driver broadwell-audio
requests probe deferral
[    3.604723] broadwell-audio broadwell-audio: ASoC: CPU DAI System
Pin not registered
[    3.604755] platform broadwell-audio: Driver broadwell-audio
requests probe deferral
[    3.604800] broadwell-audio broadwell-audio: ASoC: CPU DAI System
Pin not registered
[    3.604817] platform broadwell-audio: Driver broadwell-audio
requests probe deferral
[    3.673159] broadwell-audio broadwell-audio: ASoC: CPU DAI System
Pin not registered
[    3.673190] platform broadwell-audio: Driver broadwell-audio
requests probe deferral
[    3.727312] broadwell-audio broadwell-audio: ASoC: CPU DAI System
Pin not registered
[    3.727352] platform broadwell-audio: Driver broadwell-audio
requests probe deferral
[    3.727387] broadwell-audio broadwell-audio: ASoC: CPU DAI System
Pin not registered
[    3.727401] platform broadwell-audio: Driver broadwell-audio
requests probe deferral


I tried both 3.18.3 and 3.19.0-rc6, the results were same. It seems
that we need to add some quirks for this hardware. I also found a
similar bug on Launchpad [0].

I filed a kernel bug [1] and I hope someone could fix it.

[0]: https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1413446
[1]: https://bugzilla.kernel.org/show_bug.cgi?id=92061

Thanks.
