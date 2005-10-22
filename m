From: Nazo <nazosan@gmail.com>
Subject: Re: Problem with several Creative Labs soundcards, possibly more?
Date: Fri, 21 Oct 2005 21:58:41 -0500
Message-ID: <a5a496a90510211958s1252b5fds1e91c699c3bfe7dc@mail.gmail.com>
References: <a5a496a90510190840v7f7d2345s133b06eaad0a4719@mail.gmail.com>
	 <ad2655cb0510190920n5a0a4ddby@mail.gmail.com>
	 <a5a496a90510191156i24c69e17yc35184577090f9f5@mail.gmail.com>
	 <4356C414.9060008@superbug.co.uk>
	 <a5a496a90510191414n651099e8x9d9952638ce84729@mail.gmail.com>
	 <4356C875.5030607@superbug.co.uk>
	 <a5a496a90510191845w55200b77y927dc92470b15784@mail.gmail.com>
	 <a5a496a90510211519y15711764ode0a2fe4053695d8@mail.gmail.com>
	 <1129939134.4724.26.camel@mindpipe>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-user-admin@lists.sourceforge.net>
In-Reply-To: <1129939134.4724.26.camel@mindpipe>
Content-Disposition: inline
Sender: alsa-user-admin@lists.sourceforge.net
Errors-To: alsa-user-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-user>,
	<mailto:alsa-user-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-user@lists.sourceforge.net>
List-Help: <mailto:alsa-user-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-user>,
	<mailto:alsa-user-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-user>
To: Lee Revell <rlrevell@joe-job.com>
Cc: alsa-user@lists.sourceforge.net, alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

If I boot with pci=3Dnoacpi, the normal mandriva kernel hangs just after
it says hit I for interactive setup.  The vanilla one starts up, but,
when I try to play an audio file, I have the same problem.  Bear in
mind when saying the problem lies with the kernel that I've seen this
issue on several different kernel versions.

As for my motherboard, it's a Gigabyte 9NDA3J.  The chipset is the
nForce 3 Ultra (which I believe is basically just a nForce 3 250 with
the only change being the socket type, but, I'm not 100% sure.)  I
think I saw some things using the 250 driver for the motherboard
rather than saying ultra, but, like I said, I think this is probably
ok.

On 10/21/05, Lee Revell <rlrevell@joe-job.com> wrote:
> On Fri, 2005-10-21 at 17:19 -0500, Nazo wrote:
> > When I got it to sucessfully boot, and tried to play something, it
> > played one frame over and over in a loop (kind of like what happens
> > when the system locks up in the middle of a game or something.)  When
> > the application was closed and another different sound file was
> > attempted, it gave an IO error and no sound came out at all.  Based on
> > the way it kind of acted like the hardware locked up or something, my
> > first guess would be maybe something along the lines of an IRQ
> > conflict or somesuch?  That's just a guess though.  Anyway, he thought
> > it might be useful if I provided some extra info, so I've added them
> > to the bottom of the message:
> >
>
> OK, this is a classic sign that interrupts are not being acknowledged
> properly.  It's not a problem with the ALSA drivers but with the kernel.
> Probably an ACPI issue.
>
> What is the make and model of your motherboard?
>
> Does it work if you boot with "pci=3Dnoacpi"?
>
> Lee
>
>
>


-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
