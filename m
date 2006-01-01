From: John Rigg <ad@sound-man.co.uk>
Subject: Re: Re: [Jackit-devel] Real-world reports on two Delta 1010LTs/ice1712 synched?
Date: Sun, 1 Jan 2006 19:58:15 +0000
Message-ID: <20060101195815.GA4162@localhost.localdomain>
References: <20051224165610.GA4484@localhost.localdomain> <43AE9FA6.2020207@nostar.net> <20051226130327.GA4763@localhost.localdomain> <43B059A3.2050302@nostar.net> <20051227000428.GA3805@localhost.localdomain> <43B0A83F.1040907@nostar.net> <20051227130029.GB3770@localhost.localdomain> <43B1A8FA.8080408@nostar.net> <20051228211935.GA4782@localhost.localdomain> <43B7D15D.8080802@nostar.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <43B7D15D.8080802@nostar.net>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Doug McLain <doug@nostar.net>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Sun, Jan 01, 2006 at 07:55:57AM -0500, Doug McLain wrote:
> I'm hard at work trying to fix the word clock selection on the delta 
> 1010LT.  Can you do me a favor and send the output of cat 
> /proc/asound/M1010/ice1712 on your machine?  The heart of the difference 
> appears to be in the configuration of the GPIO register.

Here's the output from
cat /proc/asound/M1010/ice1712 and
cat /proc/asound/M1010_1/ice1712

These are with jackd running in multi duplex mode at 96kHz, 32 frames,
2 periods with the first card (irq 17) running on its internal clock
and the second card (irq 18) synced to the word clock input.
The only difference between them is in the RATE registers.

John
__________________________________________________________                           

M Audio Delta 1010 at 0xb000, irq 17

EEPROM:
  Subvendor        : 0x121430d6
  Size             : 29 bytes
  Version          : 1
  Codec            : 0x1f
  ACLink           : 0x80
  I2S ID           : 0x1
  S/PDIF           : 0x3
  GPIO mask        : 0x22
  GPIO state       : 0xd0
  GPIO direction   : 0xdd
  AC'97 main       : 0x0
  AC'97 pcm        : 0x0
  AC'97 record     : 0x0
  AC'97 record src : 0x44
  DAC ID #0        : 0x1
  DAC ID #1        : 0x1
  DAC ID #2        : 0x1
  DAC ID #3        : 0x1
  ADC ID #0        : 0x2
  ADC ID #1        : 0x2
  ADC ID #2        : 0x2
  ADC ID #3        : 0x2
  Extra #28        : 0x0

Registers:
  PSDOUT03         : 0x0000
  CAPTURE          : 0x00000000
  SPDOUT           : 0x0000
  RATE             : 0x07

__________________________________________


M Audio Delta 1010 at 0xc000, irq 18

EEPROM:
  Subvendor        : 0x121430d6
  Size             : 29 bytes
  Version          : 1
  Codec            : 0x1f
  ACLink           : 0x80
  I2S ID           : 0x1
  S/PDIF           : 0x3
  GPIO mask        : 0x22
  GPIO state       : 0xd0
  GPIO direction   : 0xdd
  AC'97 main       : 0x0
  AC'97 pcm        : 0x0
  AC'97 record     : 0x0
  AC'97 record src : 0x44
  DAC ID #0        : 0x1
  DAC ID #1        : 0x1
  DAC ID #2        : 0x1
  DAC ID #3        : 0x1
  ADC ID #0        : 0x2
  ADC ID #1        : 0x2
  ADC ID #2        : 0x2
  ADC ID #3        : 0x2
  Extra #28        : 0x0

Registers:
  PSDOUT03         : 0x0000
  CAPTURE          : 0x00000000
  SPDOUT           : 0x0000
  RATE             : 0x17


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
