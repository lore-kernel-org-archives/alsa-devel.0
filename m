From: Sander van Grieken <sander@3v8.net>
Subject: audiophile usb and snd-usb-audio report
Date: Wed, 19 Oct 2005 16:43:20 +0200
Message-ID: <200510191643.20866.sander@3v8.net>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_IulVDiL4vBy5lXR"
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
To: alsa-devel@lists.sourceforge.net, clemens@ladisch.de
List-Id: alsa-devel@alsa-project.org

--Boundary-00=_IulVDiL4vBy5lXR
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi,

I've had some minor success with _analog_ recording from an audiophile USB 
Attached is a simple report of various combinations when capturing using the 
alsa-driver-1.0.10rc2 drivers.

SUMMARY:

- only 48001-96000hz capturing works
- only capturing through plughw:x,1 works
- format is 24/32 bits regardless of plug conversion (? at least, as reported 
by audacity)
- only the signal on the jack inputs is captured
- only 2-channel capture
- only the SYNC/48001-96000/S24_3BE altset on device #1 can be captured, only 
through plughw.


--Boundary-00=_IulVDiL4vBy5lXR
Content-Type: text/plain;
  charset="us-ascii";
  name="audiophile-alsa.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="audiophile-alsa.txt"

SUMMARY:

- only 48001-96000hz capturing works
- only capturing through plughw:x,1 works
- format is 24/32 bits regardless of plug conversion (? at least, as reported by audacity)
- only the signal on the jack inputs is captured
- only 2-channel capture
- only the SYNC/48001-96000/S24_3BE altset on device #1 can be captured, only through plughw.


signal (from the jacks, not the cinch connectors)
-------------------------------------------------

s1) arecord -D plughw:0,1 -t wav -c 2 -r 96000 -f S16_LE -d 2 -vv test.wav 
- output :
Plug PCM: Linear conversion PCM (S24_3BE)
Its setup is:
stream       : CAPTURE
access       : RW_INTERLEAVED
format       : S16_LE
- audacity reports 24b/96khz
- amplitude suspects 24 bit sound despite S16_LE setting
- altset reportedly used :
    Format: S24_3BE
    Channels: 2
    Endpoint: 5 IN (SYNC)
    Rates: 48001 - 96000 (continuous)
- see (n1) and (e3)

s2) arecord -D plughw:0,1 -t wav -c 2 -r 96000 -f S32_LE -d 2 -vv test.wav
- output :
Plug PCM: Linear conversion PCM (S24_3BE)
Its setup is:
stream       : CAPTURE
access       : RW_INTERLEAVED
format       : S32_LE
- audacity reports 32b/96khz
- altset used same as (s1)


no signal
---------

n1) arecord -D plughw:0,1 -t raw -c 2 -r 96000 -f S24_3BE -d 2 -vv test.raw
- output :
Plug PCM: Hardware PCM card 0 'Audiophile USB (tm)' device 1 subdevice 0

Its setup is:
stream       : CAPTURE
access       : RW_INTERLEAVED
format       : S24_3BE

n2) arecord -D plughw:0,1 -t raw -c 2 -r 96000 -f S24_LE -d 2 -vv test.raw
n3) arecord -D plughw:0,1 -t raw -c 2 -r 96000 -f S24_3LE -d 2 -vv test.raw
n4) arecord -D plughw:0,1 -t raw -c 2 -r 96000 -f U24_3LE -d 2 -vv test.raw
n5) arecord -D plughw:0,1 -t raw -c 2 -r 96000 -f U24_3BE -d 2 -vv test.raw

errors/'lock'
-------------

e1) arecord -D plughw:0,1 -t raw -c 2 -r 48000 -f S16_LE -d 2 -vv test.raw
- output :
Plug PCM: Linear conversion PCM (S16_BE)
Its setup is:
stream       : CAPTURE
access       : RW_INTERLEAVED
format       : S16_LE

e2) arecord -D plughw:0,1 -t raw -c 2 -r 48000 -f S16_BE -d 2 -vv test.raw
- output :
Plug PCM: Hardware PCM card 0 'Audiophile USB (tm)' device 1 subdevice 0

Its setup is:
stream       : CAPTURE
access       : RW_INTERLEAVED
format       : S16_BE

e3) arecord -D plughw:0,0 -t wav -c 2 -r 96000 -f S16_LE -d 2 -vv test.wav
e3) arecord -D plughw:0,1 -t wav -c 1 -r 96000 -f S16_LE -d 2 -vv test.wav

--Boundary-00=_IulVDiL4vBy5lXR--


-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
