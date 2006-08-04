From: Eric Peters <epeters@graphics.cs.uni-sb.de>
Subject: Re: How to stop a device immediately??
Date: Fri, 04 Aug 2006 16:18:08 +0200
Message-ID: <44D35720.8020107@graphics.cs.uni-sb.de>
References: <44D342E3.908@graphics.cs.uni-sb.de>
	<Pine.LNX.4.61.0608041457460.9118@tm8103-a.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.61.0608041457460.9118@tm8103-a.perex-int.cz>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Thanks Jaroslav for your fast reply,

Jaroslav Kysela wrote:
> On Fri, 4 Aug 2006, Eric Peters wrote:
> 
> 
>>Dear all,
>>
>>I have a PCM device which is playing some PCM samples. The soundbuffer
>>is pretty full. And now I want to pause the buffer immediately (as
>>fast as possible) and sometime later I want to resume at exactly this
>>sample I paused.
>>
>>Now I found the two functions snd_pcm_pause and snd_pcm_resume. But
>>unfortunately these functions aren't supported by all hardware.
> 
> 
> Right.
> 
> 
>>Or do you have an idea how to implement such a feature? I also found
>>the two functions snd_pcm_drain and snd_pcm_drop. But when I use this
>>functions the sound buffer will be empty if I resume. And with
>>snd_pcm_drain there will be a delay between I pause the playback and
>>there are no more samples out of my spaekers.
> 
> 
> If hw pause/resume is supported - check snd_pcm_hw_params_can_pause(), 
> then you may use it, otherwise you should implement the pause in this way:
> 
> on pause:
> 
> 1) remember the current position in playback buffer (using snd_pcm_delay())
> 2) use snd_pcm_drop() to stop the stream immediately
> 
> on resume:
> 
> 3) fill ring buffer from the position saved in 1)
> 4) restart playback
> 
> In other words, if hardware does not support pause, application must 
> "emulate" this behaviour.

Yes, you're right. But I'm not sure if I understand your suggestion.

In 1) I will remember the current position of the playback buffer.

If I use snd_pcm_drop in 2) I will lose all frames I already put into
the playback buffer, or not?

If so, for 3) I have to know which samples I dropped so I can rewrite
them to the playback buffer, right? Or aren't the frames which I
already have written into the sound buffer lost if I call
snd_pcm_drop?? If so, I can write new frames to the position I
remembered in 1).

Best regards,
Eric

> 
> 						Jaroslav
> 
> -----
> Jaroslav Kysela <perex@suse.cz>
> Linux Kernel Sound Maintainer
> ALSA Project, SUSE Labs

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
