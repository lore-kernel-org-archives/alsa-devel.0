From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: [PATCH 06/13] speakers: Change the way to make PCM
	rules/constraints
Date: Mon, 03 Feb 2014 12:07:55 +0900
Message-ID: <52EF080B.4040207@sakamocchi.jp>
References: <1388920417-5584-1-git-send-email-o-takashi@sakamocchi.jp>
 <1389367775-21360-1-git-send-email-o-takashi@sakamocchi.jp>
 <1389367775-21360-7-git-send-email-o-takashi@sakamocchi.jp>
 <20140112131855.71976e86@stein> <52D2AA48.3020203@sakamocchi.jp>
 <20140130152117.186f08d5@stein> <52EC94CF.2010306@sakamocchi.jp>
 <20140202164504.20523579@stein>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp303.phy.lolipop.jp (smtp303.phy.lolipop.jp [210.157.22.87])
 by alsa0.perex.cz (Postfix) with ESMTP id 73396265104
 for <alsa-devel@alsa-project.org>; Mon,  3 Feb 2014 04:08:04 +0100 (CET)
In-Reply-To: <20140202164504.20523579@stein>
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

Stefan,

 > Neither LaCie FireWire Speakers nor Griffin FireWave have physical
 > recording inputs. It is therefore sensible that they present
 > OUTPUT_MASTER_PLUG.output_plugs == 0.

In this case for Lacie/Griffin, this reasoning is true.

But it's not always true.

I did adhere to infrastructure for non 'SYT-Match' when I wrote snd-oxfw.

 > I haven't tried your patches yet):

The snd-oxfw with these patches cannot handle Lacie/Griffin.
It fails in probe() function. It's my fault.
I've update these patches and push them into my repository.
Please use my repository when you test.


Regards

Takashi Sakamoto
