From: Patrick Shirkey <pshirkey@boosthardware.com>
Subject: Re: usb quattro
Date: Wed, 04 Sep 2002 23:51:25 +0900
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3D761DED.2020108@boosthardware.com>
References: <3D761979.5050707@boosthardware.com> <s5hn0qx6clp.wl@alsa2.suse.de>
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
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Takashi Iwai wrote:
> At Wed, 04 Sep 2002 23:32:25 +0900,
> Patrick Shirkey wrote:
> 
>>I have just found that the quattro will not output an audible stream 
>>from the external input channels until it has been made to output a 
>>stream through the internal i/o first.
>>
>>This means that the direct monitor switch does not work until a file is 
>>played internally through the card.
>>
>>After that everything works as expected.
>>
>>Is this a fixable bug or should I make a note in the online docs about it?
> 
> 
> could you check whether only hw_params() (prepare()) sets up enough,
> or do you really need to feed data to the output?
> 

I can, how should I go about doing so?

> (although i'm not sure, too, what is missing there...)
> 
> 
> Takashi
> 
> 



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
