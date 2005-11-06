From: David Smoot <davidsmoot@gmail.com>
Subject: addressing hardware directly?
Date: Sun, 6 Nov 2005 18:07:30 +0000
Message-ID: <b15982770511061007k17711a3aq6c008b7fc4246619@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

If I am not developing a generic sound application but I specifically
want to talk to a single card, can I address a card directly in my
software rather than using the "default" or the "hw:0,0" interface?=20
My target platform is a very limited device, the less stuff I install,
the better.

So what is the naming convention for the sound devices when I call
"snd_pcm_open"?  So far all I found in the documentation is "default"
or "hw:0,0".  I've tried poking around in /proc/asound/ but have not
found it yet.

David


-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. Download
it for free - -and be entered to win a 42" plasma tv or your very own
Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
