From: "David E. Storey" <dave@tamos.net>
Subject: dsnoop
Date: 16 May 2003 16:24:08 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1053116648.423.11.camel@localhost>
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
To: alsa <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Folks,

Would anyone be so kind as to offer up an example of using dsnoop? I'd
like to use jack to perform all kinds on monitoring on a device and use
an alsa app, namely arecord, to do the actual recording. I've tried
using the jack plugin and while it works, when I hit CTRL-C on arecord
to stop recording, it pretty much halts jack.

When I use dsnoop now, if there's nothing using the device, it returns:

set_params:810: Channels count non available

And if something, like jack, is using the original device, it just sits
and waits without doing much of anything. My .asoundrc file looks a
little something like:

pcm.intel8x0 {
        type hw
        card 0
}

ctl.intel8x0 {
        type hw
        card 0
}

pcm.snoop {
        type dsnoop
        ipc_key 3346
        slave { pcm "intel8x0" }
}

pcm.jackplug {
        type plug
        slave { pcm "jack" }
}

pcm.jack {
        type jack
        playback_ports {
                0 alsa_pcm:playback_1
                1 alsa_pcm:playback_2
        }
        capture_ports {
                0 alsa_pcm:capture_1
                1 alsa_pcm:capture_2
        }
}

Any help would be GREATLY appreciated. And if I should be using another
list, please let me know kindly.

d!



-------------------------------------------------------
This SF.net email is sponsored by: If flattening out C++ or Java
code to make your application fit in a relational database is painful, 
don't do it! Check out ObjectStore. Now part of Progress Software.
http://www.objectstore.net/sourceforge
