From: James Courtier-Dutton <James@superbug.co.uk>
Subject: [PATCH] Implement basic support for Creative emu1212m
	and emu1820m.
Date: Fri, 25 Aug 2006 19:18:08 +0100
Message-ID: <44EF3EE0.6000005@superbug.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

http://alsa-project.org/~james/alsa-driver/emu1212m/emu1212m-10.diff

This patch added some basic ALSA support for the Creative emu1212m and
emu1820m

Please review.

What works:
Sound capture and playback to the Audio Dock works.
All sound is captured and played back via the FX bus so works well in jackd.
Currently fixed to 48Khz, S32_LE format, 8 channels.
Requires:
The latest alsa-firmware package to be installed. (One firmware file for
the FPGA on the EMU1010 PCI card, one firmware file for the FPGA on the
Audio Dock.)

TODO:
Implement mixer controls to select different sources for capture.
Implement switching between different rates. Currently done with
#ifdef's in the source code. (Not a trivial task)
Implement support for hot plug of audio dock. (requires a kernel tasklet
polling the device)
Implement some Ardour type interface to load DSP effects and control DSP
routing.

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
