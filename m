From: Bob Tracy <rct@gherkin.frus.com>
Subject: static /dev configuration
Date: Mon, 19 Mar 2012 00:38:21 -0500
Message-ID: <20120319053820.GA14603@gherkin.frus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from gherkin.frus.com (gherkin.frus.com [192.158.254.49])
	by alsa0.perex.cz (Postfix) with ESMTP id 6B79D103AC1
	for <alsa-devel@alsa-project.org>; Mon, 19 Mar 2012 06:38:25 +0100 (CET)
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Does ALSA now require dynamic devices (udev) for certain soundcards
(specifically, cards handled by the snd-hda-intel driver)?

My problem is that I moved a Slackware installation to new hardware, and
the old devices under /dev/snd I originally created back in 2003 don't
seem to work correctly with snd-hda-intel.  "lspci" shows my new system
having two audio devices as follows:

00:1b.0 Audio device: Intel Corporation Cougar Point High Definition Audio Controller (rev 04)
01:00.1 Audio device: ATI Technologies Inc Device aa60

(The ATI entry corresponds to a DisplayPort output on a Radeon graphics
card that isn't presently of interest to me: REDWOOD firmware.)

I had an opportunity to boot a modern Linux distro with udev support
that accesses the Intel audio device just fine, so I took note of the
device entries under /dev/snd and replicated those on the Slackware
setup as follows (ignore the "root" group and 666 permissions rather
than the more correct "audio" group and 660 permissions):

crw-rw-rw- 1 root root 116,  9 Mar 18 00:24 controlC0
crw-rw-rw- 1 root root 116, 12 Mar 18 00:26 controlC1
crw-rw-rw- 1 root root 116,  8 Mar 18 00:27 hwC0D2
crw-rw-rw- 1 root root 116,  7 Jun 18  2003 hwC0D3
crw-rw-rw- 1 root root 116, 11 Mar 18 00:30 hwC1D0
crw-rw-rw- 1 root root 116,  6 Mar 18 00:34 pcmC0D0c
crw-rw-rw- 1 root root 116,  5 Mar 18 20:44 pcmC0D0p
crw-rw-rw- 1 root root 116,  4 Mar 18 00:36 pcmC0D1p
crw-rw-rw- 1 root root 116,  3 Mar 18 00:39 pcmC0D2c
crw-rw-rw- 1 root root 116,  2 Mar 18 00:44 pcmC0D3p
crw-rw-rw- 1 root root 116, 10 Mar 18 00:42 pcmC1D3p
crw-rw-rw- 1 root root 116,  1 Jun 18  2003 seq
crw-rw-rw- 1 root root 116, 33 Jun 18  2003 timer

Not all that surprisingly, the above entries work: "alsamixer" and
"aplay" do what I expect and seem to work correctly.

Note that the minor device numbers are NOT the same as what the
"snddevices" script in "alsa-driver-1.0.25" creates (and that script
creates pretty much exactly what I had in my static /dev tree back in
2003).  According to "snddevices", the "controlCn" devices should have
minor numbers 0, 32, 64, etc.  The "hwC0Dn" minors are 4, 5, etc.,
"hwC1Dn" minors are 36, 37, etc., "hwC2Dn" minors are 68, 69, etc.
Note that "hwC0D3" is at minor 7 where it should be under the old minor
device numbering scheme, but "hwC0D2" is at minor 8 where 6 was
expected.  The various "pcm*" devices were expected to be as follows:

crw-rw-rw- 1 root root 116,  24 Jun 18  2003 pcmC0D0c
crw-rw-rw- 1 root root 116,  16 Mar  3 20:50 pcmC0D0p
crw-rw-rw- 1 root root 116,  25 Jun 18  2003 pcmC0D1c
crw-rw-rw- 1 root root 116,  17 Jun 18  2003 pcmC0D1p
crw-rw-rw- 1 root root 116,  26 Jun 18  2003 pcmC0D2c
crw-rw-rw- 1 root root 116,  18 Jun 18  2003 pcmC0D2p
crw-rw-rw- 1 root root 116,  27 Jun 18  2003 pcmC0D3c
crw-rw-rw- 1 root root 116,  19 Jun 18  2003 pcmC0D3p
crw-rw-rw- 1 root root 116,  56 Jun 18  2003 pcmC1D0c
crw-rw-rw- 1 root root 116,  48 Jun 18  2003 pcmC1D0p
crw-rw-rw- 1 root root 116,  57 Jun 18  2003 pcmC1D1c
crw-rw-rw- 1 root root 116,  49 Jun 18  2003 pcmC1D1p
crw-rw-rw- 1 root root 116,  58 Jun 18  2003 pcmC1D2c
crw-rw-rw- 1 root root 116,  50 Jun 18  2003 pcmC1D2p
crw-rw-rw- 1 root root 116,  59 Jun 18  2003 pcmC1D3c
crw-rw-rw- 1 root root 116,  51 Jun 18  2003 pcmC1D3p

I'm thinking the only reason I'm getting away with using any kind of
static device scheme is that my sound devices are getting detected and
initialized in a consistent order each time I boot, and the /dev/snd
entries I copied from the udev-enabled system just happen to agree with
what "udev" would consistently create if I had "udev" installed.

So, just to restate the original question for clarity, is "udev"
required for certain soundcards?

Thanks!
--Bob
