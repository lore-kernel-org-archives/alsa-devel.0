From: "Paul Hanly \(Hotmail\)" <paulhanly@hotmail.com>
Subject: au8820 was Re: unresolved symbol snd_verbose_printk with alsa-driver-0.9.8 (also with 0.9.7c)
Date: Wed, 12 Nov 2003 11:40:38 +1100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <BAY2-DAV602Y8pS3Rnl00015c51@hotmail.com>
References: <BAY2-DAV57PulSCKQvP00010290@hotmail.com> <200311111559.36293.ketelaars@wanadoo.nl>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="Windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
Cc: Frans Ketelaars <ketelaars@wanadoo.nl>, Richard Lemon <richard@clinicdesign.com.au>, Toby Haynes <thaynes@sympatico.ca>
List-Id: alsa-devel@alsa-project.org

au8820 working with alsa-driver-0.9.8 (and utils, tools oss and lib)

With thanks to Richard Lemon and Toby Haynes (from Openvortex list) I now
have alsa-***-0.9.8 working and sound from my aureal 8820 Turtle Beach
Montego under Mandrake 9.1 on a clone pentium ii 450 box with 128 meg Ram
originally bought with windows98 about 4 years ago - Mandrake is installed
on my old 10gb drive while windows and 4 years of data lives on a new 80gb
drive.

I have posted the following to http://www.linuxquestions.org/questions/ in
reply to a post entitled: SuSE 8.2 and Turtle Beach sound
to try and help someone else and it summarises how I got there.

I hope it will be helpful to others.

Cheers and thanks again and also to Eric Hathaway and all who worked on the
alsa drivers and the au8820 page at
http://alsa.opensrc.org/index.php?page=au88x0

Paul

Two posts read both before starting:
First post (Second one follows below it after a row of ***)

make sure the kernel-source is installed before you start eg:
[root@localhost alsa-utils-0.9.8]# urpmi kernel-source

If you don't have permission type su (to login as a Super User)

Read this first so you can make the relevant changes based on the patch when
it appears to fail:
http://www.mail-archive.com/alsa-de...list.html#09813
The changes are made in the file mentioned in the top of each section and
the changes are the addition of the lines marked with a +

Read the directions at:
http://alsa.opensrc.org/index.php?page=au88x0 and others linked but
particularly
http://alsa.opensrc.org/index.php?p...ll+-+snd-au88x0
but note that you probably won't have the files in a different location than
a downloads directory in the same path as in the example, so you will have
to make some adjustments.

http://alsa-project.org and download the files versions 0.9.8 there are 4 or
5 different files driver, lib, oss, utils, tools. They are all tar.bz2

Use the Quick install directions above. The drivers file takes about 30 mins
to do make on my 400mHz pii400.

Check whether you need to make the changes suggested in the patch mentioned
in the post referred to above.

Even after all this I end up with a failure during the modprobe stage
because of:
unresolved symbol snd_verbose_printk

I am trying to get answers to this from the alsa-devel lists at:
http://www.alsa-project.org/mailing-lists.php3
You might like to view the archives or search the lists. The alsa-user list
also has some posts with the same problem I am having.

The only other post I have seen that suggests that a solution has worked to
unresolved symbols issues is:
http://lists.debian.org/debian-user...6/msg04413.html

You can try www.google.com with a search for your problem eg:
unresolved symbol snd_verbose_printk
and that may turn up a solution.

You might be luckier than me because clearly some people are having success
with the new alsa drivers.

Good luck
Paul

**************
Second Post:

Mine works fine now, so it can be done!

The exact reference to the Quick install instructions referred to in my
earlier post is:
http://alsa.opensrc.org/index.php?p...ll+-+snd-au88x0

After I had everything working (having checked using lsmod from the command
line as su to see that snd-au8820 was in the list) I still had some problems
with sound stopping working and kmix having a blank screen. These problems
were solved when I followed the directions at:
http://alsa.opensrc.org/index.php?p...dules.conf+file

My reference to the page:
http://www.mail-archive.com/alsa-de...list.html#09813
should also have added that the post you need to read is:
[Alsa-devel] aureal driver compile problem and patch
From: Carolyn and Eric Hathaway <10/30/2003>
This tells you how to solve problems caused by different compiler versions
having been used compared to what your distro has installed eg gcc2 vs gcc3
and how to patch various makefiles to avoid some unresolved symbol problems.

Don't forget you have to configure before you make.

My problem with:
unresolved symbol snd_verbose_printk
was solved by using a different configure line someone suggested:
./configure --with-isapnp=no --with-cards=au8820 --with-sequencer=yes --with
-oss=yes --disable-verbose-printk

1 Download all alsa-***- 0.9.8 tar.bz2 files into a new directory. If you
want to exactly follow the Quick install instructions above it needs to be
in the same place as his Downloads directory in the example
2 unzip
3 make Hathaway's suggested changes re gcc2 > gcc3 and patch makefiles as
suggested
4 run the configure suggested above (modified for your system if necessary)
while in the driver unzipped directory
5 follow the Quick Install directions remembering that you *may have to
./configure *some of the others (utils, tools, oss) first as well - I just
tried them all.
6 follow the directions re the modules.conf file
7 check that the snd-au8820 module has loaded by doing lsmod from the
command line
7 open alsamixergui and unmute and increase volumes of the master and
relevant others
8 try it all out and repost if you still have problems

Hope this gets you there
cheers
Paul






----- Original Message ----- 
From: "Frans Ketelaars" <ketelaars@wanadoo.nl>
To: "Paul Hanly (Hotmail)" <paulhanly@hotmail.com>
Sent: Wednesday, November 12, 2003 1:59 AM
Subject: Re: [Alsa-devel] unresolved symbol snd_verbose_printk with
alsa-driver-0.9.8 (also with 0.9.7c)


> On Tuesday 11 November 2003 03:47, Paul Hanly (Hotmail) wrote:
> > unresolved symbol snd_verbose_printk with alsa-driver-0.9.8 (also
> > with 0.9.7c)
> >
> > System Background:
> > My system is a recently installed Mandrake Linux 9.1 with
> > kernel-sources installed. I am trying ALSA to get sound from a Vortex
> > au8820.
> > I am a noobie but posting here because this is where other messages
> > about similar problems are in the archives. I am happy to provide
> > other info as requested, but will have some delays - I am trying
> > Mandrake on a wintel 486 about 3 years old but with linux on a
> > separate drive. I have lots of problems with unsupported devices such
> > as camera, scanner, winmodem (trying Linuxant and can dial but not
> > connect yet).
>
> Perhaps you will have better hardware support in Mandrake 9.2 (
> http://www.mandrakelinux.com/en/ ) but note this:
>
> October 24th, 2003 - Important notice! - Several users have reported a
> big issue with LG Cd-rom drives used with Mandrake Linux 9.2: these
> CD-rom drives are not compliant with ATAPI specification and therefore
> can be damaged. All details, future updates and possible fix related to
> this issue are available at this page. Other Cd-rom drives are not
> affected by this issue. Update - Nov 3rd, 2003: due to this issue, the
> release of Mandrake 9.2 public ISO images has been delayed for a few
> days.
>
> > Issue Background:
> > After Reading and following
> > http://alsa.opensrc.org/index.php?page=Quick+Install+-+snd-au88x0
> > I had the following issues.

trimmed


-------------------------------------------------------
This SF.Net email sponsored by: ApacheCon 2003,
16-19 November in Las Vegas. Learn firsthand the latest
developments in Apache, PHP, Perl, XML, Java, MySQL,
WebDAV, and more! http://www.apachecon.com/
