From: Matt Flax <flatmax@ieee.org>
Subject: usb Duo no device ? using midisport-firmware
Date: Thu, 24 Jul 2003 17:01:00 +1000
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20030724070100.GA647@mffm.ee.unsw.edu.au>
Reply-To: Matt Flax <flatmax@pgb.unsw.edu.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from smtp3.unsw.edu.au (smtp3.unsw.EDU.AU [149.171.96.70])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id HAA11239
	for <alsa-devel@alsa-project.org>; Thu, 24 Jul 2003 07:58:25 +0200
Received: from smtp.unsw.edu.au (antivirus-01.services.comms.unsw.EDU.AU [149.171.193.80])
	by smtp3.unsw.edu.au (8.11.2/8.11.2) with ESMTP id h6O5wEX11277
	for <alsa-devel@alsa-project.org>; Thu, 24 Jul 2003 15:58:14 +1000 (EST)
Received: from maillationax ([149.171.36.140])
	by smtp.unsw.edu.au (8.11.2/8.11.2) with ESMTP id h6O5wDk11219
	for <alsa-devel@alsa-project.org>; Thu, 24 Jul 2003 15:58:14 +1000 (EST)
Received: from flatmax by maillationax with local (Exim 3.36 #1 (Debian))
	id 19fa61-0000BV-00
	for <alsa-devel@alsa-project.org>; Thu, 24 Jul 2003 17:01:01 +1000
Content-Disposition: inline
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: core sound <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hello,

I am having trouble with the usb driver for the M-Audio Duo usb 
external sound card. I use kernel 2.4.21-2-686 on a Debian system. 
alsa-driver-0.9.5

In order to do this I used Clemens Ladisch's  midisport-firmware driver 
:
http://www.informatik.uni-halle.de/~ladischc/midisport_linux_firmware.html

I get the following message in /var/log/syslog :
localhost kernel: ALSA usbaudio.c:686: cannot submit datapipe for urb 0, 
err = -22

I disconnect and reconnect the device and get the following 
/var/log/messages:

Jul 24 13:51:58 localhost kernel: usb.c: USB disconnect on device 
00:03.0-1 address 3
Jul 24 13:52:05 localhost kernel: hub.c: new USB device 00:03.0-1, 
assigned address 4
Jul 24 13:52:09 localhost kernel: usb_control/bulk_msg: timeout
Jul 24 13:52:09 localhost last message repeated 5 times
Jul 24 13:52:10 localhost usb.agent: ... no modules for USB product 
763/2002/101

dmesg prints out the following :
usb.c: USB disconnect on device 00:03.0-1 address 3
hub.c: new USB device 00:03.0-1, assigned address 4
usb_control/bulk_msg: timeout
usb_control/bulk_msg: timeout
usbdevfs: USBDEVFS_CONTROL failed dev 4 rqt 128 rq 6 len 809 ret -110
usbdevfs: USBDEVFS_CONTROL failed dev 4 rqt 128 rq 6 len 809 ret -12
usb_control/bulk_msg: timeout
usbdevfs: USBDEVFS_CONTROL failed dev 4 rqt 128 rq 6 len 9 ret -110
usbdevfs: USBDEVFS_CONTROL failed dev 4 rqt 128 rq 6 len 18 ret -110
usb_control/bulk_msg: timeout
usb_control/bulk_msg: timeout
usbdevfs: USBDEVFS_CONTROL failed dev 4 rqt 128 rq 6 len 18 ret -110
usbdevfs: USBDEVFS_CONTROL failed dev 4 rqt 128 rq 6 len 18 ret -110
usb_control/bulk_msg: timeout
usbdevfs: USBDEVFS_CONTROL failed dev 4 rqt 128 rq 6 len 809 ret -110
ALSA usbaudio.c:686: cannot submit datapipe for urb 0, err = -22
ALSA usbaudio.c:686: cannot submit datapipe for urb 0, err = -22

The last two lines are from trying aply with a wav file.

/etc/hotplug/usb/midisport_fw reads like so :
#!/bin/sh

# load the firmware into Midiman MidiSport devices

FIRMWARE=
FIRMWAREDIR=/usr/share/usb
FLAGS=
LOADER=/sbin/fxload
LOADERFIRMWARE=$FIRMWAREDIR/MidiSportLoader.ihx

case $PRODUCT in
763/1001/*)
        FIRMWARE=$FIRMWAREDIR/MidiSport2x2.ihx
        ;;
763/1010/*)
        FIRMWARE=$FIRMWAREDIR/MidiSport1x1.ihx
        ;;
763/1014/*)
        FIRMWARE=$FIRMWAREDIR/MidiSportKS.ihx
        ;;
763/1020/*)
        FIRMWARE=$FIRMWAREDIR/MidiSport4x4.ihx
        ;;
763/1031/110)
        FIRMWARE=$FIRMWAREDIR/MidiSport8x8-2.10.ihx
        ;;
763/1031/121)
        FIRMWARE=$FIRMWAREDIR/MidiSport8x8-2.21.ihx
        ;;
*)
        if [ -x /usr/bin/logger ]; then
                /usr/bin/logger -t $0 "unknown product $PRODUCT"
        fi
        exit 1
esac

# missing loader firmware?
if [ ! -r $LOADERFIRMWARE ]; then
        if [ -x /usr/bin/logger ]; then
                /usr/bin/logger -t $0 "missing $LOADERFIRMWARE ??"
        fi
        exit 1
fi

# missing firmware?
if [ ! -r $FIRMWARE ]; then
        if [ -x /usr/bin/logger ]; then
                /usr/bin/logger -t $0 "missing $FIRMWARE for $PRODUCT 
??"
        fi
        exit 1
fi

# missing loader?
if [ ! -x $LOADER ]; then
        if [ -x /usr/bin/logger ]; then
                /usr/bin/logger -t $0 "missing $LOADER ??"
        fi
        exit 1
fi

if [ -x /usr/bin/logger ]; then
        /usr/bin/logger -t $0 "load $FIRMWARE for $PRODUCT to $DEVICE"
fi
$LOADER $FLAGS -s $LOADERFIRMWARE -I $FIRMWARE

flatmax# ls /usr/share/usb/
MidiSport1x1.ihx       MidiSport8x8-2.10.ihx  MidiSportLoader.ihx
MidiSport2x2.ihx       MidiSport8x8-2.21.ihx  a3load.hex
MidiSport4x4.ihx       MidiSportKS.ihx    

Help requested !

thanks
Matt
-- 
http://mffm.ee.unsw.edu.au

WSOLA TimeScale Audio Mod  : http://mffmtimescale.sourceforge.net/
FFTw C++                   : http://mffmfftwrapper.sourceforge.net/
Vector Bass                : http://mffmvectorbass.sourceforge.net/
Multimedia Time Code       : http://mffmtimecode.sourceforge.net/


-------------------------------------------------------
This SF.Net email sponsored by: Free pre-built ASP.NET sites including
Data Reports, E-commerce, Portals, and Forums are available now.
Download today and enter to win an XBOX or Visual Studio .NET.
http://aspnet.click-url.com/go/psa00100003ave/direct;at.aspnet_072303_01/01
