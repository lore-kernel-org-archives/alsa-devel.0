From: Fernando Pablo Lopez-Lezcano <nando@ccrma.Stanford.EDU>
Subject: Re: [Alsa-user] Re: [lack of] dynamic
	detection/loading of modules
Date: 05 Mar 2003 10:03:47 -0800
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1046887427.10930.24.camel@cmn37.Stanford.EDU>
References: <E18oElA-0005cD-00@sc8-sf-list1.sourceforge.net>
	<1046378100.22559.23.camel@cmn37.Stanford.EDU>
	<s5hptpcihlv.wl@alsa2.suse.de>
	<1046833285.28937.243.camel@cmn37.Stanford.EDU>
	<s5hbs0qf7ug.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-t6C/fUfbxxnR8N35TDDA"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hbs0qf7ug.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: Paul Davis <paul@linuxaudiosystems.com>, Ivica Bukvic <ico@fuse.net>, alsa-devel@lists.sourceforge.net, alsa-user@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


--=-t6C/fUfbxxnR8N35TDDA
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

> > Thanks! I started working on differentiating in the alsasound alsa
> > startup script between a full start (all modules are loaded when
> > alsasound executes) and a partial start (some of the modules are already
> > loaded when alsasound executes and it has to load the rest). 
> > 
> > The first naive question is: do we actually need to differenciate?
> > Apparently modprobe is happy to be given the name of a module that is
> > already loaded, as far as I can tell it does not try to load it again
> > (man modprobe does not say anything about this case that I can see). 
> 
> alsasound script calls alsactl and card-specific scripts (if any).
> this should be avoided in the case of partial load.

Yes, I took care of executing them just for the cards that had been
loaded. 

> IIRC, modprobe returns 0 even if called with the existing module.
> (if the load failed, it returns 255, btw).
> thus, we cannot check this only from the return value of modprobe.
> instead we need to grep /proc/asound/modules for that module.

That's what I'm doing, more or less. I'm including a copy of the
modified alsasound script I'm testing. Seems to be working fine so far. 

I think the sequencer driver part is wrong. I don't know what is
expected there (ie: multiple drivers?). I suspect I have to turn that
part of the code into a loop iterating over all sequencer drivers. 

-- Fernando


--=-t6C/fUfbxxnR8N35TDDA
Content-Disposition: attachment; filename=alsasound
Content-Transfer-Encoding: quoted-printable
Content-Type: text/x-sh; name=alsasound; charset=ISO-8859-1

#!/bin/bash
#
# alsasound     This shell script takes care of starting and stopping
#               the ALSA sound driver.
#
# This script requires /usr/sbin/alsactl and /usr/bin/aconnect programs
# from the alsa-utils package.
#
# Copyright (c) by Jaroslav Kysela <perex@suse.cz>=20
#
#
#  This program is free software; you can redistribute it and/or modify
#  it under the terms of the GNU General Public License as published by
#  the Free Software Foundation; either version 2 of the License, or
#  (at your option) any later version.
#
#  This program is distributed in the hope that it will be useful,
#  but WITHOUT ANY WARRANTY; without even the implied warranty of
#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#  GNU General Public License for more details.
#
#  You should have received a copy of the GNU General Public License
#  along with this program; if not, write to the Free Software
#  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307 USA
#
#
# For RedHat 5.0+:
# chkconfig: 2345 87 14
# description: ALSA driver
#
# modified to visually fit into SuSE 6.0+ by Philipp Thomas <pthomas@suse.d=
e>
# further improvements by Bernd Kaindl, Olaf Hering and Takashi Iwai.
#=20
### BEGIN INIT INFO
# Provides:       alsasound
# Required-Start: $remote_fs
# Required-Stop: $remote_fs
# Default-Start:  2 3 5
# Default-Stop:
# Description:    Loading ALSA drivers and store/restore the current settin=
g
### END INIT INFO

if [ -e /etc/rc.d/init.d/functions ] ; then
  # redhat function library
  redhat=3D1
  . /etc/rc.d/init.d/functions
fi

if [ -r /etc/rc.config ]; then
  . /etc/rc.config
  rc_warning=3D"\033[33m\033[1m"
else
  rc_done=3D"done"
  rc_warning=3D""
  rc_reset=3D""
fi

if [ x$START_ALSA !=3D xno ]; then
  START_ALSA=3Dyes
fi
if [ x$START_ALSA_SEQ !=3D xno ]; then
  START_ALSA_SEQ=3Dyes
fi

# Determine the base and follow a runlevel link name.
base=3D${0##*/}
link=3D${base#*[SK][0-9][0-9]}

# Force execution if not called by a runlevel directory.
test $link =3D $base && START_ALSA=3Dyes
test "$START_ALSA" =3D yes || exit 0

alsactl=3D/usr/sbin/alsactl
asoundcfg=3D/etc/asound.state
aconnect=3D/usr/bin/aconnect
alsascrdir=3D/etc/alsa.d

function start() {
  #
  # insert all sound modules that are not already loaded
  #
  drivers=3D`/sbin/modprobe -c | \
    grep -E "^[[:space:]]*alias[[:space:]]+snd-card-[[:digit:]]" | \
    awk '{print $3}'`
  loaded=3D""
  for i in $drivers; do
    if [ "$i" !=3D off ]; then
	is_loaded=3D`grep -c ^$i /proc/modules`
	if [ "$is_loaded" =3D=3D "0" ]; then
	    loaded=3D"$loaded $i"
	    if [ $redhat ] ; then
		action "Starting sound driver $i" /sbin/modprobe $i
	    else
		echo -n "Starting sound driver: $i "
		/sbin/modprobe $i
		echo -e "$rc_done"
	    fi
	else
	    if [ $redhat ] ; then
		echo "Sound driver $i is already loaded"
	    fi
	fi
    fi
  done
  #
  # insert sequencer modules that are not already loaded
  #
  if [ x"$START_ALSA_SEQ" =3D xyes -a -r /proc/asound/seq/drivers ]; then
    t=3D`cut -d , -f 1 /proc/asound/seq/drivers`
    if [ "x$t" !=3D "x" ]; then
	loaded=3D`grep -c ^$t /proc/modules`
	if [ "$loaded" =3D=3D "0" ]; then
	    if [ $redhat ] ; then
		action "Starting sequencer driver $t" /sbin/modprobe $t
	    else
		/sbin/modprobe $t
	    fi
        else
	    if [ $redhat ] ; then
		echo "Sequencer driver $t is already loaded"
	    fi
	fi
    fi
  fi
  #
  # restore driver settings
  #
  if [ -d /proc/asound ]; then
    if [ ! -r $asoundcfg ]; then
      echo "No mixer config in $asoundcfg, you have to unmute your card!"
    else
      if [ -x $alsactl ]; then
	if [ $redhat ] ; then
	    action "Restoring sound driver settings" $alsactl -f $asoundcfg restor=
e
	else
	    $alsactl -f $asoundcfg restore
	fi
      else
	if [ $redhat ] ; then
	    echo -n "Sound driver: could not find alsactl"
	    failure "Finding alsactl" && echo
	else
	    echo -e "${rc_warning}ERROR: alsactl not found${rc_reset}"
	fi
      fi
    fi
  fi
  #
  # run card-dependent scripts only for drivers we loaded
  #
  for i in $loaded; do
    t=3D${i##snd-}
    if [ -x $alsascrdir/$t ]; then
	if [ $redhat ] ; then
	    action "Running $t script" $alsascrdir/$t
	else
	    $alsascrdir/$t
	fi
    fi
  done
  #
  # touch lockfile if lockdir exists
  #
  if [ -d /var/lock/subsys ] ; then
    touch /var/lock/subsys/alsasound
  fi
}

function terminate() {
  #
  # Kill processes holding open sound devices
  #
  # DEVS=3D`find /dev/ -follow -type c -maxdepth 1 -print 2>/dev/null | xar=
gs ls -dils | grep "1*1[46]," | cut -d: -f2 | cut -d" " -f2; echo /proc/aso=
und/dev/*`
  ossdevs=3D"/dev/admmidi? /dev/adsp? /dev/amidi? /dev/audio* /dev/dmfm* \
     /dev/dmmidi? /dev/dsp* /dev/dspW* /dev/midi0? /dev/mixer? /dev/music \
     /dev/patmgr? /dev/sequencer* /dev/sndstat"
  alsadevs=3D"/proc/asound/dev/*"
  fuser -k $ossdevs $alsadevs 2> /dev/null 1>/dev/null
  #
  # remove all sequencer connections if any
  #
  if [ -f /proc/asound/seq/clients -a -x $aconnect ]; then
    $aconnect --removeall
  fi
}

function stop() {
  #
  # store driver settings
  # [nando: we always initialize the driver to the default settings]
  #
  # if [ -x $alsactl ]; then
  #   $alsactl -f $asoundcfg store
  # else
  #   echo -n -e "${rc_warning}!!!alsactl not found!!!${rc_reset} "
  # fi
  #
  # remove all sound modules
  #
  /sbin/lsmod | grep -E "^snd" | grep -Ev "^(snd-page-alloc|snd-hammerfall-=
mem)" | while read line; do \
     /sbin/rmmod `echo $line | cut -d ' ' -f 1`; \
  done
  # remove the 2.2 soundcore module (if possible)
  /sbin/rmmod soundcore 2> /dev/null
  /sbin/rmmod gameport 2> /dev/null

  #
  # remove lockfile if lockdir exists
  #
  if [ -d /var/lock/subsys ] ; then
    rm -f /var/lock/subsys/alsasound
  fi
}

# See how we were called.
case "$1" in
  start)
        # Start driver if it isn't already up.
	if [ -d /proc/asound ]; then
	    echo "ALSA driver already running"
	fi
	start
	if [ $redhat ] ; then
	    if [ -d /proc/asound -a -d /var/lock/subsys ]; then
		touch /var/lock/subsys/alsasound
	    fi
	fi
        ;;
  stop)
        # Stop daemons.
	if [ -d /proc/asound ]; then
          echo -n "Shutting down sound driver"
	  terminate
	  stop
	  if [ $redhat ] ; then
	    if [ -d /var/lock/subsys ]; then
		rm -f /var/lock/subsys/alsasound
	    fi
	    success "sound driver stop" && echo
	  else
	    echo -e "$rc_done"
	  fi
	fi
        ;;
  restart|reload)
	$0 stop
	$0 start
	;;
  status)
        if [ -d /proc/asound ]; then
          echo -n "ALSA sound driver loaded."
        else
          echo -n "ALSA sound driver not loaded."
        fi
        echo
        ;;
  *)
        echo "Usage: alsasound {start|stop|restart|status}"
        exit 1
esac

exit 0

--=-t6C/fUfbxxnR8N35TDDA--



-------------------------------------------------------
This SF.net email is sponsored by: Etnus, makers of TotalView, The debugger 
for complex code. Debugging C/C++ programs can leave you feeling lost and 
disoriented. TotalView can help you find your way. Available on major UNIX 
and Linux platforms. Try it free. www.etnus.com
