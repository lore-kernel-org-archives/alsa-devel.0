From: Giuliano Pochini <pochini@denise.shiny.it>
Subject: Re: 1.0.13 and indigoio
Date: Fri, 6 Oct 2006 12:26:20 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.0610061220220.4839@denise.shiny.it>
References: <70a871c80610050536w2968cd52n32a5960899b4e90b@mail.gmail.com>
	<s5hbqororyw.wl%tiwai@suse.de>
	<70a871c80610050549i67273c2bs4eab40731685bb47@mail.gmail.com>
	<s5hu02iu1ni.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <s5hu02iu1ni.wl%tiwai@suse.de>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Takashi Iwai <tiwai@suse.de>
Cc: Dmitry Baikov <dsbaikov@gmail.com>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org



On Thu, 5 Oct 2006, Takashi Iwai wrote:

> At Thu, 5 Oct 2006 16:49:16 +0400,
> Dmitry Baikov wrote:
>>
>> [ 1090.574000] pccard: card ejected from slot 0
>> [ 1090.605000] PCMCIA: socket f7c0f828: *** DANGER *** unable to remove socket power

I wonder what this may cause. Dmitry said the first insersion works.


> Then this must be a problem regarding the DSP access.
>
> Giuliano, any clue?
>
> (BTW, such serious error messages should be always shown even without
> debug option.)

"Resident loader failed to set HF5" is not more meaningful than a -EIO. 
The dsp doesn't provide any debug support, I haven't any doc on the 
hardware of any card and the firmware is in binary form. I just know 
something didn't work :(


--
Giuliano.

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
