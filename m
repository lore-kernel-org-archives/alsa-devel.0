From: Sam Morris <sam@robots.org.uk>
Subject: Bug#517241: Laptop (Samsung Q45) speakers unmute when master channel is unmuted even with headphones connected
Date: Sat, 2 May 2009 13:14:42 +0100
Message-ID: <20090502121442.GA14055@xerces>
Reply-To: Sam Morris <sam@robots.org.uk>, 517241@bugs.debian.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <bounce-debian-bugs-dist=glddb-debian-bugs-dist=m.gmane.org@lists.debian.org>
Resent-To: debian-bugs-dist@lists.debian.org
Resent-Message-ID: <handler.517241.B517241.124126648728972@bugs.debian.org>
Content-Disposition: inline
List-Post: <mailto:debian-bugs-dist@lists.debian.org>
List-Help: <mailto:debian-bugs-dist-request@lists.debian.org?subject=help>
List-Subscribe: <mailto:debian-bugs-dist-request@lists.debian.org?subject=subscribe>
List-Unsubscribe: <mailto:debian-bugs-dist-request@lists.debian.org?subject=unsubscribe>
To: alsa-devel@alsa-project.org
Cc: 517241@bugs.debian.org, 517241-forwarded@bugs.debian.org
List-Id: alsa-devel@alsa-project.org

Since Linux 2.6.28 and through to 2.6.30-rc4, the hda-intel driver has had a
bug on my laptop (a Samsung Q45).

If I connect my headphones, the laptop's internal speakers are muted--fine. But 
if I then mute and unmute the master mixer channel, the speakers come back to
life, even though the headphones are still connected.

Please keep 517241-forwarded@bugs.debian.org CC'd in follow-ups.

-- 
Sam Morris
https://robots.org.uk/
 
PGP key id 1024D/5EA01078
3412 EA18 1277 354B 991B  C869 B219 7FDB 5EA0 1078
