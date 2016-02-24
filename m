From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 0/2 v2] ALSA: oxfw: implement retries for scs1x
	at transaction failure
Date: Wed, 24 Feb 2016 09:26:31 +0900
Message-ID: <1456273593-6082-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp302.phy.lolipop.jp (smtp302.phy.lolipop.jp [210.157.22.85])
 by alsa0.perex.cz (Postfix) with ESMTP id 6C8C4260881
 for <alsa-devel@alsa-project.org>; Wed, 24 Feb 2016 01:26:41 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: clemens@ladisch.de, tiwai@suse.de
Cc: alsa-devel@alsa-project.org, ffado-devel@lists.sf.net
List-Id: alsa-devel@alsa-project.org

Hi,

This patchset updates my former post below. Changes are just adding my sign
(I forgot it...) and improvements of commit messages.

[alsa-devel] [PATCH 0/2] ALSA: oxfw: implement retries for scs1x at transaction failure
http://mailman.alsa-project.org/pipermail/alsa-devel/2016-February/104579.html

In thread of the post, I got some comments about work to extend ALSA
rawmidi core. I've investigated it in a few days ago and realized that it
may not so light work, mainly because of a lack of unified state
management[0].

In this development cycle, I'd like to give it up and use my time for the
other work within my plan for the cycle. Please just apply these two patches.

[0] In short, the state management is understandable for developers who
can understand it, and I'm not.

Regards

Takashi Sakamoto (2):
  ALSA: oxfw: retry MIDI transferring for scs1x at transaction failure
  ALSA: oxfw: discontinue MIDI substream for scs1x at transaction
    failure

 sound/firewire/oxfw/oxfw-scs1x.c | 23 +++++++++++++++++++----
 1 file changed, 19 insertions(+), 4 deletions(-)

-- 
2.5.0
