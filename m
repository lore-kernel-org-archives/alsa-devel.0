From: Trent Piepho <xyzzy@speakeasy.org>
Subject: Re: [alsa-devel] [PATCH] Improved support for different	bt87x	board
 configurations
Date: Wed, 5 Sep 2007 02:09:45 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0709050120490.31808@shell4.speakeasy.net>
References: <Pine.LNX.4.58.0708300319210.18152@shell4.speakeasy.net>
	<s5h3ay1i8rs.wl%tiwai@suse.de>
	<Pine.LNX.4.58.0709021603380.18152@shell4.speakeasy.net>
	<1188801407.6762.1208578117@webmail.messagingengine.com>
	<Pine.LNX.4.58.0709040447220.31808@shell4.speakeasy.net>
	<1188914079.6535.47.camel@areia> <s5hr6leyy0r.wl%tiwai@suse.de>
	<Pine.LNX.4.58.0709041339540.31808@shell4.speakeasy.net>
	<1188975275.6158.34.camel@areia>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=X-UNKNOWN
Content-Transfer-Encoding: quoted-printable
Return-path: <video4linux-list-bounces@redhat.com>
In-Reply-To: <1188975275.6158.34.camel@areia>
List-Unsubscribe: <https://www.redhat.com/mailman/listinfo/video4linux-list>,
	<mailto:video4linux-list-request@redhat.com?subject=unsubscribe>
List-Archive: <https://www.redhat.com/mailman/private/video4linux-list>
List-Post: <mailto:video4linux-list@redhat.com>
List-Help: <mailto:video4linux-list-request@redhat.com?subject=help>
List-Subscribe: <https://www.redhat.com/mailman/listinfo/video4linux-list>,
	<mailto:video4linux-list-request@redhat.com?subject=subscribe>
Sender: video4linux-list-bounces@redhat.com
Errors-To: video4linux-list-bounces@redhat.com
To: Mauro Carvalho Chehab <mchehab@infradead.org>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, Linux and Kernel Video <video4linux-list@redhat.com>
List-Id: alsa-devel@alsa-project.org

On Wed, 5 Sep 2007, Mauro Carvalho Chehab wrote:
> Em Ter, 2007-09-04 =C3=A0s 14:04 -0700, Trent Piepho escreveu:
> > There are few drawbacks.
> >
> > First, there are like 20x more cards supported by the bttv driver tha=
n by
> > the bt87x driver.  It's going to produce a very sparse card database =
in the
> > ALSA driver.  Note that for the most part, __initdata doesn't work, s=
o you
> > can't say "it'll just be dropped after the driver loads."
>
> You should notice that even the way you've mapped is a a little sparse,
> since just two boards use digital_fmt.
>
> Maybe one solution for that is to use a different code or data
> structure.
>
> For example, instead of using a data struct, you could use some sort of
> code like (*) (**):
>
> static void fill_board (struct snd_bt87x_board &board, int board_id)
> {
>         board->dig_rate =3D 32000;
>         switch (board_id) {
>         case BTTV_BOARD_AVPHONE98:
>                 board.dig_rate =3D 48000,
> 		break;

I don't think gcc will be smart enough to a bunch of cases with random nu=
mbers
into a O(1) lookup, instead it will use an O(log n) branch chain.  With a=
ll
the explicit assignments, I doubt it will be much smaller, if any, since =
there
are just a couple board configurations.  Several board configurations are
currently duplicates and I think I'll just merge them.

But code wise I think using a switch with manual assignments is ugly.  It=
's a
lot more code to write and just doesn't have the regularity and elegance =
of a
table.

> > And if both linuxtv and alsa use the same header, what happens if the=
y
> > don't push the changes to GIT at the exact same time?  You'll have pa=
tches
> > in one subsystem that are dependant on the other subsystem.  How will=
 they
> > make the same merge window?
>
> This should be coordinated between me and Takashi. I have no objections
> if he pull such patch, if he is willing to send the pull request before
> myself.
>
> I don't see this as a big trouble. There are other cases like this
> already (pci_ids.h, i2c_id.h). Also, currently, there are not much bttv
> board additions anymore.

And pci_ids and i2d_id are pain to deal with.  Both v4l-dvb and ALSA have=
 out
of kernel tree build system that try to be backward compatible with older
kernels.  When the IDs come from somewhere outside the repository, you ne=
ed to
have compat patches to deal with old id files that are missing ids.  Look=
 at
all the kernel-sync patches for those id files, all the compat code in th=
e
various drivers for non-defined PCI ids.  There's even something I had to=
 add
to compat.h for an i2c ID that went away in newer kernels.

It's a lot of extra work, and I just don't see the point.  To reuse a cou=
ple
defines from a bttv header file?  They are just arbitrary numbers, it's n=
ot
like there is any benefit from using the same value in both drivers.

--
video4linux-list mailing list
Unsubscribe mailto:video4linux-list-request@redhat.com?subject=3Dunsubscr=
ibe
https://www.redhat.com/mailman/listinfo/video4linux-list
