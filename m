From: "thewade" <pdman@aproximation.org>
Subject: cascade error using FLTK 1.2 when building alsa-tools-hdspmixer
Date: Mon, 6 Sep 2004 12:33:58 -0600
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200409061833.i86IXw5h026235@sanctuary.aproximation.org>
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

hello,

I am trying to build the HDSPmixer supplied by alsa-project in 
alsa-tools-1.0.6. This application uses FLTK. I tried building it with FLTK-2.0.x but that got me nowhere. FLTK-1.2 gets me to the linker 
stage but not further.

I get a series of errors, most of which I can append to this email (I
forget how to redirect output to a file).

Is this some misconfiguration of my build of FLTK, a problem with
the HDSPmixer app (least likely), or some environment error on my part
(most likely).

Everything below my signature is information that will help you to figure
out if I am confused or if someting is indeed amiss.

Thank you for your help!
-thewade

AMD 64 latop running Fedora Core 3t1 and kernel 2.6.8.1

my
LD_LIBRARY_PATH=usr/lib64/qt-3.3/lib:/usr/local/lib64:/usr/local/lib:/usr/lib64:
/usr/lib

my ld.so.conf
include ld.so.conf.d/*.conf
/usr/X11R6/lib
/usr/X11R6/lib64
/usr/local/lib64
/usr/local/lib
/usr/lib64
/usr/lib

[wade@localhost hdspmixer]$ ls /usr/local/lib/libfltk*
/usr/local/lib/libfltk.a        /usr/local/lib/libfltk_images.a
/usr/local/lib/libfltk_forms.a  /usr/local/lib/libfltk_ps.a
/usr/local/lib/libfltk_gl.a

[wade@localhost hdspmixer]$ ls /usr/local/include
Fl  FL  fltk  jack  WINGs  WMaker.h  wraster.h
[wade@localhost hdspmixer]$ ls /usr/local/include/fltk/
Adjuster.h            FillSlider.h       MenuBar.h           Style.h
AlignGroup.h          Flags.h            Menu.h              StyleSet.h
ask.h                 FL_API.h           MenuWindow.h        Symbol.h
BarGroup.h            FloatInput.h       Monitor.h           TabGroup.h
Box.h                 FL_VERSION.h       MultiBrowser.h      TextBuffer.h
Browser.h             Font.h             MultiImage.h        TextDisplay.h
Button.h              forms.h            MultiLineInput.h    TextEditor.h
CheckButton.h         gl2opengl.h        MultiLineOutput.h   Threads.h
Choice.h              gl.h               NumericInput.h      ThumbWheel.h
Clock.h               glut.h             Output.h            TiledGroup.h
ColorChooser.h        GlWindow.h         PackedGroup.h       TiledImage.h
Color.h               Group.h            PopupMenu.h
ToggleButton.h
Cursor.h              HelpDialog.h       ProgressBar.h       Tooltip.h
CycleButton.h         HelpView.h         RadioButton.h       utf.h
damage.h              HighlightButton.h  RadioItem.h         Valuator.h
Dial.h                Image.h            RadioLightButton.h  ValueInput.h
dirent.h              InputBrowser.h     RepeatButton.h      ValueOutput.h
Divider.h             Input.h            ReturnButton.h      ValueSlider.h
DoubleBufferWindow.h  IntInput.h         rgbImage.h          visual.h
draw.h                InvisibleBox.h     run.h               Widget.h
error.h               ItemGroup.h        Scrollbar.h         win32.h
events.h              Item.h             ScrollGroup.h       Window.h
FileBrowser.h         LabelType.h        SecretInput.h
WordwrapInput.h
file_chooser.h        layout.h           ShapedWindow.h
WordwrapOutput.h
FileChooser.h         LightButton.h      SharedImage.h       xbmImage.h
FileIcon.h            LineDial.h         show_colormap.h     x.h
FileInput.h           load_plugin.h      Slider.h            xpmImage.h
filename.h            mac.h              string.h
FillDial.h            math.h             StringList.h

HDSPMixerMeter.o(.text+0xfa):/home/wade/alsa-tools-1.0.6/hdspmixer/src/HDSPMixer
Meter.cxx:26:
undefined reference to `Fl_Widget::window() const\'
HDSPMixerMeter.o(.text+0x20c): In function `HDSPMixerMeter::draw()\':
/usr/local/include/FL/fl_draw.H:62: undefined reference to `fl_device\'
HDSPMixerMeter.o(.text+0x236): In function `HDSPMixerMeter::draw()\':
/usr/local/include/FL/Fl_Widget.H:145: undefined reference to
`fl_draw_pixmap(char* const*, int, int, Fl_Color)\'
HDSPMixerMeter.o(.text+0x23d): In function `HDSPMixerMeter::draw()\':
/usr/local/include/FL/fl_draw.H:65: undefined reference to `fl_device\'
HDSPMixerMeter.o(.text+0x299):/usr/local/include/FL/fl_draw.H:62:
undefined reference to `fl_device\'
HDSPMixerMeter.o(.text+0x2e1): In function `HDSPMixerMeter::draw()\':
/usr/local/include/FL/Fl_Widget.H:145: undefined reference to
`fl_draw_pixmap(char* const*, int, int, Fl_Color)\'
HDSPMixerMeter.o(.text+0x2e8): In function `HDSPMixerMeter::draw()\':
/usr/local/include/FL/fl_draw.H:65: undefined reference to `fl_device\'
HDSPMixerMeter.o(.text+0x301):/usr/local/include/FL/fl_draw.H:62:
undefined reference to `fl_device\'
HDSPMixerMeter.o(.text+0x34b): In function `HDSPMixerMeter::draw()\':
/usr/local/include/FL/Fl_Widget.H:145: undefined reference to
`fl_draw_pixmap(char* const*, int, int, Fl_Color)\'
HDSPMixerMeter.o(.text+0x352): In function `HDSPMixerMeter::draw()\':
/usr/local/include/FL/fl_draw.H:65: undefined reference to `fl_device\'
HDSPMixerMeter.o(.text+0x389):/usr/local/include/FL/fl_draw.H:62:
undefined reference to `fl_device\'
HDSPMixerMeter.o(.text+0x3ac):/usr/local/include/FL/fl_draw.H:62:
undefined reference to `fl_device\'
HDSPMixerMeter.o(.text+0x40c):/usr/local/include/FL/fl_draw.H:62:
undefined reference to `fl_device\'
HDSPMixerMeter.o(.text+0x44d):/usr/local/include/FL/fl_draw.H:62:
undefined reference to `fl_device\'
HDSPMixerMeter.o(.text+0x490): In function `HDSPMixerMeter::draw()\':
/usr/local/include/FL/Fl_Widget.H:145: undefined reference to
`fl_draw_pixmap(char* const*, int, int, Fl_Color)\'
HDSPMixerMeter.o(.text+0x497): In function `HDSPMixerMeter::draw()\':
/usr/local/include/FL/fl_draw.H:65: undefined reference to `fl_device\'
HDSPMixerMeter.o(.text+0x4a4):/usr/local/include/FL/fl_draw.H:62:
undefined reference to `fl_device\'
HDSPMixerMeter.o(.text+0x7eb): In function `HDSPMixerMeter::update(int,
int, unsigned long long)\':
/home/wade/alsa-tools-1.0.6/hdspmixer/src/HDSPMixerMeter.cxx:182:
undefined reference to `Fl_Widget::redraw()\'
HDSPMixerMeter.o(.gnu.linkonce.r._ZTV14HDSPMixerMeter+0x28):/home/wade/alsa-tool
s-1.0.6/hdspmixer/src/HDSPMixerMeter.cxx:25:
undefined reference to `Fl_Widget::handle(int)\'
HDSPMixerMeter.o(.gnu.linkonce.r._ZTV14HDSPMixerMeter+0x30):/home/wade/alsa-tool
s-1.0.6/hdspmixer/src/HDSPMixerMeter.cxx:25:
undefined reference to `Fl_Widget::resize(int, int, int, int)\'
HDSPMixerMeter.o(.gnu.linkonce.r._ZTI14HDSPMixerMeter+0x10):/home/wade/alsa-tool
s-1.0.6/hdspmixer/src/HDSPMixerMeter.cxx:194:
undefined reference to `typeinfo for Fl_Widget\'
HDSPMixerMeter.o(.gnu.linkonce.t._ZN14HDSPMixerMeterD1Ev+0xc): In function
`HDSPMixerMeter::~HDSPMixerMeter()\':
/home/wade/alsa-tools-1.0.6/hdspmixer/src/HDSPMixerMeter.cxx:194:
undefined reference to `Fl_Widget::~Fl_Widget()\'
collect2: ld returned 1 exit status
make[1]: *** [hdspmixer] Error 1
make[1]: Leaving directory `/home/wade/alsa-tools-1.0.6/hdspmixer/src\'
make: *** [all-recursive] Error 1


-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=5047&alloc_id=10808&op=click
