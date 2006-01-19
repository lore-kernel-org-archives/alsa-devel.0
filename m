From: Fernando Lopez-Lezcano <nando@ccrma.Stanford.EDU>
Subject: presario x1000, 1.0.11rc2, no sound
Date: Thu, 19 Jan 2006 13:50:34 -0800
Message-ID: <1137707434.4841.19.camel@cmn3.stanford.edu>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>
Cc: nando@ccrma.Stanford.EDU
List-Id: alsa-devel@alsa-project.org

Hi, I'm looking for some advice. A student of mine can't get sound from
her laptop, apparently she was able to hear sound from an install of FC3
(don't know the particular versions of the kernel or alsa involved) and
now with a FC4 install and up to the latest drivers I could find
(1.0.11rc2) sound just does not happen. 

I have twiddled with all possible settings, everything seems happy but
there's no sound (on headphones or speakers). 

I'm including some info about the hardware...
Advice appreciated...
-- Fernando

cat /proc/asound/cards
 0 [I82801DBICH4   ]: ICH4 - Intel 82801DB-ICH4
                      Intel 82801DB-ICH4 with AD1981B at 0xa0200000, irq
10

cat /proc/asound/devices
  0: [ 0]   : control
  1:        : sequencer
 16: [ 0- 0]: digital audio playback
 20: [ 0- 4]: digital audio playback
 24: [ 0- 0]: digital audio capture
 25: [ 0- 1]: digital audio capture
 26: [ 0- 2]: digital audio capture
 27: [ 0- 3]: digital audio capture
 33:        : timer

the ac97 info from /proc/asound/...

0-0/0: Analog Devices AD1981B

PCI Subsys Vendor: 0x0e11
PCI Subsys Device: 0x0860

Capabilities     : -headphone out-
DAC resolution   : 20-bit
ADC resolution   : 16-bit
3D enhancement   : No 3D Stereo Enhancement

Current setup
Mic gain         : +20dB [+20dB]
POP path         : pre 3D
Sim. stereo      : off
3D enhancement   : off
Loudness         : off
Mono output      : MIX
Mic select       : Mic1
ADC/DAC loopback : off
Extended ID      : codec=0 rev=1 AMAP DSA=0 SPDIF VRA
Extended status  : SPCV SPDIF=3/4 VRA
PCM front DAC    : 48000Hz
PCM ADC          : 48000Hz
SPDIF Control    : Consumer PCM Category=0x2 Generation=1 Rate=48kHz



AD18XX configuration
Unchained        : 0x1000,0x0000,0x0000
Chained          : 0x0000,0x0000,0x0000

and the registers:
0:00 = 0090
0:02 = 0808
0:04 = 0000
0:06 = 0000
0:08 = 0000
0:0a = 0000
0:0c = 0000
0:0e = 8040
0:10 = 8080
0:12 = 9f9f
0:14 = 0000
0:16 = 9f9f
0:18 = 0000
0:1a = 0000
0:1c = 8f8f
0:1e = 0000
0:20 = 0000
0:22 = 0000
0:24 = 0000
0:26 = 000f
0:28 = 0605
0:2a = 0401
0:2c = bb80
0:2e = 0000
0:30 = 0000
0:32 = bb80
0:34 = 0000
0:36 = 0000
0:38 = 0000
0:3a = 2824
0:3c = 0000
0:3e = 0000
0:40 = 0000
0:42 = 0000
0:44 = 0000
0:46 = 0000
0:48 = 0000
0:4a = 0000
0:4c = 0000
0:4e = 0000
0:50 = 0000
0:52 = 0000
0:54 = 0000
0:56 = 0000
0:58 = 0000
0:5a = 0000
0:5c = 4000
0:5e = 0000
0:60 = 8080
0:62 = 0000
0:64 = 8000
0:66 = 0000
0:68 = 0000
0:6a = 0000
0:6c = 0000
0:6e = 0000
0:70 = 0000
0:72 = 0004
0:74 = 1001
0:76 = 2010
0:78 = 0000
0:7a = 0000
0:7c = 4144
0:7e = 5374




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
