From: Fernando Pablo Lopez-Lezcano <nando@ccrma.Stanford.EDU>
Subject: Re: Re: [Alsa-user] [lack of] dynamic
	detection/loading of modules
Date: 27 Feb 2003 12:31:47 -0800
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1046377908.22504.19.camel@cmn37.Stanford.EDU>
References: <Pine.LNX.4.44.0302271037550.1109-100000@pnote.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.44.0302271037550.1109-100000@pnote.perex-int.cz>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Jaroslav Kysela <perex@suse.cz>
Cc: Ivica Bukvic <ico@fuse.net>, "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>, "alsa-user@lists.sourceforge.net" <alsa-user@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

> Note that the problem is already solveable with a nice way. The SuSE uses
> this hotplug script:
> 
> -------------------------
> #!/bin/bash
> #
> # /etc/hotplug/usb/alsasound
> #
> # Sets up newly plugged in USB audio/MIDI devices.
> #
> 
> if [ "$INTERFACE" != "" ]; then
>     IFS=/
>     set $INTERFACE ''
>     usb_bInterfaceClass=$1
>     usb_bInterfaceSubClass=$2
>     usb_bInterfaceProtocol=$3
>     IFS="$DEFAULT_IFS"
> fi
> 
> function add_alsa () {
>     # check alsa is already running
>     if [ ! -d /proc/asound ]; then
> 	# start alsasound script, so that static devices are properly loaded
> 	echo "Starting ALSA..."
> 	/etc/init.d/alsasound start >/dev/null 2>&1
>     fi
>     /sbin/modprobe snd-usb-audio

If I have snd-usb-audio configured in modules.conf snd-usb-audio will
already be loaded at this point (I think). 

>     if [ "$usb_bInterfaceSubClass" != "0x01" ]; then
>       /sbin/modprobe snd-usb-midi
>     fi
> }
> 
> function remove_alsa () {
>     /sbin/modprobe -r snd-usb-midi
>     /sbin/modprobe -r snd-usb-audio
> }
> 
> case "$ACTION" in
> add)
>   add_alsa
>   ;;
> remove)
>   remove_alsa
>   ;;
> esac
> -----------------------
> 
> So, if no static ALSA drivers are loaded, load them before usb module is
> inserted. Nice way to solve all your problems.

Very nice! The only downside I see is that you can no longer disable the
script. If you disable it for all run levels it will run anyway if you
plug in a usb audio device (which probably makes sense for the usb
device itself), and will try to start all non-usb audio devices. Maybe
SuSE takes this into account as well, I don't know. 

Does this also need a usb.usermap entry(ies) to trigger the script?

What happens with multiple usb audio/midi devices? They all share one
snd-usb-audio module. What happens when I unplug one device? The module
gets removed and all devices that are still plugged in are orphaned?

-- Fernando




-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
