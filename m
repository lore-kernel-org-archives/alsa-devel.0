From: jhall@UU.NET (Jeremy Hall)
Subject: pcm_multi can cause a kernel lockup
Date: Mon, 15 Apr 2002 06:53:30 -0400 (EDT)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <QQmkrj01622.200204151053@neserve0.corp.us.uu.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi,

I am running 2.4.19-pre2+ll+preempt and seeing some annoying crashes when
using pcm_multi.

the setup:

running jack with something like this:

ctl.rme9652_48 {
	type hw
	card 0
	}

pcm.rme9652_48 {
	type multi
	slaves.a.pcm rme9652_0;
	slaves.a.channels 26;
	slaves.b.pcm rme9652_1
	slaves.b.channels 26
bindings.0.slave a;
	bindings.0.channel 0;
	...
	bindings.27.slave b;
	bindings.27.channel 25;
	}

ctl.rme9652_0 {
	type hw;
	card 0;
}

ctl.rme9652_1 {
	type hw
	card 1
	}

pcm.rme9652_0 {
	type hw
	}
pcm.rme9652_1 {
	type hw
	card 1
}

Whatever jack period size doesn't seem to matter, the problem seems to be
when for some reason the kernel makes jack wait on the order of
miliseconds, like say 9 or more.  Jack's response to this is to stop and
restart the audio device.  When this happens using a multi device, the
computer locks and pressing reset is necessary--it won't respond to pings
even.

It is a dual 1.6ghz Athlon machine and the only audio hardware in it are
the two hammerfalls.  I am running CVS of recent, looks like Apr 12 at
around 00:08 GMT was when I checked it out.  Any help would be
appreciated.  card0 is the master, providing word clock to card1.  

The ADAT ports have valid sync, but the SPDIF ports do not, for they are
not connected to anything.

_J
