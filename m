From: "Ivica Bukvic" <ico@fuse.net>
Subject: RE: [Alsa-user] [lack of] dynamic detection/loading of modules
Date: Thu, 27 Feb 2003 08:05:49 -0500
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <000b01c2de60$f31dd340$aa1f830a@ICO>
References: <Pine.LNX.4.44.0302271037550.1109-100000@pnote.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
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
To: 'Jaroslav Kysela' <perex@suse.cz>
Cc: alsa-devel@lists.sourceforge.net, alsa-user@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

I presume I need to blacklist the snd-usb-audio/midi in the
/etc/hotplug/blacklist for this to work?

Also, do I need to make any other changes or as long as I put this
script into the /etc/hotplug/ dir I am set?

Thanks for the great script!

(is this going to become a standard part of the alsa driver? I sure hope
so :-)

Ico



> Note that the problem is already solveable with a nice way. The SuSE
uses
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
> 	# start alsasound script, so that static devices are properly
loaded
> 	echo "Starting ALSA..."
> 	/etc/init.d/alsasound start >/dev/null 2>&1
>     fi
>     /sbin/modprobe snd-usb-audio
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
> So, if no static ALSA drivers are loaded, load them before usb module
is
> inserted. Nice way to solve all your problems.
> 
> 						Jaroslav
> 
> -----
> Jaroslav Kysela <perex@suse.cz>
> Linux Kernel Sound Maintainer
> ALSA Project, SuSE Labs




-------------------------------------------------------
This SF.NET email is sponsored by:
SourceForge Enterprise Edition + IBM + LinuxWorld = Something 2 See!
http://www.vasoftware.com
