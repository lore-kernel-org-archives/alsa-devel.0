From: <jfm3@ouroboros-complex.org>
Subject: bug in intel8x0 joystick/midi ?
Date: Sat, 7 Jun 2003 10:21:36 -0700 (PDT)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <33175.24.225.156.130.1055006496.squirrel@webmail.ouroboros-complex.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
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

I have intel8x0 on my mother board. There are headers for a joystick/midi
port I'd like to use. I look in BIOS and find joystick io=201, midi
io=330, and midi irq=10. I put this in modules.conf:

options -k snd-intel8x0 index=0 mpu_port=330 joystick_port=201

snd-mpu401-uart gets loaded, but no midi ports appear. I notice in the
source code to the driver three things.

1) There is no support for joystick_port=201, only 200?

2) There is no way to tell the driver what irq is the mpu401.

3) The setup routine doesn't seem to look for joystick and midi. I don't
see the word "joystick" or "midi" in dmesg.

I'm using the bleeding edge apt index from Planet CCRMA. ALSA 0.9.4. dmesg
is pretty boring, but I'll send it along if you want.

(jfm3)





-------------------------------------------------------
This SF.net email is sponsored by:  Etnus, makers of TotalView, The best
thread debugger on the planet. Designed with thread debugging features
you've never dreamed of, try TotalView 6 free at www.etnus.com.
