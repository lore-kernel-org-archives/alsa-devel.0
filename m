From: Paul Davis <pbd@op.net>
Subject: Re: SNDRV_PCM_IOCTL_HW_FREE failed
Date: Wed, 14 Aug 2002 06:25:34 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <E17evJp-0003Je-00@usw-sf-list1.sourceforge.net>
References: <3D5A2AA6.5010708@solid-state-logic.com>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: Your message of "Wed, 14 Aug 2002 11:02:14 BST."
             <3D5A2AA6.5010708@solid-state-logic.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Fergus Reid <fergusr@solid-state-logic.com>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

>Hi, this may well be nothing to do with alsa but I thought you may know 
>what is happening.
>If I make a system call from one thread whilst recording or playing in 
>another thread using the alsa lib, then when I try to snd_pcm_close I get:
>
> >ALSA lib pcm_hw.c:145:(snd_pcm_hw_hw_free) SNDRV_PCM_IOCTL_HW_FREE 
>failed: File >descriptor in bad state

i think we need to see code.


-------------------------------------------------------
This sf.net email is sponsored by: Dice - The leading online job board
for high-tech professionals. Search and apply for tech jobs today!
http://seeker.dice.com/seeker.epl?rel_code=31
