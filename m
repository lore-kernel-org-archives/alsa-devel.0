From: K.Fetscher@t-online.de (Klaus Fetscher)
Subject: Re: Cross Compile Problems
Date: Thu, 11 Nov 2004 23:25:37 +0100
Message-ID: <4193E6E1.9050106@fetron.de>
References: <418FEF0E.8080304@fetron.de>	<s5h3bzjs9hr.wl@alsa2.suse.de>	<4191C315.7050206@fetron.de> <s5h654eav4a.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5h654eav4a.wl@alsa2.suse.de>
Sender: alsa-devel-admin@lists.sourceforge.net
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

Takashi Iwai schrieb:

>Hmm, I'm not clear why prefix must be specified in your case.
>
>If you set up the cross compiling environment, usually prefix isn't
>needed but you just need to specify the proper compiler, etc.
>And, installing to other root system will be done by adding
>"DESTDIR=xxx" at make install.
>
>
>  
>
You are right, I have installed the libraries wrong and now I have 
corrected it. Anyway, I get always the same error result.

I think you are right with your last answer that the shared lib file 
can't be read correctly because of the installed path.

How can I check if the libs are correct ?

Is it correct that I first compile and install the alsa-lib-1.0.7 (with --enable-shared=yes and --enable-static=yes --with-softfloat) and later alsa-utils-1.0.7. Is this correct ?

Thanks,

Klaus




-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
