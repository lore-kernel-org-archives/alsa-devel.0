From: Giuliano Pochini <pochini@shiny.it>
Subject: Re: trigger commands
Date: Mon, 24 Mar 2003 11:48:50 +0100 (CET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <XFMail.20030324114850.pochini@shiny.it>
References: <s5hwuipozr8.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hwuipozr8.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org


>> What are PUSH, RELEASE, SUSPEND, RESUME trigger commands supposed to do
>> ?
>
> * pcm stream pausing
> imagine the pause-button is pushed and released.
> these commands are issued only when SNDRV_PCM_INFO_PAUSE is set to
> info field of snd_pcm_hardware_t.
>
> - PAUSE_PUSH
>       pause the stream
> - PAUSE_RELEASE
>       restart the paused stream

Ok, PAUSE_PUSH-->stop() and TRIGGER_STOP-->stop()-and-reset dma
pointer. In my case RELEASE and START are the same thing.


> * power-management
> called when the power-management status is changed.
> these commands are issued only when SNDRV_PCM_INFO_RESUME is set to
> info field of snd_pcm_hardware_t (and of course pm is supported).
>
> - SUSPEND
>       suspend the streams; usually identical with STOP command
> - RESUME
>       resume the streams; usually identical with START command

Way down on the TODO list :)


Tnx.



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
