From: Marco Canini <m.canini@libero.it>
Subject: Problem with multiplexing
Date: 16 May 2003 00:36:38 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1053038198.473.5.camel@jabawack.canini.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
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

Please gimme an answer!

I've a CS4624 sound card, i compiled the kernel 2.5.68 with ALSA all
built-in (no modules), i choosed to compile the following:

Sequencer support
OSS API emulation
OSS Mixer API
OSS PCM (digital audio) API
RTC Timer support

PCI devices -> Cirrus Logic (Sound Fusion) CS4280/CS461x/CS462x/CS463x

I don't use devfs, so i created the needed devices trough the proper
script, and i can actually get sound from native alsa apps and oss apps.

What i can't get to work is the multiplexing: i mean whan more than one
app open /dev/dsp and i can listen more than one audio stream at the
same time.

I tried today on another machine with a sb live and without alsa, well
there it works!

I thought that alsa do some sort of software multiplexing if the
hardware multiplexing is unavailable.

Anyway do you have some ideas of what's going on here?

-- 
Marco Canini <m.canini@libero.it>



-------------------------------------------------------
Enterprise Linux Forum Conference & Expo, June 4-6, 2003, Santa Clara
The only event dedicated to issues related to Linux enterprise solutions
www.enterpriselinuxforum.com
