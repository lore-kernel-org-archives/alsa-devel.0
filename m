From: Maarten de Boer <mdeboer@iua.upf.es>
Subject: using the rtctimer
Date: Tue, 2 Apr 2002 17:23:02 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <a8cmt8$t18$2@main.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: alsa-devel@alsa-project.org, alsa-user@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hello,

I am trying to use the RTC timer with alsa 0.9 (cvs), but I don't find
any up to date  documentation. First of all, I noticed that snd-rtctimer
is not even compiled when you have rtc compiled as a module. I hope this
bug will be fixed soon.

I found the following modules.conf search the internet for snd-rtctimer:

options snd-timer snd_timer_limit=2
alias snd-timer-1 snd-rtctimer
options snd-seq snd_seq_default_timer_resolution=1000 snd_seq_default_timer=1

This doesn't work. The snd_seq_default_timer parameter doesn't exist anymore.
Instead, there are
snd_seq_default_timer_class, 
snd_seq_default_timer_sclass,
snd_seq_default_timer_card,
snd_seq_default_timer_device
and snd_seq_default_timer_subdevice

My question: how do I use these? Can you give me an example modules.conf
(I have a SB Live!, but I guess any card will do)

And, how can I check, once everything is working, that the sequencer is
indeed using the rtctimer (apart from hearing it)

Maarten
