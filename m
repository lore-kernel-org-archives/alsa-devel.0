From: pdq808@t-online.de (Reiner Klenk)
Subject: Re: Delta 410 support broken in CVS ?
Date: Mon, 29 Mar 2004 19:56:20 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <40686344.3070006@t-online.de>
References: <4066F118.10902@t-online.de> <Pine.LNX.4.58.0403281755000.3294@pnote.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.58.0403281755000.3294@pnote.perex-int.cz>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Hi,
that seems to fix it. Thanks, Jaroslav.

Regards,
Reiner

Jaroslav Kysela wrote:
> On Sun, 28 Mar 2004, Reiner Klenk wrote:
> 
> 
>>Greetings,
>>my Midiman Delta 410 doesn't work with CVS or 1.0.3
>>modprobe snd-ice1712 gives an error and the logfile says:
>>
>>../alsa-kernel/i2c/cs8427.c:225: unable to find CS8427 signature 
>>(expected 0x71, read 0xff), initialization is not completed
> 
> 
> Got it. Please, try this patch:
>



-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
