From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: [PATCH 06/13] speakers: Change the way to make PCM
	rules/constraints
Date: Sat, 01 Feb 2014 15:31:43 +0900
Message-ID: <52EC94CF.2010306@sakamocchi.jp>
References: <1388920417-5584-1-git-send-email-o-takashi@sakamocchi.jp>
 <1389367775-21360-1-git-send-email-o-takashi@sakamocchi.jp>
 <1389367775-21360-7-git-send-email-o-takashi@sakamocchi.jp>
 <20140112131855.71976e86@stein> <52D2AA48.3020203@sakamocchi.jp>
 <20140130152117.186f08d5@stein>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp303.phy.lolipop.jp (smtp303.phy.lolipop.jp [210.157.22.87])
 by alsa0.perex.cz (Postfix) with ESMTP id 3053D26500C
 for <alsa-devel@alsa-project.org>; Sat,  1 Feb 2014 07:31:51 +0100 (CET)
In-Reply-To: <20140130152117.186f08d5@stein>
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

Thanks to get these logs. It's really helpful to me.

>> 1.They have both iPCR/oPCR.

They have no oPCRs, against my guess.

I wrote snd-oxfw with an assumption that devices have iPCR/oPCR. So I 
must write some patches for my last RFC:

http://mailman.alsa-project.org/pipermail/alsa-devel/2014-January/071820.html

>> 2.They can respond to 'SINGLE' subfunction of 'AV/C Stream Format
>> Information' command.

OK. They supports this subfunction.

>> 3.They can respond to 'LIST' subfunction of 'AV/C Stream Format
>> Information' command.

OK. They supports this subfunction. The snd-oxfw can detect 
channnels/rates for these devices instead of hard-coded parameters.


Thanks

Takashi Sakamoto
o-takashi@sakamocchi.jp
