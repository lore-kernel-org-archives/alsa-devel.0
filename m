From: Kristof Pelckmans <Kristof.Pelckmans@antwerpen.be>
Subject: Support for Midiman M-Audio Delta 410
Date: Wed, 30 Oct 2002 09:14:56 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1035965696.3dbf95009ce97@albert.homedns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Resent-To: alsa-devel@lists.sourceforge.net
Resent-Message-ID: <1036054965.3dc0f1b567097@albert.homedns.org>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
Cc: perex@suse.sz, tiwae@suse.de, ajh@watri.uwa.edu.au
List-Id: alsa-devel@alsa-project.org

Hi all,

I bought a M-Audio Delta 410 card last weekend. When I tried loading the snd-
ice1712 module and unmuting all channels, I got a scrambled sound. (I did not 
try the envy24control since I have no X)

The last few days, I did some research and I found out in the sourcecode that 
the card is not fully supported.

Based on my pictures (see 
http://home.planetinternet.be/~kpelckma/delta410/delta410.html) I deduct that 
the Delta 410 has following chips :
- 1x AK4529VQ (A/D and D/A conversion) NOT SUPPORTED ?
- 1x CS8427 (tranceiver, I/O for AK4529 & S/PDIF), SUPPORTED also appears in 
Delta 1010LT and Delta Audiophile cards
- 1x ENVY24, SUPPORTED by ice1712
- 1x L7805CV (voltage regulator)
- 6x 5532 2036B JRC (operational amplifier, buffering & filtering)

In my opinion the real missing piece of code is the driver for the AK4529. Has 
any development been done to support this chipset ? For more technical 
information, see http://www.asahi-kasei.co.jp/akm/en/product/ak4529/ak4529.html.

If not, I am willing to write the code myself based on the work done by Anders 
Johansson for the Delta 1010LT. However I am not the best C-programmer, so 
therefore my cry for help and documentation ! Are there a doxygen generated 
docs for the kernel API ?

I am going to study the source code tomorrow and I'm hoping to write my first 
lines of code.

Best regards,

Kristof Pelckmans

My system:
Athlon 900 Mhz
Abit KT-7 RAID/ 256 MB RAM
Linux 2.4.18
ALSA 0.9.0rc5
cat /proc/asound/card0/ice1712 :

ICE1712 

EEPROM: 
  Subvendor        : 0x121438d6 
  Size             : 29 bytes 
  Version          : 1 
  Codec            : 0x13 
  ACLink           : 0x80 
  I2S ID           : 0x72 
  S/PDIF           : 0x3 
  GPIO mask        : 0x4 
  GPIO state       : 0xfe 
  GPIO direction   : 0xfb 
  AC'97 main       : 0x0 
  AC'97 pcm        : 0x0 
  AC'97 record     : 0x0 
  AC'97 record src : 0x44 
  DAC ID #0        : 0x5 
  DAC ID #1        : 0x5 
  DAC ID #2        : 0x5 
  DAC ID #3        : 0x5 
  ADC ID #0        : 0x5 
  ADC ID #1        : 0x0 
  ADC ID #2        : 0x0 
  ADC ID #3        : 0x0 
  Extra #28        : 0x0



-------------------------------------------------------
This sf.net email is sponsored by: Influence the future 
of Java(TM) technology. Join the Java Community 
Process(SM) (JCP(SM)) program now. 
http://ads.sourceforge.net/cgi-bin/redirect.pl?sunm0004en
