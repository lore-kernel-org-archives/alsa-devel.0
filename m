From: K.Fetscher@t-online.de (Klaus Fetscher)
Subject: Re: Cross Compile Problems
Date: Fri, 12 Nov 2004 13:35:39 +0100
Message-ID: <4194AE1B.50300@fetron.de>
References: <418FEF0E.8080304@fetron.de>	<s5h3bzjs9hr.wl@alsa2.suse.de>	<4191C315.7050206@fetron.de>	<s5h654eav4a.wl@alsa2.suse.de>	<4193E6E1.9050106@fetron.de> <s5h4qjvfihp.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5h4qjvfihp.wl@alsa2.suse.de>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Takashi Iwai schrieb:

Thanks Takashi for your help, now it works.

>>Is it correct that I first compile and install the alsa-lib-1.0.7
>>(with --enable-shared=yes and --enable-static=yes --with-softfloat)
>>and later alsa-utils-1.0.7. Is this correct ? 
>>    
>>
>
>Unfortunately, you can't build shared and static libraries at the same
>time.  See INSTALL for details.
>
>  
>
Is it correct, to build the libraries two times (one time shared and one 
time static) ?



Now, I will do the difficult part (ARM and DMA ..).


Thanks

Klaus



-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
