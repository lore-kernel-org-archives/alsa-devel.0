From: Florian Schmidt <mista.tapas@gmx.net>
Subject: jack plugin?
Date: Mon, 27 Oct 2003 17:50:32 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20031027175032.1d0760f3.mista.tapas@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
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



Hi,

i tried to install and use the jack plugin [alsa-lib]. I failed. Here's
what i did.

1.] tried to build alsa-lib with ./configure --with-jack. It accepted
the configure parameter, but didn't build or install the jack plugin
upon make; make install

2.] tried to go directly to alsa-lib/src/pcm/ext/ and buildt the plugin
manually. seemingly succeeded, but make install-jack failed with this
error:

tapas@mango:~/Source/BuildStuff/alsa-lib-0.9.8/src/pcm/ext$ sudo make
install-jack
/bin/sh ../../../mkinstalldirs /usr/lib/alsa-lib
/bin/sh ../../../libtool --mode=install   libasound_module_pcm_jack.la
/usr/lib/alsa-lib/libasound_module_pcm_jack.la
libtool: install: you must specify a destination
Try `libtool --help --mode=install' for more information.
make: *** [install-jack] Error 1

I then found the shared object in 

src/pcm/ext/.lib

and copied it manually to /usr/lib/alsa-lib

then i added an entry to my .asoundrc:

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

ctl.jack {
        type hw
        card 0
}

but aplay still complained about missing the shred lib. It seemingly
expected it to be in /usr/local/lib/alsa-lib. So i moved it there and
tried again. Now aplay crashes with a segfault:

tapas@mango:~/Source/BuildStuff/alsa-lib-0.9.8/src/pcm/ext$ aplay -D
jack foo.wav
snd_pcm_jack_open
Segmentation fault


Regards, Florian Schmidt


-------------------------------------------------------
This SF.net email is sponsored by: The SF.net Donation Program.
Do you like what SourceForge.net is doing for the Open
Source Community?  Make a contribution, and help us add new
features and functionality. Click here: http://sourceforge.net/donate/
