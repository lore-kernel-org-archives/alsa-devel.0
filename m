From: Adrian McMenamin <adrian@mcmen.demon.co.uk>
Subject: Re: [Alsa-devel] Re: Hotplug firmware problems
Date: Wed, 05 Oct 2005 20:17:25 +0100
Message-ID: <1128539845.3388.2.camel@localhost.localdomain>
References: <1128452684.5085.4.camel@localhost.localdomain>
	 <1128463170.5085.8.camel@localhost.localdomain>
	 <s5h8xx8chi3.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linuxsh-dev-admin@lists.sourceforge.net>
In-Reply-To: <s5h8xx8chi3.wl%tiwai@suse.de>
Sender: linuxsh-dev-admin@lists.sourceforge.net
Errors-To: linuxsh-dev-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linuxsh-dev>,
	<mailto:linuxsh-dev-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:linuxsh-dev@lists.sourceforge.net>
List-Help: <mailto:linuxsh-dev-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linuxsh-dev>,
	<mailto:linuxsh-dev-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linuxsh-dev>
To: Takashi Iwai <tiwai@suse.de>
Cc: linuxsh-dev@lists.sourceforge.net, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Wed, 2005-10-05 at 13:47 +0200, Takashi Iwai wrote:
> At Tue, 04 Oct 2005 22:59:30 +0100,
> Adrian McMenamin wrote:
> > 
> > On Tue, 2005-10-04 at 20:04 +0100, Adrian McMenamin wrote:
> > > I am attempting to load the firmware my device (AICA sound on Dreamcast)
> > > needs via hotplug...
> > 
> > 
> > Messed about with the hotplug scripts and now get this ... but I don't
> > know why firmware.agent doesn't load the firmware... and I assume there
> > is no sound.agent available...
> 
> Does /etc/hotplug/firmware.agent work correctly?
> 

Well, no, in the sense that no firmware is loaded :(

The logs report its invocation though I've added some echo lines into
the firware.agent I'm using and they don't appear in any log, suggesting
it isn't being found...

This is what it contains...

[adrian@mayday ~]$
cat /tftpboot/192.168.61.55/etc/hotplug/firmware.agent
#!/bin/sh
#
# Firmware-specific hotplug policy agent.
#
# Kernel firmware hotplug params include:
#
#       ACTION=%s [add or remove]
#       DEVPATH=%s [in 2.5 kernels, /sys/$DEVPATH]
#       FIRMWARE=%s
#
# HISTORY:
#
# 24-Jul-2003   Initial version of "new" hotplug agent.
#
# $Id: firmware.agent,v 1.4 2004/09/20 21:23:51 kroah Exp $
#
echo "Trying to load firmware... "
cd /etc/hotplug
. ./hotplug.functions
# DEBUG=yes export DEBUG

# directory of the firmware files
FIRMWARE_DIR=/lib/firmware

# mountpoint of sysfs
SYSFS=$(awk '$3 == "sysfs" { print $2 ; nextfile }' /proc/mounts)

# use /proc for 2.4 kernels
if [ "$SYSFS" = "" ]; then
    SYSFS=/proc
fi

#
# What to do with this firmware hotplug event?
#
echo "Trying... $ACTION"
case "$ACTION" in

add)
    if [ ! -e $SYSFS/$DEVPATH/loading ]; then
        sleep 1
    fi

    if [ -f "$FIRMWARE_DIR/$FIRMWARE" ]; then
        echo 1 > $SYSFS/$DEVPATH/loading
        cp "$FIRMWARE_DIR/$FIRMWARE" $SYSFS/$DEVPATH/data
        echo 0 > $SYSFS/$DEVPATH/loading
    else
        echo -1 > $SYSFS/$DEVPATH/loading
    fi

    ;;

remove)
    ;;

*)
    mesg "Firmware '$ACTION' event not supported"
    exit 1
    ;;

esac
[adrian@mayday ~]$




-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
