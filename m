From: Juan Linietsky <coding@reduz.com.ar>
Subject: ENS1371 joystick problem, bug in driver?
Date: Sat, 11 Oct 2003 13:16:19 -0300
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200310111315.21656.coding@reduz.com.ar>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
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

I cant seem to get the joystick port to run under this card (Ensoniq 1371)
under alsa 0.9.rc6.

jstest on /dev/js0 (and others) returns no such device.

However it seems to work fine on the OSS/Free driver 'es1371.o' with parameter 
'joystick=1'

Relevant sections to /etc/asound.state:

state.AudioPCI {
        control.1 {
                comment.access 'read write'
                comment.type BOOLEAN
                iface CARD
                name 'Joystick Enable'
                value true
        }
        control.2 {
                comment.access 'read write'
                comment.type ENUMERATED
                comment.item.0 'port 0x200'
                comment.item.1 'port 0x208'
                comment.item.2 'port 0x210'
                iface CARD
                name 'Joystick Address'
                value 'port 0x200'
        }

I tried using all the values above, but nothing works, and higher values are 
ignored (error is reported).

However, when using the OSS/Free driver, by doing cat /proc/ioports shows the 
follownig

0218-021f : es1371

I can however, as mentioned above, not set such value on /etc/asound.state.

Regards

Juan Linietsky.






-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
SourceForge.net hosts over 70,000 Open Source Projects.
See the people who have HELPED US provide better services:
Click here: http://sourceforge.net/supporters.php
