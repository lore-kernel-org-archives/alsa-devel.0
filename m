From: Francisco Moraes <fmoraes74@netzero.net>
Subject: Re: Emu10k1x driver
Date: Fri, 14 May 2004 19:49:09 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <40A55AF5.6050009@netzero.net>
References: <20040514.045055.28422.197543@webmail10.nyc.untd.com> <s5hlljvm8qz.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hlljvm8qz.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Takashi Iwai wrote:

>i noticed that you set the irq mask IPR_CH_0_LOOP|IPR_CH_0_HALF_LOOP.
>does it mean that the chip generates interrupts twice per buffer?
>if yes, what we need is to limit the number of periods to 2.
>
>  
>
Well, you can enable the half buffer interrupt. I am not sure if that 
helps or improves anything but it is available.

>the attached patch includes some fixes by me for the latest cvs, and
>changes the periods to 2.  i'll apply it to cvs now.
>  
>
I also noticed that I forgot to enable the interrupts for the other two 
voices.

Francisco


-------------------------------------------------------
This SF.Net email is sponsored by: SourceForge.net Broadband
Sign-up now for SourceForge Broadband and get the fastest
6.0/768 connection for only $19.95/mo for the first 3 months!
http://ads.osdn.com/?ad_id=2562&alloc_id=6184&op=click
