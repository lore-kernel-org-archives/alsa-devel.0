From: Giuliano Pochini <pochini@shiny.it>
Subject: Re: period crossing page boundary
Date: Thu, 20 Mar 2003 15:13:12 +0100 (CET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <XFMail.20030320151312.pochini@shiny.it>
References: <s5h7kaus4qh.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5h7kaus4qh.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel <alsa-devel@lists.sourceforge.net>alsa-devel <alsa-devel@lists.sourceforge.net>, Jaroslav Kysela <perex@suse.cz>
List-Id: alsa-devel@alsa-project.org


>> Ok, but how do I build the sg list when bufsize!=sz*periods ? Take
>> the example above: have I to build 4 periods and let the last one
>> smaller than 22052 ?
>
> it depends on the hardware.

There are no hw constraints IFAIK, but the hw does not provide the
current dma address. It tells me how many bytes it transferred from
the trigger-start command, so I need a way to translate that number
into a frame pointer inside the buffer. To do that I must know
exactly how long is the buffer to build the sg list and to stranslate
the byte count in the pointer callback. (it's not enough see below)
What does alsa expect from .pointer() ? [0-bufsz] or [0-pe*sz] ?

> if you need to set up a buffer-descriptor list like via82xx, the above
> h/w constraint (integer periods) will be most likely necessary.
> then the buffer size will be aligned to the period size
> automatically.

It's a quick and simple way to make things work, but it should't
be necessary.
The driver currently behaves correctly in two cases:

a - period size is a multiple of PAGE_SIZE
b - PAGE_SIZE is a multiple of period size

In both cases periods*periodsize matches buffer_size. But if
periods*periodsize==buffer_size and !a and !b (eg. pe=4, psz=6K,
bufsz=24K), it doesn't work:

page0 per0[0-4095]
page1 per0[4096-6143] per1[0-2048]
page2 per1[2048-6143]
...

There must be something I don't see/know. Before calling Echoaudio
dev support I want be sure it's not my fault.

Bye.



-------------------------------------------------------
This SF.net email is sponsored by: Tablet PC.  
Does your code think in ink? You could win a Tablet PC. 
Get a free Tablet PC hat just for playing. What are you waiting for? 
http://ads.sourceforge.net/cgi-bin/redirect.pl?micr5043en
