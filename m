From: Duncan Sands <baldrick@wanadoo.fr>
Subject: init script with hotplug & usb audio
Date: Thu, 26 Sep 2002 10:20:25 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200209261020.25769.baldrick@wanadoo.fr>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 8bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchives/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

I have a usb webcam with audio plugged into my computer,
and a cs46xx sound card inside.

When I boot the following sequence occurs:

(1) the hotplug subsytem is started.  This automatically
loads the snd-usb-audio module and the modules it
depends on.  In particular /proc/asound/ is created.

(2) the alsasound init script is run.  It detects that
/proc/asound/ exists, and exits at once.  In particular
it does not restore mixer levels for the cs46xx card.

I solved this by commenting out the check for /proc/asound/
in the init script.  The problem goes deeper though, especially
when things like usb audio devices are around, which can be
hotplugged: maybe sound card modules should really be calling
the hotplug subsystem when they are initialize.  The hotplug
script would then restore mixer settings etc...

Thoughts?

Duncan.


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
