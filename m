From: Kailang <kailang@realtek.com>
Subject: Verb for 0x17 pin config
Date: Wed, 5 Aug 2015 06:42:03 +0000
Message-ID: <6FAB7C47BCF00940BB0999A99BE3547A17A1F778@RTITMBSV09.realtek.com.tw>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [60.250.210.242])
 by alsa0.perex.cz (Postfix) with ESMTP id EDF20265B63
 for <alsa-devel@alsa-project.org>; Wed,  5 Aug 2015 08:42:08 +0200 (CEST)
Content-Language: zh-TW
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "Takashi Iwai (tiwai@suse.de)" <tiwai@suse.de>
Cc: " (alsa-devel@alsa-project.org)" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hi Takashi,
 
commit http://git.kernel.org/cgit/linux/kernel/git/tiwai/sound.git/commit/?id=977e627684df0f60bdf2a768ec4772f42fe843fc
ALSA: hda/realtek - Support Dell headset mode for ALC298

Dell had use verb to do speaker preset. So, The same SSID maybe 0x17 verb was different.

0x17 0x90170110
0x17 0x90170140
0x17 0x90170150

Upper verb will show on this case.

Could I change it to quirk for SSID?

BR,
Kailang
