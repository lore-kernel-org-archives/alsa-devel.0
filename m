From: Maarten de Boer <mdeboer@iua.upf.es>
Subject: Re: [Alsa-user] RTC timer questions, reposting
Date: Mon, 8 Apr 2002 10:29:40 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <a8rki7$u41$2@main.gmane.org>
References: <20020408095954.318f5fc3.mdeboer@iua.upf.es>
	<Pine.LNX.4.33.0204081011180.1079-100000@pnote.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
In-Reply-To: <Pine.LNX.4.33.0204081011180.1079-100000@pnote.perex-int.cz>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Jaroslav Kysela <perex@suse.cz>
Cc: alsa-devel@alsa-project.org, alsa-user@alsa-project.org, tiwai@suse.de
List-Id: alsa-devel@alsa-project.org

On Mon, 8 Apr 2002 10:15:49 +0200 (CEST)
Jaroslav Kysela <perex@suse.cz> wrote:

> The defines are in asound.h file - look for 'Timer section - /dev/snd/timer'.
> 
> Usage (using defaults):
> 
> 	options snd-seq snd_seq_default_timer_device=1
> 
> or (full specification):
> 
> 	options snd-seq snd_seq_default_timer_class=1 \
> 			snd_seq_default_timer_sclass=0 \
> 			snd_seq_default_timer_card=-1 \
> 			snd_seq_default_timer_device=1 \
> 			snd_seq_default_timer_subdevice=0
> 
> 						Jaroslav

Okay, thanks.

Now I have in my modules.conf

options snd-timer snd_timer_limit=2
alias snd-timer-1 snd-rtctimer
options snd-seq snd_seq_default_timer_resolution=1000 snd_seq_default_timer_device=1

But when I run
$ /etc/init.d/alsasound start
the snd-rtctimer module is not inserted... Why is that?

Maarten
