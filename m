From: Giuliano Pochini <pochini@shiny.it>
Subject: Re: C++ driver ?
Date: 02 Mar 2003 16:25:19 +0000
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1046622320.1023.33.camel@Jay>
References: <s5hof50zmhx.wl@alsa2.suse.de> <s5hof4wihea.wl@alsa2.suse.de>
	<1046529108.13656.23.camel@Jay>  <200303012336.34549.david@olofson.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <200303012336.34549.david@olofson.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: David Olofson <david@olofson.net>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On sab, 2003-03-01 at 22:36, David Olofson wrote:
> I've done some C++ in kernel space (RTLinux), but the short story: I
> wouldn't recommend it, and I don't think anything complex enough to
> really warrant the use of C++ should live in kernel space anyway.

Yes, I know, but possibly I would like to use that drivers, at least to
make my card work in acceptable amount of time. I cannot convert 740KB
of code quickly. I had a look at the code and it's mostly usable, IF
there are no C/C++link problems. Are there any ? That generic driver is
not completely generic because ::operator new/delete is not defined in
all objects.

> Of course, I don't know how much longer Real Life and other projects
> will keep me from getting started with this. I just won't start yet
> another project with a bunch of others in a state of "to be released
> RSN". Too much task switching overhead. ;-)
>
> If someone beats me to it, I'll do what I can to help out.

I already started working on it... ehm, take into account I've never
written a line of alsa code before yearstday :). But I want to make my
new expensive toy work asap.

Bye.




-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
