From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: include/uapi/firewire.h for other firewire drivers
Date: Fri, 25 Oct 2013 21:14:10 +0900
Message-ID: <526A6092.4030709@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp303.phy.lolipop.jp (smtp303.phy.lolipop.jp [210.157.22.87])
 by alsa0.perex.cz (Postfix) with ESMTP id 21D0C265581
 for <alsa-devel@alsa-project.org>; Fri, 25 Oct 2013 14:14:16 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Clemens Ladisch <clemens@ladisch.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi Clemens,

About include/uapi/firewire.h, I'd like you to give me an advice.

I'm sorry but I have little knowledgement about Dice chipset. So here I 
want to know what I should do for snd-fireworks/snd-bebob.

The header file includes an interface  for users to know its already 
streaming or not, and lock it. But for Fireworks/BeBoB, I think checking
CMP connections do the same thing.

Current FFADO can be failed when CMP connections on the device are
established, and ALSA can do the same. (but there are some problems.
both drivers set sampling rate before checking CMP connections. For this
I have a plan to post a patch for both FFADO and ALSA.)

Should I implement the same lock for Fireworks/BeBoB drivers?


Regards

Takashi Sakamoto
