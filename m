From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: [PATCH 06/13] speakers: Change the way to make PCM
	rules/constraints
Date: Sun, 12 Jan 2014 23:44:24 +0900
Message-ID: <52D2AA48.3020203@sakamocchi.jp>
References: <1388920417-5584-1-git-send-email-o-takashi@sakamocchi.jp>
 <1389367775-21360-1-git-send-email-o-takashi@sakamocchi.jp>
 <1389367775-21360-7-git-send-email-o-takashi@sakamocchi.jp>
 <20140112131855.71976e86@stein>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp302.phy.lolipop.jp (smtp302.phy.lolipop.jp [210.157.22.85])
 by alsa0.perex.cz (Postfix) with ESMTP id 5B7332618F2
 for <alsa-devel@alsa-project.org>; Sun, 12 Jan 2014 15:44:30 +0100 (CET)
In-Reply-To: <20140112131855.71976e86@stein>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Stefan Richter <stefanr@s5r6.in-berlin.de>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, clemens@ladisch.de, ffado-devel@lists.sf.net
List-Id: alsa-devel@alsa-project.org

Hi Stefan,

 > I have got both devices.  I could perform specific tests with them if
 > you want and give me instructions.  It can be a very slow process
 > though because I have got almost no spare time, at least throughout
 > January and February.

Thank you. Please confirm these items below with Clemens' jujuutils when 
you have a free  time:

1.They have both iPCR/oPCR.
  $ ./firewire-request /dev/fw1 read 0xfffff0000900 (oMPR)
  $ ./firewire-request /dev/fw1 read 0xfffff0000980 (iMPR)
If they have, I can apply the same way to change sampling rate for all 
of models.

2.They can respond to 'SINGLE' subfunction of 'AV/C Stream Format 
Information' command.
   $ ./firewire-request /dev/fw1 fcp  0x01ffbfc000000000ffffffff
    response: 000: 0c ff bf c0 00 00 00 00 ff 00 90 40 04 02 01 02 
...........@....
    response: 010: 06
   This is an example of Behringer F-Control A 202(OXFW970).

3.They can respond to 'LIST' subfunction of 'AV/C Stream Format 
Information' command.
   $ ./firewire-request /dev/fw1 fcp  0x01ffbfc100000000ffff01ff
   I have no devices which supports this command. I guess OXFW971 
supports this.

It's better to receive your results till the middle of February.

I have a plan to post all of my patches with many fixments in the end of 
January. This may be my last RFCs. Then I recall for testing to some 
mailing lists like LAD. If everything goes well, I hope to post 
merge-request in the end of February.


Thanks

Takashi Sakamoto
o-takashi@sakamocchi.jp
