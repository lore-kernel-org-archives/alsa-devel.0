From: Paul Davis <paul@linuxaudiosystems.com>
Subject: Re: possible problems with rc6 aplay
Date: Mon, 16 Dec 2002 08:49:35 -0500
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <E18NvZT-0004yb-00@sc8-sf-list1.sourceforge.net>
References: <1040040264.1358.8.camel@Godzilla>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: Your message of "16 Dec 2002 04:04:23 PST."
             <1040040264.1358.8.camel@Godzilla>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Mark Knecht <markknecht@attbi.com>
Cc: martin-langer@gmx.de, Alsa-Devel <alsa-devel@lists.sourceforge.net>, swpatrick@earthlink.net
List-Id: alsa-devel@alsa-project.org

>Martin,
>   That might certainly be an answer. How would this amixer switch get
>st in the first place? I wouldn't mind doing it by hand once as long as
>it was then loaded after that.

what you want is a short startup script (typically in somewhere under
/etc/rc.d, but unfortunately this varies somewhat from linux
distribution to linux distribution). it would look like this:

	#!/bin/sh
	
	HAMMERFALL=0 # change to match the card number of the
		     # Hammerfall, as shown in /proc/asound/cards
        CLOCK_MODE=0 # auto-sync, the default condition.
	CLOCK_MODE_NAME="autosync"

	case $1 in
	     start) if [ -f /some/path/to/this-host-is-master ] ; then
		        CLOCK_MODE=1
			CLOCK_MODE_NAME="master"
		    else
		        CLOCK_MODE=2
			CLOCK_MODE_NAME="word clock"
		    fi  
		    echo "Setting Hammerfall to $CLOCK_MODE_NAME mode ..."
		    amixer -c $HAMMERFALL cset \
			    iface=PCM,name='Sync Mode',numid=7 $CLOCK_MODE
        esac			    
	exit 0

then, just create the file /some/path/to/this-host-is-master on one
machine, and it will automatically set the Master switch when it boots
up. the other machine will remain in AutoSync mode - if they are
connected via word clock, you probably want to change that as well,
using the same script.

if you need more help with this, let me know. this is one of those
areas where linux and its command line orientation proves so powerful
(though to be fair, its probably possible to do something vaguely
similar on windows, but not using such general-purpose tools).

--p


-------------------------------------------------------
This sf.net email is sponsored by:
With Great Power, Comes Great Responsibility 
Learn to use your power at OSDN's High Performance Computing Channel
http://hpc.devchannel.org/
