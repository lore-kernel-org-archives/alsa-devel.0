From: Paul Davis <paul@linuxaudiosystems.com>
Subject: Re: RME Hammerfall HDSP 9652
Date: Thu, 28 Aug 2003 09:05:21 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200308281305.h7SD5LaW013628@oud>
References: <32941.193.253.35.6.1062074441.squirrel@www.undata.org>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: Your message of "Thu, 28 Aug 2003 14:40:41 +0200."
             <32941.193.253.35.6.1062074441.squirrel@www.undata.org>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Thomas Charbonnel <thomas@undata.org>
Cc: nick.arnold@nautronix.com.au, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

> 3) is it possible to use the "Internal 48.0 kHz" setting and keep things
>>    "like they used to be"?  Whereby we retain responsiblity for the
>> interleaving and de-interleaving of channels; we operate on the full
>> 26 channels; and we can make little (if any) code changes?
>
>No, you can't. The internal rate is then really 96kHz, and the clock
>signal on the spdif output is indeed 96kHz. One thing you could do, maybe,
> would be to simulate in userspace what the card is doing in hardware,
>keeping the 48 kHz sample rate, if you really need that.

but if they don't use the s/pdif channels, then you can do this. i
tried it a long time ago on the hammerfall digi9652. it works, but it
strikes me as a silly idea :)

--p


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
