From: Fernando Pablo Lopez-Lezcano <nando@ccrma.Stanford.EDU>
Subject: midi problems with Quattro usb interface
Date: 21 Mar 2003 18:15:52 -0800
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1048299352.3921.57.camel@cmn37.Stanford.EDU>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
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

Hi gurus, I'm seeing this weird problem in current cvs (same problem
when tested with cvs of 20030307):

Connections:
  Oxygen8 Midi output -> Quattro Midi input
  Quattro USB -> laptop USB port

- start computer (with everything connected)
  a) usb system is loaded..., Quattro recognized, snd-usb-audio started
  b) alsasound loads the rest of the modules
  --> midi input does not work (tested with pd)

This is the only way I have found to make it work (after MANY tries):
- stop alsa driver (/etc/rc.d/init.d/alsasound stop)
- disconnect Quattro from the usb port
- disconnect Oxygen8 from the Quattro <- this is what makes a difference
- connect Quattro to the usb port (wait till it is recognized)
- start alsa driver

--> midi input works!

Apparently having active sensing midi bytes coming in to the Quattro
while the driver is being loaded kills input. I was not able to make
things work if the keyboard is connected to the interface when alsa
starts. 

A MidiSport2x2 works fine under the same conditions (using the open
source firmware). It is not affected by the same Oxygen8 keyboard being
plugged in when the driver starts. 

-- Fernando




-------------------------------------------------------
This SF.net email is sponsored by:Crypto Challenge is now open! 
Get cracking and register here for some mind boggling fun and 
the chance of winning an Apple iPod:
http://ads.sourceforge.net/cgi-bin/redirect.pl?thaw0031en
