From: "Lee Revell" <rlrevell@joe-job.com>
Subject: Default device with fallback
Date: Thu, 15 Feb 2007 20:49:27 -0500
Message-ID: <75b66ecd0702151749r7df799f1pe4cd832af58ae443@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Content-Disposition: inline
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Alsa Dev <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Hey,

Lately there's been a lot of discussion on linux audio lists about the
best way to handle the default device, in the face of multiple cards
some of which could be hot-pluggable and might even be identical.

Module indices can help in a pinch but are no solution - they require
root access and can't change the default device without requiring all
sound apps to be restarted.

gnome-sound-properties comes closest to solving the problem - it
creates an .asoundrc that defines the "default" device for each user
(compare KDE which does not even try).  But if the default device is
defined to a USB audio interface, when the device is unplugged apps
will fail rather than falling back to the next available device.

How hard would it be to extend ALSA to allow defining a default PCM
that automatically falls back to the first device present if
unplugged?

As far as I can tell this would solve the ALSA device selection
problem completely (ignoring OSS emulation which is increasingly
irrelevant with the new Flash and Skype releases).

Lee

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
