From: Michael Huijsmans <mgh@telering.at>
Subject: Hercules Digifire [cs46xx] gameport troubles
Date: Tue, 24 Feb 2004 10:50:32 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040224105032.0f1a1ea0.mike@marune.alastor>
Reply-To: mgh@telering.at
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi, 
the soundcard gameport doesn't entirely work with my analog joystick
(Logitech Wingman Light, 3 axes, 2 buttons) on the gameport of the
 Hercules Digifire 7.1; the two buttons do work, however, no axis movement
is registered. 

The gameport is initialized on alsa startup, the relevant modules are loaded:
joydev, gameport, analog, input. 

dmesg says:
input0: Analog 4-axis 4-button joystick at gameport0.0 [ADC port]

jstest does this:
$ jstest /dev/js0
Joystick (Analog 4-axis 4-button joystick) has 4 axes and 4 buttons. Driver version is 2.1.0.
Testing ... (interrupt to exit)
Axes:  0:     0  1:     0  2:-32753  3:-31409 Buttons:  0:off  1:off  2:off  3:off 
...
(Buttons 0 and 1 are registered when pressed, the axis values don't change when moving 
the stick.)

and dmesg:
analog.c: 0 out of 4718 reads (0%) on gameport0 failed

changing the analog.o kernel module js= parameter doesn't change things,
the same behaviour occurs with alsa disabled and the kernel joystick module cs461x 
loaded (i.e. only the buttons are registered)

Any ideas what's going on?
Thanks,
Mike



-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
