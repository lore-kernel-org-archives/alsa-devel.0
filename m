From: Vladimir Dergachev <volodya@mindspring.com>
Subject: Re: ES1978
Date: Mon, 9 Sep 2002 09:48:57 -0400 (EDT)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0209090945350.28368-100000@node2.localnet.net>
References: <Pine.LNX.4.44.0209011220100.6752-100000@thor1.lan>
Reply-To: Vladimir Dergachev <volodya@mindspring.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.44.0209011220100.6752-100000@thor1.lan>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Thor Harald Johansen <thj@thj.no>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org



On Sun, 1 Sep 2002, Thor Harald Johansen wrote:

> I own a Toshiba Satellite 2140CDS with an integrated Maestro 2E sound
> card. It currently has Linux installed on it. The ALSA driver works fine.
> That is, until you unplug the mains connector. All that can be heard at
> playback is static noises. MPlayer plays videos *really* slow, so I figure
> audio is really slow too.

This probably has to do with CPU decreasing clock frequency to increase
power efficiency. I was under impression that Linux handles this fine, at
least in 2.4.19 kernel.

It could be, though, that the kernel expects the hardware to notify it
when clock is being reduced.. Things to check: does you kernel have APM or
ACPI support compiled in ? Does it help if you turn off ACPI support in
kernel and use APM ?

                    best

                         Vladimir Dergachev

>
> es1978.c seems frozen in time. Has it got a maintainer? I code C myself,
> and I'm interested in maintaining the driver, but I need some tuts on the
> chip and on kernel module programming.
> --
> Thor
>
>
>
>
> -------------------------------------------------------
> This sf.net email is sponsored by: OSDN - Tired of that same old
> cell phone?  Get a new here for FREE!
> https://www.inphonic.com/r.asp?r=sourceforge1&refcode1=vs3390
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/alsa-devel
>



-------------------------------------------------------
This sf.net email is sponsored by: OSDN - Tired of that same old
cell phone?  Get a new here for FREE!
https://www.inphonic.com/r.asp?r=sourceforge1&refcode1=vs3390
