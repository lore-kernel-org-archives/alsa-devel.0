From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: [Alsa-user] RTC timer questions, reposting
Date: Mon, 8 Apr 2002 10:15:49 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <a8rjqt$t6k$2@main.gmane.org>
References: <20020408095954.318f5fc3.mdeboer@iua.upf.es>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
In-Reply-To: <20020408095954.318f5fc3.mdeboer@iua.upf.es>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Maarten de Boer <mdeboer@iua.upf.es>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "alsa-user@alsa-project.org" <alsa-user@alsa-project.org>, "tiwai@suse.de" <tiwai@suse.de>
List-Id: alsa-devel@alsa-project.org

On Mon, 8 Apr 2002, Maarten de Boer wrote:

> Hello,
> 
> Sorry for being such a pain, but I really want this to work, and I
> really think this is something that has general interest: using a
> higher accurate midi event timing. So: HOW DO I USE THE RTC TIMER?
> I can find no up-to-date documentation about this.
> 
> The latest I find is a mail by Takashi, that is a year old, which says:
> 
> Installation:
> Add the following lines in /etc/modules.conf:
> options snd-timer snd_timer_limit=2
> alias snd-timer-1 snd-rtctimer
> For using RTC timer in sequencer as default:
> options snd-seq snd_seq_default_timer=1
> 
> This is not working anymore, because parameters changed.
> 
> Starting sound driver: snd-emu10k1 done
> /lib/modules/2.4.18/kernel/sound/acore/seq/snd-seq.o: invalid parameter parm_snd_seq_default_timer
> /lib/modules/2.4.18/kernel/sound/acore/seq/snd-seq.o: insmod /lib/modules/2.4.18/kernel/sound/acore/seq/snd-seq.o failed
> /lib/modules/2.4.18/kernel/sound/acore/seq/snd-seq.o: invalid parameter parm_snd_seq_default_timer
> /lib/modules/2.4.18/kernel/sound/acore/seq/snd-seq.o: insmod /lib/modules/2.4.18/kernel/sound/acore/seq/snd-seq.o failed
> /lib/modules/2.4.18/kernel/sound/acore/seq/snd-seq.o: insmod snd-seq-midi failed
> 
> So, please tell me how it works. If I can get it to work, I would not mind 
> writing some documentation about it, but please help me out!

The defines are in asound.h file - look for 'Timer section - /dev/snd/timer'.

Usage (using defaults):

	options snd-seq snd_seq_default_timer_device=1

or (full specification):

	options snd-seq snd_seq_default_timer_class=1 \
			snd_seq_default_timer_sclass=0 \
			snd_seq_default_timer_card=-1 \
			snd_seq_default_timer_device=1 \
			snd_seq_default_timer_subdevice=0

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project  http://www.alsa-project.org
SuSE Linux    http://www.suse.com
