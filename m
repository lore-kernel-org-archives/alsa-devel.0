From: ValdikSS <iam@valdikss.org.ru>
Subject: Broken powersave in 3.5.2, codec is always active
Date: Sat, 18 Aug 2012 12:44:29 +0700
Message-ID: <op.wi718fk8rz4thc@valaptop>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"; DelSp="yes"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-lb0-f179.google.com (mail-lb0-f179.google.com
 [209.85.217.179])
 by alsa0.perex.cz (Postfix) with ESMTP id BA90B2661CF
 for <alsa-devel@alsa-project.org>; Sat, 18 Aug 2012 07:14:47 +0200 (CEST)
Received: by lbao2 with SMTP id o2so2053352lba.38
 for <alsa-devel@alsa-project.org>; Fri, 17 Aug 2012 22:44:33 -0700 (PDT)
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

Hello!
I have a Lenovo ThinkPad X220 laptop with a conexant codec and recently  
(after kernel 3.5.2) it is active all the time after KDE login, as  
powertop says. This couldn't be fixed by logging of from KDE or playing  
some music in mplayer from console. The only kernel I tried in 3.5.x is  
3.5.2, so I can't say is this bug reproducible in 3.5.0 or 3.5.1, but  
everything is fine with 3.4.9. This never happens if you don't start KDE  
after reboot, you can listen to some music in mplayer in console and  
everything seems to be fine. lsof and fuser /dev/snd/* shows nothing.
Thank you!

$ cat /etc/modprobe.d/options.conf
options snd-hda-intel power_save=1 power_save_controller=1

$ lspci -nn | grep Audio
00:1b.0 Audio device [0403]: Intel Corporation 6 Series/C200 Series  
Chipset Family High Definition Audio Controller [8086:1c20] (rev 04)

$ lsmod | grep snd
snd_hda_codec_hdmi     23704  1
snd_hda_codec_conexant    47158  1
snd_hda_intel          25700  2
snd_hda_codec          97400  3  
snd_hda_codec_hdmi,snd_hda_codec_conexant,snd_hda_intel
snd_hwdep               6300  1 snd_hda_codec
snd_pcm                74926  3  
snd_hda_codec_hdmi,snd_hda_codec,snd_hda_intel
snd_page_alloc          7185  2 snd_pcm,snd_hda_intel
snd_timer              18966  1 snd_pcm
snd                    60021  12  
snd_hwdep,snd_timer,snd_hda_codec_hdmi,snd_hda_codec_conexant,snd_pcm,snd_hda_codec,snd_hda_intel,thinkpad_acpi
soundcore               5442  1 snd
