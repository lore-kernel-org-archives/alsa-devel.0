From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: Problems with snd_pcm_hw_params_can_pause (). etc.
Date: Sat, 12 Oct 2002 15:37:30 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.33.0210121533280.1975-100000@pnote.perex-int.cz>
References: <3DA82060.9090409@superbug.demon.co.uk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <3DA82060.9090409@superbug.demon.co.uk>
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

> Currently, the state of play is that "snd_pcm_hw_params_can_pause ()" 
> should not be called until one has first done the first 
> "snd_pcm_hw_params()"
> 
> I start with
> snd_pcm_hw_params_any(this->audio_fd, params);
> then go about setting params, e.g.
> snd_pcm_hw_params_set_access()
> snd_pcm_hw_params_set_format()
> etc.
> Then
> snd_pcm_hw_params()
> then
> snd_pcm_hw_params_can_pause (params)
> 
> If the "snd_pcm_hw_params_can_pause (params)" goes before the 
> "snd_pcm_hw_params()" an invalid result is returned. I.E. the result is 
> always 1 even for cards which don't support it.
> 
> I think the documentation should make it clear when one should use 
> "snd_pcm_hw_params_can_pause ()".
> or maybe "snd_pcm_hw_params_any()" should be modified to correctly fill 
> the "can_pause" bit.
> Maybe I have missunderstood the API, but I would prefer the approach of 
> first retrieving the current hw params, then go about modifying it, then 
> writting it back. If one has not set any hw params yet, it would fill 

But what's "current configuration"? What you want to prefer? rate? 
channels? period_size? No, application should give these hints to driver.

> the structure with the most general case, then allow the application to 
> set params to further restrict the config.
> I had assumed that "snd_pcm_hw_params_any()" did the retrieving of the 
> current hw params, but reset to the least restrictive settings. I don't 
> think "can_pause" is anything an application can set, the hardware on 
> the card decides that, so the "snd_pcm_hw_params_any()" should cause 
> "can_pause" to return a valid setting that matches the hardware, instead 
> of having to wait for the params to be written to the card with 
> "snd_pcm_hw_params()" before "can_pause" is set accurately.

All these functions needs exactly one configuration at input.
The snd_pcm_hw_params() function chooses one configuration and sets it to 
hardware. I've updated documentation.

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
