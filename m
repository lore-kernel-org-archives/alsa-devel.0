From: Francisco Moraes <fmoraes74@netzero.net>
Subject: Re: Emu10k1x driver
Date: Sat, 15 May 2004 17:30:52 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <40A68C0C.4030308@netzero.net>
References: <20040514.183141.22943.204423@webmail25.nyc.untd.com> <s5hhduhltgu.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hhduhltgu.wl@alsa2.suse.de>
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

>>Is your patch for kernel 2.6?
>>    
>>
>
>to the latest ALSA cvs.
>you'd better to get the CVS tree (either via cvs or snapshot).
>it already incldues emu10k1x.c.
>  
>
I got it from there but your changes to add the module params don't 
compile on my system (Red Hat Fedora Core 1 - 2.4.22-2188 kernel).

There is also a problem with mono streams, so the hw params need to 
indicate that only stereo is supported. Also, is there any advantage in 
enabling both interrupts in the buffer (loop and half loop)? Also, how 
important is the definition of period bytes? It seems it should be the 
same as the buffer size. Maybe you can just explain it to me how it 
relates to the total buffer size being used.

Regards,

Francisco


-------------------------------------------------------
This SF.Net email is sponsored by: SourceForge.net Broadband
Sign-up now for SourceForge Broadband and get the fastest
6.0/768 connection for only $19.95/mo for the first 3 months!
http://ads.osdn.com/?ad_id=2562&alloc_id=6184&op=click
