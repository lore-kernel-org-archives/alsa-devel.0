From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: [Alsa-user] RTC timer questions, reposting
Date: Mon, 8 Apr 2002 11:26:39 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <a8rnuq$21a$2@main.gmane.org>
References: <20020408102940.74be295c.mdeboer@iua.upf.es>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
In-Reply-To: <20020408102940.74be295c.mdeboer@iua.upf.es>
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

> On Mon, 8 Apr 2002 10:15:49 +0200 (CEST)
> Jaroslav Kysela <perex@suse.cz> wrote:
> 
> > The defines are in asound.h file - look for 'Timer section - /dev/snd/timer'.
> > 
> > Usage (using defaults):
> > 
> > 	options snd-seq snd_seq_default_timer_device=1
> > 
> > or (full specification):
> > 
> > 	options snd-seq snd_seq_default_timer_class=1 \
> > 			snd_seq_default_timer_sclass=0 \
> > 			snd_seq_default_timer_card=-1 \
> > 			snd_seq_default_timer_device=1 \
> > 			snd_seq_default_timer_subdevice=0
> > 
> > 						Jaroslav
> 
> Okay, thanks.
> 
> Now I have in my modules.conf
> 
> options snd-timer snd_timer_limit=2
> alias snd-timer-1 snd-rtctimer
> options snd-seq snd_seq_default_timer_resolution=1000 snd_seq_default_timer_device=1
> 
> But when I run
> $ /etc/init.d/alsasound start
> the snd-rtctimer module is not inserted... Why is that?

This module will be requested after a sequencer application allocates
a sequencer queue. Thus, you should run your application.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project  http://www.alsa-project.org
SuSE Linux    http://www.suse.com
