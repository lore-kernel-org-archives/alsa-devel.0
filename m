From: Peter Heatwole <peter599@gotnet.net>
Subject: Re: SPDIF output finally working properly with CS4630
Date: Wed, 24 Jul 2002 11:19:19 -0700
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20020724181919.GC1681@porky>
References: <3D3DBDA2.10602@cucumelo.org> <20020724013400.GA5214@porky> <3D3E2D08.3070800@cucumelo.org>
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <3D3E2D08.3070800@cucumelo.org>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Benny Sjostrand <gorm@cucumelo.org>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On 2002.07.23 21:28 Benny Sjostrand wrote:
>> [peter@porky als]$ aplay footsteps.wav Playing WAVE 'footsteps.wav' :
>> Signed 16 bit Little Endian, Rate 44100 Hz, Mono
>> aplay: interval_inline.h:65: snd_interval_min: Assertion 
>> `!snd_interval_empty(i)' failed.
>> Aborted...

    This is odd. I was going to play with the driver some more this
morning, and when I tried to play a sound... it played! I didn't change
anything since I last tried it, except that I had my computer turned off
overnight. Perhaps it was the cold boot that effected it. Anyway, now it
plays, but I don't get IEC958 output, and the analog out was very
"tinny". I reloaded the module, and now the sound from analog out is
fine.
    I'll keep playing with it.

-- Peter Heatwole
"Murphy was just a well known pessimist."



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
