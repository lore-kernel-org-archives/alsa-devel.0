From: "Eliot Blennerhassett" <bigblen@icqmail.com>
Subject: snd_card_dummy_pcm_timer_function
Date: Sun, 18 May 2003 18:05:36 -0700 (PDT)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20030518180536.14882.h003.c012.wm@mail.icqmail.com.criticalpath.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

static void snd_card_dummy_pcm_timer_function(unsigned long data)
{
...
	spin_lock_irq(&dpcm->lock);
...
	while (dpcm->pcm_irq_pos >= dpcm->pcm_count) {
		dpcm->pcm_irq_pos -= dpcm->pcm_count;
		snd_pcm_period_elapsed(dpcm->substream);
	}
	spin_unlock_irq(&dpcm->lock);	
}

Should the while loop be replaced by this, because 
 * Even if more than one periods have elapsed since the last call, you
 * have to call this (snd_pcm_period_elapsed) only once.


	if (dpcm->pcm_irq_pos >= dpcm->pcm_count) {
		dpcm->pcm_irq_pos %= dpcm->pcm_count;
?? spin_unlock_irq()
		snd_pcm_period_elapsed(dpcm->substream);
?? spin_lock_irq()
	}

Eliot Blennerhassett
AudioScience Inc.
--
Junk footer beyond this point. Read at your own risk.


-------------------------------------------------------------
Sign up for ICQmail at http://www.icq.com/icqmail/signup.html


-------------------------------------------------------
This SF.net email is sponsored by: If flattening out C++ or Java
code to make your application fit in a relational database is painful, 
don't do it! Check out ObjectStore. Now part of Progress Software.
http://www.objectstore.net/sourceforge
