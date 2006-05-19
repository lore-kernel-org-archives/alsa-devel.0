From: "jayakumar alsa" <jayakumar.alsa@gmail.com>
Subject: Re: Dear all (X-Fi)
Date: Fri, 19 May 2006 21:13:59 +0800
Message-ID: <47f5dce30605190613l7792574an8bc77e49a5ebed17@mail.gmail.com>
References: <1147989829.3506.3.camel@server>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <1147989829.3506.3.camel@server>
Content-Disposition: inline
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: "V.N Ambrose" <noel.ambrose@gmail.com>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On 5/19/06, V.N Ambrose <noel.ambrose@gmail.com> wrote:
> Dear all
>
> I have an X-fi Card and want it supported in Linux.

You have good intentions and you're not alone. I suspect it's the same
card discussed in this bug report:

https://bugtrack.alsa-project.org/alsa-bug/view.php?id=3D1327

> I have university level c++ knowledge and have been using linux/bsd for
> 10yrs now.
> I am willing to provide all and i repeat all my free time towards
> getting this supported. I do not have driver programming experience and
> if someone can help assist , we are at least off to a start.

Excellent. Note that ALSA drivers and the Linux kernel are in C. I
recommend you spend some time reading through this book [free pdf] on
the Linux kernel and device drivers in general:

http://lwn.net/Kernel/LDD3/

and also read Takashi's and other ALSA documentation after that:

http://www.alsa-project.org/~iwai/writing-an-alsa-driver/

At that point, you'll have a good idea of what kind of data you're
looking for in order to write a driver for this card.

> I have the hardware on my personal computer and can supply whatever
> information needed that i can retrieve using my Fedora 5 OS.

I suspect that initially, you'll find that you'll need Windows in
order to reverse engineer what Creative's windows driver is doing. You
might be able to achieve this in many ways. You could get the
Microsoft DDK and write a filter driver that sits between Creative's
driver and the PCI subsystem or is at least able to watch what calls
are being made. If you have access to an ICE debugger and/or other
windows tools, you might also watch the register read/writes that way.
You could also, as James pointed out, do a .sys object dump of
Creative's driver and try to work out the various low level functions
that achieve things like setting up DMA, configuring rates, accessing
AC97 and other things.

As you can probably imagine, all this stuff is not likely to be a
short and easy piece of work. :-) But the process of doing it can be
quite enjoyable so gather together some friends and start hacking at
it.

jayakumar


-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
