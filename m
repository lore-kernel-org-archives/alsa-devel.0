From: "Pavana Sharma" <pavans@india.ti.com>
Subject: problem while opening device
Date: Tue, 6 Apr 2004 16:44:56 +0530
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <028301c41bc8$650f30c0$f8b6a8c0@ent.ti.com>
Reply-To: <pavans@india.ti.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi,

	I am running a test application on my alsa driver for arm platform.Driver
is statically built.
	The test application calls the snd_pcm_open.
	With device hw:0,0

	At the target I have created sound driver files with snddevices.sh
	In /proc/asound i have the soundcard registered as card0 .
	Can anyone give ideas where can be the problem ..??

	this is the error msg I am getting..
----------------snip-----------
ALSA lib pcm.c:1947:(snd_pcm_open_noupdate) Unknown PCM hw:0,0
--------------------------------
	FYI ..when I use

	 cat test.raw > /dev/dsp

	 is working.

	Thanks
	Pavana S



-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
