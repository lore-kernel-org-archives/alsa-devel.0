From: frederik@ofb.net
Subject: feature request: "mute" indication in alsamixer is not
	self-evident
Date: Mon, 31 Aug 2015 17:19:20 -0700
Message-ID: <20150901001920.GB15028@ofb.net>
Reply-To: frederik@ofb.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ofb.net (ofb.net [64.13.131.34])
 by alsa0.perex.cz (Postfix) with ESMTP id DF3FA260627
 for <alsa-devel@alsa-project.org>; Tue,  1 Sep 2015 02:19:20 +0200 (CEST)
Content-Disposition: inline
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
List-Id: alsa-devel@alsa-project.org

When a user presses 'm' for 'mute' in alsamixer, then a string "MM"
appears at the bottom of a volume control. This change makes it
obvious to the user that "MM" stands for "Mute".

However, when a new user opens alsamixer after some software on his
computer has (perhaps by mistake) automatically muted a volume
control, the "MM" won't indicate anything obvious. Among other things,
this makes it difficult for new users to debug issues with the
auto-mute feature. The fact that the volume control can be at maximum,
even when the control is muted, contributes to the potential for
confusion. The problem would be solved if, for instance, the "Item: "
string at the top of the alsamixer screen were changed to contain the
word "(muted)" for muted controls. This way, users who don't have
sound will see what the problem is when they open alsamixer.

(from <https://bugs.freedesktop.org/show_bug.cgi?id=91781>, edited)
