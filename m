From: Ferenc Wagner <wferi@afavant.elte.hu>
Subject: [Alsa-user] alsa-lib-0.9.8/test/pcm strangeness
Date: Wed, 21 Jan 2004 03:07:09 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3ohdyqvyuq.fsf__19786.8438008756$1074777597@tba.elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Resent-To: alsa-devel@lists.sourceforge.net
Resent-Message-ID: <3o4quot991.fsf@tba.elte.hu>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-user@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

               Hello!

$ ./pcm
Playback device is plughw:0,0
Stream parameters are 44100Hz, S16_LE, 1 channels
Sine wave rate is 440.0000Hz
Using transfer method: write
ALSA lib pcm.c:1876:(snd_pcm_open_conf) symbol _snd_pcm_plug_open is not defined inside (null)
Playback open error: No such device or address

But this library is already installed, so I can try:

$ gcc -Wall -pipe -g -o pcm pcm.o -lasound -lm -ldl -lpthread
$ ./pcm
Playback device is plughw:0,0
Stream parameters are 44100Hz, S16_LE, 1 channels
Sine wave rate is 440.0000Hz
Using transfer method: write

which works all right.  This is under Linux 2.4.20 PII and
ALSA 0.9.8, both compiled from source on Debian Woody.
Practically everything works (aplay, pmidi, timidity server,
audacity, xmms, quake2) but glame 1.0.2 does not:
snd_pcm_open bombs out with 'Invalid argument' on a trivial
call.  I would be grateful for insights.

-- 
Feri.


-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
_______________________________________________
Alsa-user mailing list
Alsa-user@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-user



-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
