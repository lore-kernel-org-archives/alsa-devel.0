From: Mathias Kretschmer <mathias@lemur.sytes.net>
Subject: Re: VIA EPIA (VT1612A) and SPDIF
Date: Fri, 21 Feb 2003 22:19:16 -0500
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3E56EC34.1050205@lemur.sytes.net>
References: <3E52CD2B.7090505@lemur.sytes.net> <s5h7kbwhb4l.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5h7kbwhb4l.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Takashi Iwai wrote:
> At Tue, 18 Feb 2003 19:17:47 -0500,
> Mathias Kretschmer wrote:
> 
>>Hi,
>>
>>I'm wondering if anyone has SPDIF working on the
>>VIA EPIA ESP5000 under rc7?
>>
>>Analog output is working fine for me using rc7 and the CVS via82xx 
>>module (1.25). But, I didn't have any luck getting SPDIF (PCM) to work 
>>using a Pioneer Digital Receiver.
>>
>>Any success reports or any hints which knobs to turn to make it work ?
> 
> 
> the code on rc7 doesn't set the correct SPDIF rate, so it won't work
> properly.  i changed via82xx.c to set it for via686, too.  please try
> the cvs version.

OK, I just installed the lastest CVS snapshot and also copied
VIA686A.conf to /usr/share/alsa/cards.

Using aplay I'm getting some spdif output. It's very jerky, though.
There is audio for a few 100ms and then silence, and then signal again.
Same effect using an OSS player.  The analog output works fine - no 
interruptions at all.

The sample rate as either 44.1kHz or 48kHz - same problem.

I just got a EPIA-M1000 board. It has a 8235 and spdif works just fine
here using either aplay or an OSS player.

Any further info I can provide to help tracking down the problem ?

Cheers,

Mathias



-------------------------------------------------------
This SF.net email is sponsored by: SlickEdit Inc. Develop an edge.
The most comprehensive and flexible code editor you can use.
Code faster. C/C++, C#, Java, HTML, XML, many more. FREE 30-Day Trial.
www.slickedit.com/sourceforge
