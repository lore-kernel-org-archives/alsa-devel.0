From: Peter Heatwole <peter599@gotnet.net>
Subject: Re: SPDIF output finally working properly with CS4630
Date: Tue, 23 Jul 2002 23:29:27 -0700
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20020724062927.GC6131@porky>
References: <3D3DBDA2.10602@cucumelo.org> <20020724013400.GA5214@porky> <3D3E2D08.3070800@cucumelo.org>
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <3D3E2D08.3070800@cucumelo.org>; from gorm@cucumelo.org on Tue, Jul 23, 2002 at 21:28:56 -0700
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

On 2002.07.23 21:28 Benny Sjostrand wrote:
> Now I've generated a patch against alsa-driver-0.9.0rc2, so you can try 
> to merge it with your CVS snapshot,
> maybe it works better ....

    Thanks. It took a tad of modifying to patch the CVS because it was
expecting a 0.9.0rc2 postfix on everything, but that was simple to fix.
    I patched the CVS, and am getting the same error. I stuck the following
into alsa-lib/src/pcm/interval_inline.h, and am getting some feedback on
what's going wrong:

printf("snd_interval_min()::: i->empty == %d\n", i->empty)

<<<which results in>>>

[peter@porky als]$ aplay footsteps.wav Playing WAVE 'footsteps.wav' : 
Signed 16 bit Little Endian, Rate 44100 Hz, Mono
snd_interval_min():::  i->empty == 0
snd_interval_min():::  i->empty == 0
snd_interval_min():::  i->empty == 0
snd_interval_min():::  i->emtpy == 0
snd_interval_min():::  i->empty == 1
aplay: interval_inline.h:66: snd_interval_min: Assertion 
`!snd_interval_empty(i)' failed.
Aborted...


    Also, I tried the driver with the xmms-alsa plugin, and it
failed the same test, but in the function snd_interval_refine_min().
    I haven't developed with ALSA yet, so I don't know the ropes
completely. Anyone have any idea what's happening here? I checked
the online docs and couldn't find any references regarding
"interval"s. Is this a timing issue?


-- Peter Heatwole
"Murphy was just a well known pessimist."



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
