From: ard@waikato.ac.nz
Subject: Concurrent access to sound device (speak freely and games)
Date: 22 Mar 2002 16:06:43 +1200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <udvk7s59rfw.fsf@area.cc.waikato.ac.nz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


Hello folks.

The Windows users surrounding me are asking why I can't run "talkie" apps
such as Speakfreely and Openh323 at the same time as Quake3, Wolfenstein,
etc.  "Windows can do it" is a pretty difficult argument to counter, and
they bring it up whenever we're having one of those discussions about the
relative merits of the two OSs.  You know the ones.


RTCW blocks when opening "/dev/dsp".  The FAQ is fairly belligerent about
what to do, so I gave this a try:

    echo "wolf.x86 0 0 non-block" > /proc/asound/card0/pcm0p/oss

After that Wolf doesn't block on the open, but receives EBUSY and runs
without sound.

SDL addressed this by mixing all connections.  Is there a way to present
OSS-emulated ALSA audio devices to applications so that they think they
have exclusive access?

I sure hope so.

-- 
_________________________________________________________________________
Andrew Donkin                                      Hamilton,  New Zealand

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel
