From: "Denis de Leeuw Duarte" <denis@cyozlab.com>
Subject: Re: USB Audio problems
Date: Fri, 21 Nov 2003 11:31:03 -0000 (GMT)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <33813.145.94.38.51.1069414263.squirrel@mail2.slik.org>
Reply-To: denis@cyozlab.com
Mime-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
References: 
In-Reply-To: 
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hello list,

I'm new here so hi, and sorry if I missed out on things discussed earlier=
.
I subscribed to this list because I've been having lost of problems with
the USB driver over the past half year (similar to the stuff mentioned in
this thread). So much so, that I am prepared to dive into the code and
help fixing it.

> > (but still we have a problem of async unlink because prepare callback
> >  is also in the spinlocked context.)
> Would it be fair to say that this driver requires some major rework?

Well, to give you an impression of the magnitude of the problem:

Last thursday I started Sweep, using my Quattro for output, and it
crashed. No big deal there, but not only did the crash lock up my
system, it also wiped out the better part of my root partition. That is
the kernel just randomly overwrote some files with junk. KDE was messed u=
p
beyond repair, a number of files in /etc needed to be replaced and the
better part of the /root dir was clobbered. I had a gig the next day and =
I
run a source distro, so a quick reinstall was pretty much out of the
question. Needless to say, I did not have a lot of sleep that night :)

Although I understand that all parts of ALSA are important and deserve
attention, I would like to point out the impact of this situation: the
ALSA driver is (afaik?) the _only_ driver linux has for USB audio devices
(except speakers). Us usb users don't have the OSS drivers to fall back
on, so as long as the ALSA usb driver can wreck an installation, there
really is no decent support for USB audio in Linux. Anyway, just a
thought.

Meanwhile I'm doing my best to learn al I can about the ALSA drivers and
driver writing in general. Hopefully I'll be able to make a more
constructive contribution to this list in due time. Can anyone give me a
few hints on where the 'problematic' areas in the code are regarding USB?
So far I've heard about the core pcm stuff and the usb driver itself. Is
there any information (possibly written down somewhere) about the major
problem areas?

Regards,

Denis de Leeuw Duarte








-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?  SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
