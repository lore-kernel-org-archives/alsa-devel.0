From: "thewade" <pdman@aproximation.org>
Subject: Re: Alsa and hdspmixer segfault
Date: Sat, 2 Oct 2004 22:44:45 -0600
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200410030444.i934ijUa004509@sanctuary.aproximation.org>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

> > Should I rebuild fltk?
> 
> Not always, but what shows the stack trace?

I rebuilt fltk from source, then rebuilt hdspmixer.

I started with fltk-1.1.5rc2. That built but had many warnings. I
moved the libraries installed by fltk-1.1.4-1.1.fc2.dag.x86_64.rpm
and re-ran ldconfig. I then rebuilt and ran hdspmixer but had the
same error as before, line 68 in hdspmixer.cxx (see end of email).

I tried to rebuild fltk-1.2.x but it didnt build.
Then I tried fltk-2.0.x and that built fine, but hdspmixer
complained about the declaration (or lack thereof) of many items.

What should I do?
Thanks!
-thewade

hdspmixer build error with fltk-2.0.x:
hdspmixer.cxx:29:31: FL/Fl_Preferences.H: No such file or directory
In file included from HDSPMixerCard.h:30,
                 from hdspmixer.cxx:31:
HDSPMixerWindow.h:28:26: FL/Fl_Scroll.H: No such file or directory
HDSPMixerWindow.h:29:24: FL/Fl_Menu.H: No such file or directory
In file included from HDSPMixerWindow.h:48,
                 from HDSPMixerCard.h:30,
                 from hdspmixer.cxx:31:
HDSPMixerSetup.h:30:32: FL/Fl_Round_Button.H: No such file or directory
In file included from HDSPMixerWindow.h:48,
                 from HDSPMixerCard.h:30,
                 from hdspmixer.cxx:31:
HDSPMixerSetup.h:46: error: ISO C++ forbids declaration of `Fl_Round_Button\' with no type
HDSPMixerSetup.h:46: error: expected `;\' before \'*\' token
(etcetera, etcetera...)

back trace of hdspmixer and fltk-1.1.4-1.1.fc2.dag.x86_64.rpm:
#0  0x0000003092b6d075 in cb2 () from /usr/lib64/libfltk.so.1.1
#1  0x0000003092b6cc56 in innards () from /usr/lib64/libfltk.so.1.1
#2  0x0000003092b6cdf0 in fl_draw_image () from /usr/lib64/libfltk.so.1.1
#3  0x0000003092b6d34c in fl_draw_pixmap () from /usr/lib64/libfltk.so.1.1
#4  0x0000003092b6d099 in fl_draw_pixmap () from /usr/lib64/libfltk.so.1.1
#5  0x0000003092b3d37e in Fl_Group::draw_child () from /usr/lib64/libfltk.so.1.1
#6  0x00000000004126b0 in HDSPMixerIOMixer::draw (this=0x58b0a0) at HDSPMixerIOMixer.cxx:79
#7  0x0000003092b3d37e in Fl_Group::draw_child () from /usr/lib64/libfltk.so.1.1
#8  0x0000003092b3d275 in Fl_Group::draw_children () from /usr/lib64/libfltk.so.1.1
#9  0x0000003092b3d2d4 in Fl_Group::draw () from /usr/lib64/libfltk.so.1.1
#10 0x0000003092b3d37e in Fl_Group::draw_child () from /usr/lib64/libfltk.so.1.1
#11 0x0000003092b5041b in Fl_Scroll::draw_clip () from /usr/lib64/libfltk.so.1.1
#12 0x0000003092b50bb6 in Fl_Scroll::draw () from /usr/lib64/libfltk.so.1.1
#13 0x0000003092b3d37e in Fl_Group::draw_child () from /usr/lib64/libfltk.so.1.1
#14 0x0000003092b3d275 in Fl_Group::draw_children () from /usr/lib64/libfltk.so.1.1
#15 0x0000003092b3d2d4 in Fl_Group::draw () from /usr/lib64/libfltk.so.1.1
#16 0x0000003092b60dda in Fl_Window::draw () from /usr/lib64/libfltk.so.1.1
#17 0x0000003092b36f09 in Fl_Double_Window::flush () from /usr/lib64/libfltk.so.1.1
#18 0x0000003092b36e0b in Fl_Double_Window::flush () from /usr/lib64/libfltk.so.1.1
#19 0x0000003092b2af29 in Fl::flush () from /usr/lib64/libfltk.so.1.1
#20 0x0000003092b2abdd in Fl::wait () from /usr/lib64/libfltk.so.1.1
#21 0x0000003092b2acde in Fl::run () from /usr/lib64/libfltk.so.1.1
#22 0x000000000040c489 in main (argc=1, argv=0x7fbffff838) at hdspmixer.cxx:86


-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
