From: Martin Langer <martin-langer@gmx.de>
Subject: rules for /proc/asound [was: VIA EPIA (VT1612A) and SPDIF]
Date: Wed, 19 Feb 2003 11:30:16 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20030219103016.GF3246@tuba.home>
References: <3E52CD2B.7090505@lemur.sytes.net>
Reply-To: martin-langer@gmx.de
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <3E52CD2B.7090505@lemur.sytes.net>
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

On Tue, Feb 18, 2003 at 07:17:47PM -0500, Mathias Kretschmer wrote:
> 
> [root@musicbox root]# cat /proc/asound/card0/ac97#0
> 0-0/0: VIA Technologies VIA1612A
> 
> Capabilities     : -headphone out-
> DAC resolution   : 18-bit
> ADC resolution   : 18-bit
> 3D enhancement   : Reserved 27
> 
> Current setup
> Mic gain         : +0dB [+0dB]
> POP path         : pre 3D
> Sim. stereo      : off
> 3D enhancement   : off
> Loudness         : off
> Mono output      : MIX
> Mic select       : Mic1
> ADC/DAC loopback : off
> Extended ID      : codec=0 rev=0 AMAP DSA=0 SPDIF VRA
> Extended status  : SPDIF=3/4 SPDIF VRA
> PCM front DAC    : 44100Hz
> PCM ADC          : 48000Hz
> SPDIF Control    : Consumer PCM Copyright Category=0x2 Generation=1 
> Rate=48kHz
> 


Are there any rules for /proc/asound/cardX/XXX status files? Has it to be
readable by an external script? I think using standard control names can be 
one point. Are there other things I have to think about? Or is it still an
area without rules?


martin



-------------------------------------------------------
This SF.net email is sponsored by: SlickEdit Inc. Develop an edge.
The most comprehensive and flexible code editor you can use.
Code faster. C/C++, C#, Java, HTML, XML, many more. FREE 30-Day Trial.
www.slickedit.com/sourceforge
