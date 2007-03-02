From: "Michael K. Edwards" <medwards.linux@gmail.com>
Subject: Re: Bridging captured stream to playback stream
Date: Fri, 2 Mar 2007 13:28:20 -0800
Message-ID: <f2b55d220703021328t69ef6fb1s7db2d44bb8f3b02f@mail.gmail.com>
References: <9c1cad6e0703020822g88eae6bq4a2943db42101b2@mail.gmail.com>
	<75b66ecd0703020844v1bba0dbax4dbf6a4273e792aa@mail.gmail.com>
	<f2b55d220703021259h2b96dc2em822047902e836cd@mail.gmail.com>
	<9c1cad6e0703021312n2fe8b370ibb2aec1c607e8971@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <9c1cad6e0703021312n2fe8b370ibb2aec1c607e8971@mail.gmail.com>
Content-Disposition: inline
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Maen Suleiman <maen.suleiman@gmail.com>
Cc: Lee Revell <rlrevell@joe-job.com>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Posted to alsa-devel under the subject "OSS emulation, period size,
and start/stop thresholds", followed shortly thereafter by an actual
low-latency ALSA driver.  Audio-in to audio-out loopback delay
somewhere in the 18 ms range with no underrun/overrun.  The actual
application is retrofitted to the OSS emulation device for hysterical
reasons, but that is also working smoothly now.  Don't try the OSS
emulation approach on a non-NPTL platform, though; you pretty much
have to open /dev/dsp read-write, ioctl it into shape, and service RX
and TX from different threads.

Cheers,
- Michael

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
