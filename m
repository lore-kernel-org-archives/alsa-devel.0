From: Giuliano Pochini <pochini@shiny.it>
Subject: Re: The best-supported Pro Audio device?
Date: Thu, 28 Aug 2003 15:44:10 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <XFMail.20030828154410.pochini@shiny.it>
References: <Pine.LNX.4.44.0308281357350.1958-100000@pnote.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.44.0308281357350.1958-100000@pnote.perex-int.cz>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Jaroslav Kysela <perex@suse.cz>
Cc: Paul Davis <paul@linuxaudiosystems.com>Paul Davis <paul@linuxaudiosystems.com>, "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>, "ametts2@mindspring.com" <ametts2@mindspring.com>
List-Id: alsa-devel@alsa-project.org


On 28-Aug-2003 Jaroslav Kysela wrote:
>> >>--*-- What is the best-supported *Pro Audio* device in terms of solid ALSA dri
>> >>ver support?  Not interested in Sound Blasters and chips on the motherboard --
>> >> something along the lines of the Echo, M-Audio, or RME products.  But the ALS
>> >>A drivers need to be stable -- and need to fully support the capabilities of h
>> >>e respective device (i.e., on-board DSP, MIDI, or whatever).
>> >
>> > the echo drivers are extremely new, and largely untested at this
>> > point. they may even be incomplete.
>>
>> The Echo driver is complete and tested on most supported cards. All
>> features are supported but MIDI and CARDBUS are untested. The driver
>> is based on the Windos driver code and that part is stable. The ALSA
>
> Only small note: until someone rewrite the code using the Linux coding
> style and GPL licence, it will not be included to the ALSA main tree,
> thus it will not be maintaned by us.

It's very unlikely it will follow the coding style because the generic
driver is written by Echoaudio and it's C++ (yuck). It's free software
but not GPL (quite certainly next revision will be released under GPL).
The part written by me is GPL'd from the beginning and the style is not
difficult to fix.


Bye.
    Giuliano.


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
