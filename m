From: James Courtier-Dutton <James@superbug.demon.co.uk>
Subject: USB disconnect/connect messages
Date: Mon, 21 Jul 2003 00:40:32 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3F1B2870.3070505@superbug.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
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

Hi,

Is there any way to tell if a USB sound card has been disconnected or not?

I would like my application to play sound to a usb sound card, and if 
the usb cable is unplugged, the application pauses, and if the usb cable 
is plugged in again, the application continues.

Example: -
Some in car stereo systems have usb ports.
I could plug a PC into the usb port, and play sound from the PC to the 
car speaker system. If the driver switches off the car stereo (e.g. 
Receives a mobile phone call) I want the PC to pause playback, but when 
the car stereo switches on again, I want the PC to continue playback.
The car stereo switching off looks to the PC as though the usb cable has 
been unplugged.

Cheers
James



-------------------------------------------------------
This SF.net email is sponsored by: VM Ware
With VMware you can run multiple operating systems on a single machine.
WITHOUT REBOOTING! Mix Linux / Windows / Novell virtual machines at the
same time. Free trial click here: http://www.vmware.com/wl/offer/345/0
