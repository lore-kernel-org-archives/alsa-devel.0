From: Patrick Shirkey <pshirkey@boosthardware.com>
Subject: Re: usb quattro
Date: Thu, 05 Sep 2002 23:02:14 +0900
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3D7763E6.1090601@boosthardware.com>
References: <Pine.LNX.4.21.0209042052440.726-100000@summer.quitte>
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
To: Tim Goetze <tim@quitte.de>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Tim Goetze wrote:
> Takashi Iwai wrote:
> 
> 
>>At Thu, 05 Sep 2002 01:35:39 +0900,
>>Patrick Shirkey wrote:
>>
>>>Sorry if this is stupid, I'm not a trained programmer. I get this now.
>>>
>>>Do you know how to fix it?
>>
>>	% gcc -l qinit qinit.c -lasound -ldl -lm
> 
> 
> rather
> 
> $ gcc -o qinit qinit.c -lasound -ldl -lm
>        ^
> i think.
>

That was it. Thanks.

Yes this code works. I don't know what that means though?

I have also found a serious kernel oops which is caused when starting 
jack with this card. It also fscked my user profile in mozilla so I have 
lost all my emails from teh past 6 months.




-- 
Patrick Shirkey - Boost Hardware Ltd.
For the discerning hardware connoisseur
Http://www.boosthardware.com
Http://www.boosthardware.com/LAU/guide/
========================================

"Um...symbol_get and symbol_put... They're
kindof like does anyone remember like get_symbol
and put_symbol I think we used to have..."
- Rusty Russell in his talk on the module subsystem



-------------------------------------------------------
This sf.net email is sponsored by: OSDN - Tired of that same old
cell phone?  Get a new here for FREE!
https://www.inphonic.com/r.asp?r=sourceforge1&refcode1=vs3390
