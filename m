From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: Problems reading the hardware config of the card.
Date: Sat, 12 Oct 2002 12:37:56 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.33.0210121237230.1975-100000@pnote.perex-int.cz>
References: <3DA7EB53.6020400@superbug.demon.co.uk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <3DA7EB53.6020400@superbug.demon.co.uk>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchives/forum.php?forum=alsa-devel>
To: James Courtier-Dutton <James@superbug.demon.co.uk>
Cc: "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Sat, 12 Oct 2002, James Courtier-Dutton wrote:

> 
> During setup of the sound card, I adjust the HW params and then save 
> them to the card during the open() stage.
> 
> Is there any alsa api call that can retrieve hw settings later. For 
> example something like: -
> snd_pcm_get_buffersize()
> snd_pcm_get_periodsize()
> 
> Another problem is that snd_pcm_can_pause()/snd_pcm_can_resume() can 
> only be enquired about at device opening time, while one has the 
> hw_params that one used to configure the card. I would like to be able 
> to enquire about snd_pcm_can_pause() at the moment the user presses 
> pause in the GUI, but at the moment, I have to remember the setting at 
> snd_pcm_open() and setup time.
> It would make for a neater application if one could quiry the hw_params 
> at any time after them being opened, thus saving the application from 
> having to keep a duplicate of all the settings.
> 
> This can all be done perfectly easily with sw_params, just not hw_params.
> 
> Maybe I have just missed something, but I don't think I have.

Ok, snd_pcm_hw_params_current() function is ready for your usage in CVS.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project  http://www.alsa-project.org
SuSE Linux    http://www.suse.com



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
