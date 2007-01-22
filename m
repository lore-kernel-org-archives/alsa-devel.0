From: "John Utz" <John.Utz@dmxmusic.com>
Subject: Re: AC97_SINGLE() Howto?
Date: Mon, 22 Jan 2007 08:58:26 -0800
Message-ID: <F8FB97052F1BEF409F7842E960E49B5ADF367C@sea-exch-01.na.corp.dmxmusic.com>
References: <F8FB97052F1BEF409F7842E960E49B5ADF3493@sea-exch-01.na.corp.dmxmusic.com>
	<s5hac0bf92y.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Content-class: urn:content-classes:message
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
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Thankyou for your additional response!

-----Original Message-----
>From: alsa-devel-bounces@lists.sourceforge.net
[mailto:alsa-devel->bounces@lists.sourceforge.net] On Behalf Of Takashi
Iwai
>
>At Fri, 19 Jan 2007 18:35:41 -0800,
>John Utz wrote:
>> 
>> Hello Again;
>> 
>> I have a vt1618 register bit that I am trying to set so that I can
>> get surround out of the mic in and line in.
>> 
>> From the chip docs, I want to set bit 3 of 0x76 to 1.
>> 
>> Is the following macro usage correct?:
>> 
>> AC97_SINGLE("Switch Surround Back Channels", 0x76, 3, 1, 0)
>
> Yes, but this mixer name sounds unusual...

:-)

Is there actually a standard? If there is, I would be happy to use it!

Currently, it seems like there are many different ways that items are
named.

The name I choose was derived from the via docs that describe the
register.

But, as I said, I love standards and conventions and I will be happy to
follow one with my code.....

> Takashi

------------------------------------------------------------------------
-
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share
your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDE
V
_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel



-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
