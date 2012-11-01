From: Alexander Stein <alexander.stein@systec-electronic.com>
Subject: hda: Cirrus: fixes for CS4207 coef setup
Date: Thu,  1 Nov 2012 13:42:36 +0100
Message-ID: <1351773758-1010-1-git-send-email-alexander.stein@systec-electronic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from webbox1416.server-home.net (webbox1416.server-home.net
 [77.236.96.61]) by alsa0.perex.cz (Postfix) with ESMTP id 73D292625C6
 for <alsa-devel@alsa-project.org>; Thu,  1 Nov 2012 13:42:48 +0100 (CET)
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
Cc: Takashi Iwai <tiwai@suse.de>
List-Id: alsa-devel@alsa-project.org

Hi,

I'm noticing some problems using the CS4207 codec with out custom board.
Output works fine so far, but I noticed that input on ADC1 (blue) is just mono
and input on ADC2 (pink) is reversed stereo. Both tests were done by playing
a wav on an output and directly feeding the input. After some investigations,
I found out, that coef in the patch_cirrus driver don't match the CS4207
datasheet (CS4207-F4). As the driver also mentions CS4206 I'm aware that my
pathces might not be suitable in general, but I couldn't find any datasheet
for CS4206 so I can't compare the coef settings.
Summarized here:
* The beep bits were written to the wrong index (See CS4207-F4 6.15.6.5
  BeepConfiguration(CIR=0004h))
* The DMIC enable signals were written to the wrong index (Same chapter as
  above)
As the drivers sets 2 DMIC bits each, while CS4207 has only 1 for each, the
coef interface might be different on both codec.

Maybe someone with more detailed knowledge about the CS4206 can put his
comments.

Best regards,
Alexander
