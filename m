From: Adam K Kirchhoff <adamk@voicenet.com>
Subject: Re: ymfpci : four speakers with OSS-emulation
Date: Tue, 13 Mar 2001 17:57:14 -0500 (EST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.10.10103131755050.2351-100000@sorrow.ashke.com>
References: <s5h6640k0ea.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Received: from sorrow.ashke.com (pcp110788pcs.wchryh01.nj.comcast.net [68.45.84.166])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id XAA15179
	for <alsa-devel@alsa-project.org>; Wed, 13 Mar 2002 23:59:25 +0100
In-Reply-To: <s5h6640k0ea.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: xavier.allamigeon@free.fr, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


On Wed, 13 Mar 2002, Takashi Iwai wrote:

> if you only need duplication, this can be done on alsa-lib without
> changing the driver itself.
> try to add the following in your ~/.asoundrc.
> 
> 	pcm.ch4dup {
> 		type plug
> 		slave.pcm surround40
> 		ttable.0.0 1
> 		ttable.1.1 1
> 		ttable.0.2 1
> 		ttable.1.3 1
> 	}
> 
> then run like this
> 
> 	% aplay -D ch4dup foo.wav

Well, even this doesn't seem to want to work for me at the moment :-(  I'm
still only getting audio from the front speakers.

[ adamk@sorrow ~ ]$ cat .asoundrc 
pcm.ch4dup {
        type plug
        slave.pcm surround40
        ttable.0.0 1
        ttable.1.1 1
        ttable.0.2 1
        ttable.1.3 1
}

[ adamk@sorrow ~ ]$ aplay -D ch4dup saved/sounds/Thunder.wav 
Playing WAVE 'saved/sounds/Thunder.wav' : Signed 16 bit Little Endian, Rate 22050 Hz, Stereo

Any further ideas?

Adam


_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel
