From: Guillermo Keil <gkeil@ciudad.com.ar>
Subject: Problems with alsactl and via VT8235
Date: 16 May 2003 23:35:58 -0300
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1053138959.1389.15.camel@multifam-linux>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi

I am working on a Motherboard with a via VT8235 south bridge, over a Red
Hat 8.0 Linux.
I have installed the Alsa drivers for this AC97 compliant sound device
and everything was really perfect, except for recording.
After many experiments, I realize that the problem was in the last lines
of the modules.conf file, with the pre-remove and post-install.
The original lines are :

post-install sound-slot-0 /bin/aumix-minimal -f /etc/.aumixrc -L
>/dev/null 2>&1 || :
pre-remove sound-slot-0 /bin/aumix-minimal -f /etc/.aumixrc -S
>/dev/null 2>&1 || :

By Removing those lines, sound recording began to work really fine. But
every time I reboot, I had everything mutted ( I know this is the
expected behavior ).

I then changed the lines to:

post-install snd-pcm-oss /bin/alsactl restore  >/dev/null 2>/dev/null 
pre-remove snd-pcm-oss   /bin/alsactl store    >/dev/null 2>/dev/null

I am using alsactl as I have read on this mailing list that this the
only safe way to save and restore status.
This approach works, but restores the last state I manually saved some
time, not the state just before shutdown.

Why is this happening ? If I try "alsactl store" manually, the recording
does not work any longer until the driver are unloaded and reloaded
again.
Why the original lines from the RedHat installation work for restoring
the Level of all the channels, but breaks the capture functionality ?

Guillermo 






-------------------------------------------------------
This SF.net email is sponsored by: If flattening out C++ or Java
code to make your application fit in a relational database is painful, 
don't do it! Check out ObjectStore. Now part of Progress Software.
http://www.objectstore.net/sourceforge
