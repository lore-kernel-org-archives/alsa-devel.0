From: Ismael Valladolid Torres <ismael@sambara.org>
Subject: Re: Measuring latency on my Apple G3
Date: Mon, 21 Jul 2003 13:46:41 +0200
Message-ID: <3F1BD2A1.7030404@sambara.org>
References: <3F1BB92C.6090600@sambara.org> <1058785796.28382.139.camel@thor.holligenstrasse29.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <bounce-debian-powerpc=debian-powerpc=m.gmane.org@lists.debian.org>
In-Reply-To: <1058785796.28382.139.camel@thor.holligenstrasse29.lan>
Resent-Message-ID: <tFXzSB.A.aMF.7L9G_@murphy>
List-Post: <mailto:debian-powerpc@lists.debian.org>
List-Help: <mailto:debian-powerpc-request@lists.debian.org?subject=help>
List-Subscribe: <mailto:debian-powerpc-request@lists.debian.org?subject=subscribe>
List-Unsubscribe: <mailto:debian-powerpc-request@lists.debian.org?subject=unsubscribe>
List-Archive: <http://lists.debian.org/debian-powerpc/>
To: =?ISO-8859-1?Q?Michel_D=E4nzer?= <daenzer@debian.org>
Cc: linux-audio-dev@music.columbia.edu, linux-audio-user@music.columbia.edu, alsa-devel@lists.sourceforge.net, alsa-user@lists.sourceforge.net, debian-powerpc@lists.debian.org
List-Id: alsa-devel@alsa-project.org

Michel Dänzer escribio el 21/07/03 13:09:
> First of all, you mentioned in another post that you use x11perf to
> create X11 stress. Are there also problems with real world apps?

"Real world" apps work properly (except for the Gnome theme manager 
which displays garbage). I only find video performance using Linux a lot 
lower than using any of the Mac OS's.

> Also keep in mind that neither the vanilla 2.4 kernel nor the X server
> were designed for low latency. Have you tried the low latency and/or
> O(1) scheduler kernel patches, and not running the X server with
> negative nice values if you are?

Both of those patches (A. Morton and R. Love's ones) were applied to my 
kernel. I don't know about running the X server with different nice 
values, which advantage would I get? (I am using gdm as my X session 
manager).

> Last but possibly not least of all, the dmasound driver has been less
> prone to dropouts in my experience than the ALSA driver.

I should try with pure OSS. Let's not forget that the latency test suite 
is using the OSS compatibility layer of ALSA.

Thanks a lot. Any feedback is still very useful.

Regards, Ismael
