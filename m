From: Benny Sjostrand <gorm@cucumelo.org>
Subject: Re: Kernel OOP with alsaplayer driver
Date: Tue, 20 Aug 2002 19:27:04 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3D627BE8.4040904@cucumelo.org>
References: <20020820110644.GA380@orbital.xs4all.nl> <s5hk7mlsok4.wl@alsa2.suse.de>
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
To: Takashi Iwai <tiwai@suse.de>
Cc: Andy Lo-A-Foe <andy@alsaplayer.org>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

>
>
>could you check via strace which ioctl triggers this?
>strangely i cannot reproduce this on my machine.
>
>i guess it's the same problem reported by Benny, the data is
>transferred even after hw_free call (in snd_pcm_close).
>
It does only happens when closing the AlsaPlayer and for me only with 
the snd-cs4xx driver.
I've got another soundcard installed on my machine too using the 
snd-ymfpci driver where it dont
happens. I've not been able to find out why it dont happens with the 
ymfpci driver.

/Benny



-------------------------------------------------------
This sf.net email is sponsored by: OSDN - Tired of that same old
cell phone?  Get a new here for FREE!
https://www.inphonic.com/r.asp?r=sourceforge1&refcode1=vs3390
