From: Mark Knecht <markknecht@gmail.com>
Subject: Re: hdspmixer segfaults on AMD64
Date: Fri, 2 Sep 2005 17:25:29 -0700
Message-ID: <5bdc1c8b050902172552be43d1@mail.gmail.com>
References: <5bdc1c8b050902153359513ac2@mail.gmail.com>
	 <1125706745.4991.25.camel@mindpipe>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <1125706745.4991.25.camel@mindpipe>
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
To: Lee Revell <rlrevell@joe-job.com>
Cc: alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Hi Lee,
   I downloaded alsa-tools-1.0.10-rc1 and built just the hdspmixer app
from that tarball. Same segfault. I have a fairly useless (I think)
back trace. I haven't figured out how to get good symbols. (I'm not a
programmer - sorry!)

Here's what I have so far, the important point being that it segfaults
exactly like the one in 1.0.9.

Thanks,
Mark

 Initializing default presets

Program received signal SIGSEGV, Segmentation fault.
[Switching to Thread 46912520541712 (LWP 2771)]
0x00002aaaab01a52b in fl_measure_pixmap () from
/usr/lib64/fltk-1.1/libfltk.so.1.1
(gdb) bt full
#0  0x00002aaaab01a52b in fl_measure_pixmap () from
/usr/lib64/fltk-1.1/libfltk.so.1.1
No symbol table info available.
#1  0x00002aaaab019d77 in fl_measure () from /usr/lib64/fltk-1.1/libfltk.so=
.1.1
No symbol table info available.
#2  0x00002aaaab01a2b0 in fl_draw_image () from
/usr/lib64/fltk-1.1/libfltk.so.1.1
No symbol table info available.
#3  0x00002aaaab01a894 in fl_draw_pixmap () from
/usr/lib64/fltk-1.1/libfltk.so.1.1
No symbol table info available.
#4  0x00002aaaaafe8538 in Fl_Group::draw_child () from
/usr/lib64/fltk-1.1/libfltk.so.1.1
No symbol table info available.
#5  0x0000000000412600 in HDSPMixerIOMixer::draw (this=3D0x586f60) at
HDSPMixerIOMixer.cxx:79
        i =3D 3
#6  0x00002aaaaafe8538 in Fl_Group::draw_child () from
/usr/lib64/fltk-1.1/libfltk.so.1.1
No symbol table info available.
#7  0x00002aaaaafe866a in Fl_Group::draw_children () from
/usr/lib64/fltk-1.1/libfltk.so.1.1
No symbol table info available.
#8  0x00002aaaaafe8538 in Fl_Group::draw_child () from
/usr/lib64/fltk-1.1/libfltk.so.1.1
No symbol table info available.
#9  0x00002aaaaaffc167 in Fl_Scroll::draw_clip () from
/usr/lib64/fltk-1.1/libfltk.so.1.1
No symbol table info available.
#10 0x00002aaaaaffc900 in Fl_Scroll::draw () from
/usr/lib64/fltk-1.1/libfltk.so.1.1
No symbol table info available.
#11 0x00002aaaaafe8538 in Fl_Group::draw_child () from
/usr/lib64/fltk-1.1/libfltk.so.1.1
No symbol table info available.
#12 0x00002aaaaafe866a in Fl_Group::draw_children () from
/usr/lib64/fltk-1.1/libfltk.so.1.1
No symbol table info available.
#13 0x00002aaaab00de1a in Fl_Window::draw () from
/usr/lib64/fltk-1.1/libfltk.so.1.1
No symbol table info available.
#14 0x00002aaaaafe1d53 in Fl_Double_Window::flush () from
/usr/lib64/fltk-1.1/libfltk.so.1.1
No symbol table info available.
#15 0x00002aaaaafd517d in Fl::flush () from /usr/lib64/fltk-1.1/libfltk.so.=
1.1
No symbol table info available.
---Type <return> to continue, or q <return> to quit---
#16 0x00002aaaaafd523d in Fl::wait () from /usr/lib64/fltk-1.1/libfltk.so.1=
.1
No symbol table info available.
#17 0x00002aaaaafd53be in Fl::run () from /usr/lib64/fltk-1.1/libfltk.so.1.=
1
No symbol table info available.
#18 0x000000000040c3b9 in main (argc=3D1, argv=3D0x7ffffff6ebd8) at hdspmix=
er.cxx:86
        hdsp_cards =3D {0x577240, 0x0, 0x0}
        name =3D 0x577200 "RME Hammerfall HDSP 9652 at 0xda000000, irq 217"
        card =3D -1
        cards =3D 1
(gdb)

On 9/2/05, Lee Revell <rlrevell@joe-job.com> wrote:
> On Fri, 2005-09-02 at 15:33 -0700, Mark Knecht wrote:
> > Hi,
> >    I think this may possibly be fixed already but I couldn't find an
> > associated bug in Mantis. When I run hdspmixer on my AMD64 system
> > using 2.6.13-gentoo or 2.6.12-gentoo-r9 it segfaults. I'm running
> > Alsa-1.0.9 mostly:
>=20
> Try ALSA 1.0.10-rc1.
>=20
> Lee
>=20
>


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
