From: Paul Winkler <pw_lists@slinkp.com>
Subject: doc update for
	http://bugtrack.alsa-project.org/main/index.php/Matrix:Vendor-Intel
Date: Mon, 17 Dec 2007 12:37:08 -0600
Message-ID: <20071217123708.A6661@slinkp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from slinkp.com (ensim2.interlix.com [64.22.224.130])
	by alsa0.perex.cz (Postfix) with ESMTP id EB51C2454C
	for <alsa-devel@alsa-project.org>; Mon, 17 Dec 2007 19:37:11 +0100 (CET)
Received: (from paul@localhost) by slinkp.com (8.11.6/8.11.6) id lBHIb8W08067
	for alsa-devel@alsa-project.org; Mon, 17 Dec 2007 12:37:08 -0600
Content-Disposition: inline
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

The page at
http://bugtrack.alsa-project.org/main/index.php/Matrix:Vendor-Intel
makes it seem that cards identified as ICH7 must use the hda_intel
driver. This is apparently not always true.  I have a dell desktop
where snd_hda_intel refuses to load.  I fired up alsaconf and it
suggested using the intel8x0.  I tried that and it works fine.

So maybe ICH7 should be added to "chipsets" in the first row on that
page.

Thanks,

- Paul Winkler


p.s. here's some system info:

pw@pw ~ $ lspci | grep audio
00:1e.2 Multimedia audio controller: Intel Corporation 82801G (ICH7 Family) AC'97 Audio Controller (rev 01)
pw@pw ~ $ cat /proc/asound/cards 
 0 [ICH7           ]: ICH4 - Intel ICH7
                      Intel ICH7 with AD1981B at irq 23
pw@pw ~ $ lsmod | grep snd
snd_intel8x0           27176  0 
snd_ac97_codec         90456  1 snd_intel8x0
ac97_bus                4224  1 snd_ac97_codec
snd_pcm                60808  2 snd_intel8x0,snd_ac97_codec
snd_timer              18440  1 snd_pcm
snd                    38192  4 snd_intel8x0,snd_ac97_codec,snd_pcm,snd_timer
snd_page_alloc          8976  2 snd_intel8x0,snd_pcm
