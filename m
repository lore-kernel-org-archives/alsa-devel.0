From: Peter L Jones <peter@drealm.org.uk>
Subject: [2.5.40bk3] Am I missing something?
Date: Fri, 4 Oct 2002 23:23:47 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200210042323.48179@advent.drealm.org.uk>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 8bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchives/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi all,

I'm running 2.5.40 bitkeeper snapshot #3.  Having finally got as far as 
building ALSA (ens1371), I can't get any output.

The driver loads:
Advanced Linux Sound Architecture Driver Version 0.9.0rc3 (Tue Oct 01 14:40:23 
2002 UTC).
Compiled on Oct  4 2002 for kernel 2.5.40bk3.
  0: [0- 0]: ctl
  8: [0- 0]: raw midi
 17: [0- 1]: digital audio playback
 16: [0- 0]: digital audio playback
 24: [0- 0]: digital audio capture
 33:       : timer

When /etc/init.d/alsa runs, I get no nasty looking messages anywhere - ens1371 
loads, alsactl restore runs.  But alsamixer shows all levels zeroed.  And 
KMix doesn't find any mixers.  Upping the settings in alsamixer doesn't make 
the soundcard work :-(.

What should I be looking at..?

(Oh, and is Documentation/sound/alsa going to get some useful content before 
2.6 comes out..? :-) )

Btw, the soundcard works fine under 2.4.19 with alsa-driver-0.9.0rc3, so I'm 
definitely pointing the finger at rc3 that's just been added into 2.5, 
Jaroslav :-)).  Seriously, what can I do to help get it working?

Regards,

-- Peter



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
