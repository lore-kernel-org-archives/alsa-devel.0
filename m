From: Maarten de Boer <mdeboer@iua.upf.es>
Subject: RTC timer questions, reposting
Date: Mon, 8 Apr 2002 09:59:54 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <a8rirb$rvo$2@main.gmane.org>
References: <20020404113042.02c1189a.mdeboer@iua.upf.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
In-Reply-To: <20020404113042.02c1189a.mdeboer@iua.upf.es>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: alsa-devel@alsa-project.org, alsa-user@alsa-project.org
Cc: tiwai@suse.de, perex@suse.cz
List-Id: alsa-devel@alsa-project.org

Hello,

Sorry for being such a pain, but I really want this to work, and I
really think this is something that has general interest: using a
higher accurate midi event timing. So: HOW DO I USE THE RTC TIMER?
I can find no up-to-date documentation about this.

The latest I find is a mail by Takashi, that is a year old, which says:

Installation:
Add the following lines in /etc/modules.conf:
options snd-timer snd_timer_limit=2
alias snd-timer-1 snd-rtctimer
For using RTC timer in sequencer as default:
options snd-seq snd_seq_default_timer=1

This is not working anymore, because parameters changed.

Starting sound driver: snd-emu10k1 done
/lib/modules/2.4.18/kernel/sound/acore/seq/snd-seq.o: invalid parameter parm_snd_seq_default_timer
/lib/modules/2.4.18/kernel/sound/acore/seq/snd-seq.o: insmod /lib/modules/2.4.18/kernel/sound/acore/seq/snd-seq.o failed
/lib/modules/2.4.18/kernel/sound/acore/seq/snd-seq.o: invalid parameter parm_snd_seq_default_timer
/lib/modules/2.4.18/kernel/sound/acore/seq/snd-seq.o: insmod /lib/modules/2.4.18/kernel/sound/acore/seq/snd-seq.o failed
/lib/modules/2.4.18/kernel/sound/acore/seq/snd-seq.o: insmod snd-seq-midi failed

So, please tell me how it works. If I can get it to work, I would not mind 
writing some documentation about it, but please help me out!

Also, is there any way (apart from 'listening') to know whether the rtctimer
is used by the sequencer or not?

BTW, I noticed that the alsa rtctimer is not compiled when you have
the RTC in your kernel as a module. The problem is in 
alsa-kernel/core/Makefile, where CONFIG_RTC is tested for y and not for m. 

Maarten
