From: Ludwig Schwardt <schwardt@sun.ac.za>
Subject: Again with the Delta 1010LT...
Date: Thu, 26 Feb 2004 00:01:26 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <403D1B36.1010908@sun.ac.za>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
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
Cc: tuimonen@cc.hut.fi
List-Id: alsa-devel@alsa-project.org

Hi,

I'm struggling to sync two Delta 1010LT cards. I've tried both the word 
clock and SPDIF approaches, without any success. Both the SPDIF Out and 
Word Clock Out connectors show no activity when inspected by an 
oscilloscope.

Questions:

- Is the word clock output something you must switch on in the ALSA 
driver or is it supposed to start automatically when you have a valid 
clock signal on the card?

- Do I have to do something special to get SPDIF output (I'm new to 
this)? I've fiddled with iecset from alsa-utils, and otherwise I 
connected the SPDIF Out to various inputs using the patchbay of 
envy24control. Still, no signal appears on the connector.

If it helps, here is /proc/asound/card0/ice1712:

M Audio Delta 1010LT at 0xc000, irq 9

EEPROM:
   Subvendor        : 0x12143bd6
   Size             : 29 bytes
   Version          : 1
   Codec            : 0x1f
   ACLink           : 0x80
   I2S ID           : 0x72
   S/PDIF           : 0x3
   GPIO mask        : 0x4
   GPIO state       : 0x7e
   GPIO direction   : 0xfb
   AC'97 main       : 0x0
   AC'97 pcm        : 0x0
   AC'97 record     : 0x0
   AC'97 record src : 0x44
   DAC ID #0        : 0x3
   DAC ID #1        : 0x3
   DAC ID #2        : 0x3
   DAC ID #3        : 0x3
   ADC ID #0        : 0x3
   ADC ID #1        : 0x3
   ADC ID #2        : 0x3
   ADC ID #3        : 0x3
   Extra #28        : 0x0

Registers:
   PSDOUT03         : 0x8080
   CAPTURE          : 0x55000000
   SPDOUT           : 0x0005
   RATE             : 0x08

(What do these numbers mean?)

Thanks in advance,
Ludwig



-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
