From: Albrecht <ag-linux@4usgass.net>
Subject: problem with via8235 sound
Date: Sun,  7 Dec 2003 06:25:21 +0000
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1070778321.3fd2c7d19c40f@www.4usgass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
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

Hey, 
I have the strangest problem with my via p4pb400 motherboard that uses the 
via8235 southbridge. 
I cannot get the sound to work properly under linux but it works just fine 
under windows xp :(. My "sound system" is attached via an optical link to the 
motherboard. 
I have tried Mandrake 9.2 and Suse 9.0 and both times the same problem. I have 
compiled alsa 0.9.8 and still no sound.   
Then I found something strange that when I try to test my sound in the Suse 
Yast tool, it plays if I click the button to test the volume several times. 
But still no other application can make any sound. So I know that it's not a 
physical problem but rather some strange configuration issue.  
The I ran scanpci -v and found something strange. There are to cards that use 
the same interrupt line and interrupt pin!  
 
pci bus 0x0000 cardnum 0x10 function 0x02: vendor 0x1106 device 0x3038 
 VIA Technologies, Inc. USB 
  STATUS    0x0210  COMMAND 0x0007 
  CLASS     0x0c 0x03 0x00  REVISION 0x80 
  BIST      0x00  HEADER 0x80  LATENCY 0x20  CACHE 0x08 
  BASE4     0x0000e001  addr 0x0000e000  I/O 
  MAX_LAT   0x00  MIN_GNT 0x00  INT_PIN 0x03  INT_LINE 0x0b 
  BYTE_0    0x40  BYTE_1  0x12  BYTE_2  0x03  BYTE_3  0x00 
 
pci bus 0x0000 cardnum 0x11 function 0x05: vendor 0x1106 device 0x3059 
 VIA Technologies, Inc. VT8233/A/8235 AC97 Audio Controller 
 CardVendor 0x1106 card 0xb003 (VIA Technologies, Inc., Card unknown) 
  STATUS    0x0210  COMMAND 0x0001 
  CLASS     0x04 0x01 0x00  REVISION 0x50 
  BIST      0x00  HEADER 0x00  LATENCY 0x00  CACHE 0x00 
  BASE0     0x0000e801  addr 0x0000e800  I/O 
  MAX_LAT   0x00  MIN_GNT 0x00  INT_PIN 0x03  INT_LINE 0x0b 
  BYTE_0    0x01  BYTE_1  0xcc  BYTE_2  0x00  BYTE_3  0x00 
 
I cannot find a way to change the IRQ for the sound card. 
 
Any help would greatly be appreciated. 
 
Albrecht 


-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?  SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
