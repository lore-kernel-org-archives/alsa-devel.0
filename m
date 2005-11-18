From: Stephen Hassard <steve@hassard.net>
Subject: Bug in ice1724 driver w/ m-audio revolution 7.1
Date: Thu, 17 Nov 2005 17:26:27 -0800
Message-ID: <437D2DC3.6010807@hassard.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi everyone,

I'm experiencing a fun bug in the ice1724 driver with my revolution 7.1 
cards.

This problem is reproduceable on different revolution 7.1 cards (both 
Rev.3) with different motherboard (tried 3 different boards) and 
different Linux distros (debian, suse, and slackware, and some of their 
derivatives).

I've tested in various kernel incarnations including most recently 
2.6.14 (w/ alsa version reported as 1.0.10rc1).

The problem I'm experiencing is this:

When the ice1724 driver loads, the left front stereo channel (dubbed 
'DAC' in alsamixer) is muted, even though alsamixer reports that has a 
valid valid (and audible) volume. As soon as the volume is twiddled (up 
or down; it doesn't matter) the volume is restored.

The initial 'alsactl restore' sets the alsamixer volume correctly, but 
the channel is inaudible.

Does anyone have any ideas where the bug is? It doesn't sound like this 
affects other ice1724 users, since this would be a more widespread 
problem. I guess the bug must be in the card's firmware or somewhere in 
the specific codepath for the revolution 7.1?

Can anyone take a look? I'd love to have this sorted out.

I'm also ready to offer a card to anyone who's super serious about 
solving this problem. I happen to have 2 of these cards, and wouldn't 
mind giving one away to have the problem be fixed. I'll happily pay for 
shipping in North America if someone is willing to help.

Thanks in advance,
Stephen Hassard


-------------------------------------------------------
This SF.Net email is sponsored by the JBoss Inc.  Get Certified Today
Register for a JBoss Training Course.  Free Certification Exam
for All Training Attendees Through End of 2005. For more info visit:
http://ads.osdn.com/?ad_id=7628&alloc_id=16845&op=click
