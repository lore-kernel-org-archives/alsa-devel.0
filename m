From: tomasz motylewski <T.Motylewski@bfad.de>
Subject: Re: Linux driver for cs4281 with TWO cs4299 codecs?
Date: Wed, 22 May 2002 23:15:36 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.21.0205222228000.12692-100000@mailserver.intern.bfad.de>
References: <s5hd6vof3x0.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hd6vof3x0.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: twoller@crystal.cirrus.com, pcaudio@crystal.cirrus.com, alsa-devel@lists.sourceforge.net, peter wachtendorf <pew@bfad.de>, arip@bfad.de
List-Id: alsa-devel@alsa-project.org


single codec, snd_dual_codec=0
ALSA ../alsa-kernel/pci/cs4281.c:1557: never read ISV3 and ISV4 from AC'97
CS4281 soundcard not found or device busy

modprobe AGAIN:

loads OK. 

The same behaviour with not patched alsa-driver-0.9.0rc1 driver! Probably
timeout too short. When I have increased the timeout 0.5 s the driver loaded OK
on the first try (well, not always. I have to investigate it in more detail).


Another test with Takashi patch:

single codec installed, snd_dual_codec=1
ALSA ../../alsa-kernel/pci/ac97/ac97_codec.c:1458: AC'97 1:0 does not respond -
RESET [REC_GAIN = 0xffff]
CS4281 soundcard not found or device busy

- this suggests autodetection should be possible.


I have looked more on the hardware and found out that the clock signal on
XTL_IN was too weak when the plate with additional codec was added. This signal
is not connected to the secondary codec, but the length of the wire was enough
to make it too weak.

After I fixed the problem the driver patched by Takashi actually loaded with
snd_dual_codec=1 !

I have seen:
cat /proc/asound/card0/ac97#0
0-1/0: Cirrus Logic CS4299 rev 4

Capabilities     : -headphone out-
DAC resolution   : 20-bit
ADC resolution   : 18-bit
3D enhancement   : Crystal Semi 3D Stereo Enhancement

Current setup
Mic gain         : +0dB [+0dB]
POP path         : pre 3D
Sim. stereo      : off
3D enhancement   : off
Loudness         : off
Mono output      : MIX
Mic select       : Mic1
ADC/DAC loopback : off
Extended ID      : codec=3 rev=0 AMAP DSA=0 VRA
Extended status  : VRA
PCM front DAC    : 48000Hz
PCM ADC          : 48000Hz

When I loaded the same driver with snd_dual_codec=0 I have got:

cat /proc/asound/card0/ac97#0
0-0/0: Cirrus Logic CS4299 rev 4

Capabilities     : -headphone out-
DAC resolution   : 20-bit
ADC resolution   : 18-bit
3D enhancement   : Crystal Semi 3D Stereo Enhancement

Current setup
Mic gain         : +0dB [+0dB]
POP path         : pre 3D
Sim. stereo      : off
3D enhancement   : off
Loudness         : off
Mono output      : MIX
Mic select       : Mic1
ADC/DAC loopback : off
Extended ID      : codec=0 rev=0 AMAP DSA=0 VRA
Extended status  : VRA
PCM front DAC    : 48000Hz
PCM ADC          : 48000Hz

But why there was always only a single codec listed in /proc/asound/card0/ ?

Best regards,
--
Tomasz Motylewski


_______________________________________________________________

Don't miss the 2002 Sprint PCS Application Developer's Conference
August 25-28 in Las Vegas -- http://devcon.sprintpcs.com/adp/index.cfm
