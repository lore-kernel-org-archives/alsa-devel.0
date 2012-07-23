From: Lollul <lollul@wp.pl>
Subject: Audiotrak Maya U5 mixer
Date: Mon, 23 Jul 2012 17:14:26 +0200
Message-ID: <500D6A52.5080400@wp.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx3.wp.pl (mx3.wp.pl [212.77.101.7])
 by alsa0.perex.cz (Postfix) with ESMTP id EFA9A265CF9
 for <alsa-devel@alsa-project.org>; Mon, 23 Jul 2012 17:15:30 +0200 (CEST)
Received: from public110305.cdma.centertel.pl (HELO [192.168.0.5])
 (lollul@[178.56.238.225]) (envelope-sender <lollul@wp.pl>)
 by smtp.wp.pl (WP-SMTPD) with AES256-SHA encrypted SMTP
 for <alsa-devel@alsa-project.org>; 23 Jul 2012 17:15:31 +0200
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

Hello,
I'm using an Audiotrak Maya U5 USB card. As far as I can tell it is 
based on VIA EnvyUSB VT1728A chip. Running on fresh 3.5-rc7 or an old 
2.6.32.27 (on openwrt) kernel I have similar problems with the mixer:
1.
The controls PCM and PCM 1 are stuck on lowest level. It can play mp3s 
fine so I guess PCM is initialized somehow on proper levels but I would 
expect there should be a way to control PCM volume (other than by 
controlling Speaker volume).
2.
I'm unable to achieve a 'loop' between SPDIF input and the Speakers. It 
works fine with Line-In. But with SPDIF input I have to either use 
"arecord | aplay" or alsaloop. Since Windows7 is able to turn on 
'Listen' mode on SPDIF input on standard drivers I hope hardware can do 
it but somehow there is no control for this in alsamixer.

alsa-info output available at: http://pastebin.ca/2173999 (this is with 
with laptop's hda modules removed)
(Latest Audiotrak firmware was installed)

Many Thanks,
Rafal
