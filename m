From: Maarten de Boer <mdeboer@iua.upf.es>
Subject: RTC timer questions
Date: Thu, 4 Apr 2002 11:30:42 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20020404113042.02c1189a.mdeboer@iua.upf.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received: from iuamtg.upf.es (iuamtg.upf.es [193.145.55.151])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id LAA11916
	for <alsa-devel@alsa-project.org>; Thu, 4 Apr 2002 11:31:41 +0200
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: alsa-devel@alsa-project.org
Cc: tiwai@suse.de
List-Id: alsa-devel@alsa-project.org

Hello,

I sent the following to the list, but did not get any answer, so I
repost, and will elaborate a bit on it.

> Hello, I noticed that the alsa rtctimer is not compiled when you have
> the RTC in your kernel as a module. The problem is in
> alsa-kernel/core/Makefile, where CONFIG_RTC is tested for y
> and not for m. 

> Where can I find up-to-date documentation about how to use the rtc timer?

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

Also, is there any way (apart from 'listining') to know whether the rtctimer
is used by the sequencer or not?

Maarten
