From: Fergus Reid <fergusr@solid-state-logic.com>
Subject: SNDRV_PCM_IOCTL_HW_FREE failed
Date: Wed, 14 Aug 2002 11:02:14 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3D5A2AA6.5010708@solid-state-logic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi, this may well be nothing to do with alsa but I thought you may know 
what is happening.
If I make a system call from one thread whilst recording or playing in 
another thread using the alsa lib, then when I try to snd_pcm_close I get:

 >ALSA lib pcm_hw.c:145:(snd_pcm_hw_hw_free) SNDRV_PCM_IOCTL_HW_FREE 
failed: File >descriptor in bad state


It seems like some memory corruption, but I've no real idea. If anybody 
knows I would be very grateful for a solution. The effect of this error 
is that my code then hangs forever the next time it tries to 
snd_pcm_open. Perhaps there is a way around this?

Thanks,
Fergus Reid





**********************************************************************
This email and any files transmitted with it are confidential and
intended solely for the use of the individual or entity to whom they
are addressed. If you have received this email in error please notify
the system manager.

This footnote also confirms that this email message has been swept by
MIMEsweeper for the presence of computer viruses.

www.mimesweeper.com
**********************************************************************



-------------------------------------------------------
This sf.net email is sponsored by: Dice - The leading online job board
for high-tech professionals. Search and apply for tech jobs today!
http://seeker.dice.com/seeker.epl?rel_code=31
