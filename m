From: "Ivica Bukvic" <ico@fuse.net>
Subject: interesting info regarding hdsp behavior
Date: Mon, 27 Jan 2003 01:40:07 -0500
Sender: alsa-user-admin@lists.sourceforge.net
Message-ID: <000001c2c5ce$eed8b6b0$ac1f830a@ICO>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-user-admin@lists.sourceforge.net>
Errors-To: alsa-user-admin@lists.sourceforge.net
List-Help: <mailto:alsa-user-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-user@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-user>,
	<mailto:alsa-user-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-user>,
	<mailto:alsa-user-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-user>
To: linux-audio-dev@music.columbia.edu, alsa-devel@lists.sourceforge.net, alsa-user@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi all,

I've been messing with hdsp and found out an interesting issue. After
installing the driver for the first time onto the xp machine I also had
no sound coming out of the soundcard even though totalmix app showed
levels to be up. After clicking on the levels and/or moving them a bit,
suddenly the sound was there (as if the default values were there only
in the app itself, but did not affect the actual levels on the card
until they were moved for the first time). I was wondering maybe this is
the problem we're having in Linux, where the card loads just fine, but
for some reason there is no sound until a reboot has taken place.

I know this may be completely stupid thing to pursue, but since I've
heard of no fix for this issue, I thought this may be a possible
culprit. I am still struggling with the Linux driver (I got the card
working on an Dell Inspiron 8200 where the card posts and everything
supposedly works, but there is no sound coming from it), so perhaps as
dumb as this sounds, this may be the solution to the problem we've been
having with the hdsp in Linux.

I should also mention that I am using hdsp pcmcia interface and that
I've flashed it using the latest update from the rme-audio website
(could this also have something to do with it?).

Any info on this issue is greatly appreciated. Sincerely,

Ivica Ico Bukvic




-------------------------------------------------------
This SF.NET email is sponsored by:
SourceForge Enterprise Edition + IBM + LinuxWorld = Something 2 See!
http://www.vasoftware.com
