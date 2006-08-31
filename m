From: Andreas Hartmann <andihartmann@freenet.de>
Subject: Re: [Realtek ALC260] Can't enable SPDIF out
Date: Thu, 31 Aug 2006 20:04:10 +0200
Message-ID: <44F7249A.8030803@p54A1C662.dip0.t-ipconnect.de>
References: <44F5B0D8.8090402@p54A1A81E.dip0.t-ipconnect.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <44F5B0D8.8090402@p54A1A81E.dip0.t-ipconnect.de>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hello,

I've got some additional information. Meanwhile, I compiled the alsa
sources with debug option, which gives this output in /etc/messages:

kernel: ALSA hda_intel.c:665: codec_mask = 0x3
kernel: ALSA patch_realtek.c:4278: hda_codec: Unknown model for ALC260,
trying auto-probe from BIOS...
kernel: ALSA hda_codec.c:2154: autoconfig: line_outs=1 (0xf/0x0/0x0/0x0/0x0)
kernel: ALSA hda_codec.c:2158:    speaker_outs=0 (0x0/0x0/0x0/0x0/0x0)
kernel: ALSA hda_codec.c:2160:    hp=0x0, dig_out=0x18, din_in=0x0
kernel: ALSA hda_codec.c:2168:    inputs: mic=0x12, fmic=0x0, line=0x0,
fline=0x0, cd=0x16, aux=0x0

I tested the different modes, which can be found in the documentation for
ALC260 - none works, because none of them knows anything about S/PDIF.

Besides of S/PDIF and the balance-knob, the driver works (Microphone not
tested, because I don't have one).


What can I do to get the S/DIF-out to work, which is the provided with the
same jack as the headphone? If you could provide me with some hints, how
to change the sources for testing, I would do it for you - no problem!



Kind regards,
Andreas Hartmann

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
