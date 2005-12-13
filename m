From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001645]: Race in snd_timer_start1 breaks rtctimer
Date: Tue, 13 Dec 2005 10:09:59 +0100
Message-ID: <a885f34d4aa1893025247ecd5def2b84@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id B35DE198
	for <alsa-devel@alsa-project.org>; Tue, 13 Dec 2005 10:09:59 +0100 (MET)
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


The following issue has been SUBMITTED.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1645> 
======================================================================
Reported By:                TimMann
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   1645
Category:                   CORE - timer
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     new
Distribution:               Mandriva 2006
Kernel Version:             linux-2.6.12-12.mm.2mdk or linux-2.6.12-12.mm.5mdk
======================================================================
Date Submitted:             12-13-2005 10:09 CET
Last Modified:              12-13-2005 10:09 CET
======================================================================
Summary:                    Race in snd_timer_start1 breaks rtctimer
Description: 
snd_timer_start1 currently looks like this:

static int snd_timer_start1(snd_timer_t *timer, snd_timer_instance_t
*timeri, unsigned long sticks)
{
	list_del(&timeri->active_list);
	list_add_tail(&timeri->active_list, &timer->active_list_head);
	if (timer->running) {
		if (timer->hw.flags & SNDRV_TIMER_HW_SLAVE)
			goto __start_now;
		timer->flags |= SNDRV_TIMER_FLG_RESCHED;
		timeri->flags |= SNDRV_TIMER_IFLG_START;
		return 1;	/* delayed start */
	} else {
		timer->sticks = sticks;
		timer->hw.start(timer);
	      __start_now:
		timer->running++;
		timeri->flags |= SNDRV_TIMER_IFLG_RUNNING;
		return 0;
	}
}

Notice it calls timer->hw.start(timer) before doing timer->running++.  If
the timer interrupts between these two lines of code, we'll hit this code
in snd_timer_interrupt:

	if (timer->running) {
		if (timer->hw.flags & SNDRV_TIMER_HW_STOP) {
			timer->hw.stop(timer);
			timer->flags |= SNDRV_TIMER_FLG_CHANGE;
		}
		if (!(timer->hw.flags & SNDRV_TIMER_HW_AUTO) ||
		    (timer->flags & SNDRV_TIMER_FLG_CHANGE)) {
			/* restart timer */
			timer->flags &= ~SNDRV_TIMER_FLG_CHANGE;
			timer->hw.start(timer);
		}
	} else {
		timer->hw.stop(timer);
	}

Since timer->running is not set yet, the timer gets stopped again
immediately.

I'll attach a patch that fixes the problem for me by reordering code in
snd_timer_start1.  I'd suggest that someone who knows the code better
should look around and make sure there isn't anything else that breaks if
an interrupt comes too soon after timer->hw.start(timer) is called,
though.




======================================================================

Issue History
Date Modified  Username       Field                    Change              
======================================================================
12-13-05 10:09 TimMann        New Issue                                    
12-13-05 10:09 TimMann        File Added: timer.c.patch                    
12-13-05 10:09 TimMann        Distribution              => Mandriva 2006   
12-13-05 10:09 TimMann        Kernel Version            =>
linux-2.6.12-12.mm.2mdk or linux-2.6.12-12.mm.5mdk
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
