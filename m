From: Filip djMedrzec Zyzniewski <alsa@filip.eu.org>
Subject: Remote soundcards.
Date: Sun, 1 Feb 2004 14:14:51 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040201131451.GA32174@ekatalog.com.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
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

Hello.

I have had this idea for some time now, and would like to ask you for your
opinions on it.

There are several solutions for sound transport. Software like esound, nas,
arts etc.
All those things have two common problems:
1. They're focused on pcm devices (lacks in mixer support etc)
2. They're not transparent for apps, no common API.
3. They suffer from lags.

But we have a nice alsa API, we have support for multiple cards in alsa
itself. Now how about developing a patch for alsa-lib, and a small daemon, 
which together could create a network transparent link, so that local apps
(like xmms, mplayer, aumix, mixer_applet, pmidi etc) could use it as an
ordinary soundcard?

It would:
1. support all devices alsa supports (and their pcms, sequencers and mixers)
2. be usable for any alsa-compatible app
3. not suffer from lags (as a tool for LAN networks, we maybe could get 
   away with soundcard's buffer), it would be usable for applications
   like Internet telephony (gnomemeeting etc)

Who would need this? Linux gets more and more office desktop computers 
under it's control. Common solution (my company implements these too) are
xterminals, dumb boxen with Xserver.
There is a need for convenient usage of local devices from main server.
for graphics/keyboard/mouse we have XFree86. But no decent solution
for sound stuff!.


What do you think about it?


bye,
Filip djMedrzec Zyzniewski


-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
