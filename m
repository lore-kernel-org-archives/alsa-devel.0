From: detlef.grittner@t-online.de (Detlef Grittner)
Subject: via82xx: problem with distorted sound
Date: Sun, 18 Jan 2004 20:57:44 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <400AE538.4050306@t-online.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
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

I have problems with the via82xx sound module, which puts out distorted 
sound.
I'm using the via82xx that comes with kernel 2.6.1 and I'm using the 
module that came with my distribution's kernel 2.4.24.
The problem exists with the module from kernel 2.4.24, but things got 
worse with kernel 2.6.1.

When I'm playing a sound with xmms, after a while there is a jittering 
noise. It goes away if you press pause and play again in xmms.
The noise always occurs at the same position in the song, if you start 
play back at the beginning of the sound and don't interrupt it.

I have already experimented with the source of the via82xx module, but 
regardless what I do: The problems is always *exactly* the same.
Changing the dxs parameters or the ac97 clock doesn't help either.
During my experiments I managed to get rid off the "invalid 
via82xx_cur_ptr, using last valid pointer", but this seems not to be the 
real problem. This was the only error message I had in the log file.

Even more astonishing is: If you use kernel 2.6.1 and minimize and 
maximize a window in X11, the sound simply stops until the window is 
minimized or maximized. I have absolutely no idea how these actions can 
be connected.

Here some stats about my soundcard and other hardware:
AMD 64 x86_64 (using the 64 bit architecture)

from lspci:
00:11.5 Multimedia audio controller: VIA Technologies, Inc. 
VT8233/A/8235 AC97 Audio Controller (rev 60)

cat /proc/asound/cards
0 [rev60          ]: VIA8233 - VIA 823x rev60
                     VIA 823x rev60 at 0xb800, irq 3


Any ideas what I should do?

Detlef








-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
