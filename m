From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: [RFC][PATCH 0/8] A new driver for OXFW970/971
	based devices
Date: Mon, 06 Jan 2014 17:33:47 +0900
Message-ID: <52CA6A6B.1040505@sakamocchi.jp>
References: <1388920417-5584-1-git-send-email-o-takashi@sakamocchi.jp>
 <s5hob3qb4a3.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp302.phy.lolipop.jp (smtp302.phy.lolipop.jp [210.157.22.85])
 by alsa0.perex.cz (Postfix) with ESMTP id 6C99E261691
 for <alsa-devel@alsa-project.org>; Mon,  6 Jan 2014 09:33:52 +0100 (CET)
In-Reply-To: <s5hob3qb4a3.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, clemens@ladisch.de, ffado-devel@lists.sf.net
List-Id: alsa-devel@alsa-project.org

Hi Iwai-san,

 >> 1.snd-firewire-speakers and snd-oxfw
 > I don't see why these make things difficult to merge?
 > They sound rather like the functionalities don't conflict.

I think it better not to touch existed drivers unless they have some bugs.

Actually I can merge two drivers with some selection statements, many 
changes for card structure and for PCM functionality, many codes for 
MIDI and hwdep functionaloty. But for snd-firewire-speakers these 
modifications are needless and not due to bugs.

...On the other hand, I also think it good to merge these two drivers 
because they support the same chipset. But this idea have a risk to put 
some new bugs into snd-firewire-speakers.


 > Note that since I haven't seen any ack from Clemens, I didn't take
 > previous patches yet.

Yes. I've posted my patches with RFC, without merge-request. I describe 
the reason.

Devices which snd-fireworks, snd-bebob and snd-oxfw supports are 
categorized in 'GenericAVC' by FFADO. This means the devices are 
controlled by the same way, AV/C commands. At first, I considered to 
develop 'snd-genericavc', which perform like OS X implementation. But 
there were some anxieties for device quirks.

In this reason, I decide to develop them in the same time. As a result, 
I confirm each chipset/firmware has it own quirk. So now I have a 
confidence that it's difficult to develop 'snd-genericavc'.


 >  And it's a bit too late for 3.14, we have plenty of time for review 
and discussion for 3.15.

Currently I have no will to merge my patches because I need more 
discussions between ALSA/FFADO developers.

My patches add ALSA to handle devices which FFADO supports  for its 
streaming functionality. It may bring a bit complexity to users. I need 
to adjust two projects in advance of merge-request.


Thanks

Takashi Sakamoto
o-takashi@sakamocchi.jp
