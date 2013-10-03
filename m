From: Alexander Stein <alexander.stein@informatik.tu-chemnitz.de>
Subject: ALSA lib pcm_hw.c:1466:(_snd_pcm_hw_open) Unknown
	field chmap
Date: Thu, 03 Oct 2013 21:15:51 +0200
Message-ID: <6043812.jjP6m6Xcry@kongar>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cora.hrz.tu-chemnitz.de (cora.hrz.tu-chemnitz.de
 [134.109.228.40])
 by alsa0.perex.cz (Postfix) with ESMTP id 9EDED261281
 for <alsa-devel@alsa-project.org>; Thu,  3 Oct 2013 21:16:44 +0200 (CEST)
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

I get this error message from several games I got recently. There is either not sound at all or it is choppy. This was with alsa-lib-1.0.27.1. So I downgraded to 1.0.26 and everything was fine. I compiled alsa-lib-1.0.27.1 myself and started them using LD_LIBRARY_PATH: everything worked. So I assumed there is something in the config files which has changed. Comparing them I noticed some changes in /usr/share/alsa/cards/Audigy2.conf. Those lines were added:
chmap [ "UNKNOWN" "FL,FR" ]
chmap [ "UNKNOWN" "RL,RR" ]
chmap [ "UNKNOWN" "FC,LFE" ]
chmap [ "UNKNOWN" "SL,SR" ]

See alsa-lib commits 5ba11d69dafbd4502469fd957b4580169779664c and ec7acfc408856cfe71a122e3b5387463d7b3d919. Updating to 1.0.27.1 again and commenting those lines out everything is ok now.

So I'm wondering what is the reason for this error message? How to fix that?

Thanks,
Alexander

PS: my sound card:
03:07.0 Multimedia audio controller: Creative Labs SB0400 Audigy2 Value
  1102:0008
