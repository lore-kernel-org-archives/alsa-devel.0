From: AthlonRob <athlonrob@data.4t3.com>
Subject: Multiple Sound Streams out of a single card
Date: 13 Sep 2003 20:44:09 -0700
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1063511049.30701.164.camel@localhost>
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
To: alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Hey list-

I'm wondering exactly how things work, playing multiple streams of audio
out of a single card/chip.

In Windows, I'm able to have WinAmp running in the background and still
hear event sounds from other applications.

In Linux, only one thing can play at a time, without the use of
high-latency audio servers.

Why is this?  I understand some alsa drivers support playing multiple
streams.. dependent upon driver support and a certain property of
hardware (which I have been told doesn't exist on the nForce, although
I've read elsewhere it does... and doesn't exist on any i8x0 based
chips).

I only question this because about six months ago I was told, flat out,
that the hardware didn't support playing multiple audio streams at
once.  On one machine, I have an i8x0 chip, and on another an nForce
chip (which uses the i8x0 driver).  Both play multiple audio streams at
once in Windows, but neither seem capable with either OSS or ALSA
drivers.

Is this a fundamental difference between Windows and ALSA driver
architectures, something the Alsa or OSS people haven't gotten around to
yet, a big mystery, or what?  Maybe Windows runs some fairly low-latency
sound server type setup?

Inquiring minds want to know.  :-)

Rob



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
