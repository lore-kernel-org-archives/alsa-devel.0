From: Benny Sjostrand <gorm@cucumelo.org>
Subject: Re: SPDIF output finally working properly with CS4630
Date: Wed, 24 Jul 2002 06:28:56 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3D3E2D08.3070800@cucumelo.org>
References: <3D3DBDA2.10602@cucumelo.org> <20020724013400.GA5214@porky>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
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
To: Peter Heatwole <peter599@gotnet.net>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

> [peter@porky als]$ aplay footsteps.wav Playing WAVE 'footsteps.wav' : 
> Signed 16 bit Little Endian, Rate 44100 Hz, Mono
> aplay: interval_inline.h:65: snd_interval_min: Assertion 
> `!snd_interval_empty(i)' failed.
> Aborted... 


oops!

I guess that maybe you need to alsa-lib-0.9.0rc2, everything *0.9.0rc2, 
thats what's i got installed.

Now I've generated a patch against alsa-driver-0.9.0rc2, so you can try 
to merge it with your CVS snapshot,
maybe it works better ....

http://www.cucumelo.org/~gorm/alsa-driver-0.9.0rc2-bs20020723.diff.gz

/Benny



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
