From: "thewade" <pdman@aproximation.org>
Subject: Re: cascade error using FLTK 1.2 when building alsa-tools-hdspmixer
Date: Tue, 7 Sep 2004 09:48:12 -0600
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200409071548.i87FmCJt028214@sanctuary.aproximation.org>
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

On Tue, 7 Sep 2004, Takashi Iwai wrote:

> At Mon, 6 Sep 2004 14:54:03 -0600,
> thewade wrote:
> >
> > > At Mon, 6 Sep 2004 12:33:58 -0600,
> > > thewade wrote:
> > > >  
> > > > hello,
> > > >
> > > > I am trying to build the HDSPmixer supplied by alsa-project in
> > > > alsa-tools-1.0.6. This application uses FLTK. I tried building it $
> > > > FLTK-2.0.x but that got me nowhere. FLTK-1.2 gets me to the linker
> > > > stage but not further.
> > >
> > > The fltk lib seems missing or installed wrongly.
> > > Do you have fltk-config?  What shows \\\"fltk-config --ldflags\\\"?     
> > >
> > >
> > > Takashi
> >
> > [pdman@musicbox pdman]$ fltk-config --ldflags
> > -L/usr/local/lib -L/usr/X11R6/lib64 -lfltk -lm -lXext -lX11 -lsupc++ 
> >
> > That is as it should be, correct?
>
> /usr/local/lib is likely a wrong place.  For x86-64 binaries, use
> /usr/local/lib64.
>
> Anyway, do you have the \"correct\" libfltk.so (64bit) either in
> /usr/local/lib or /usr/X11R6/lib64?
>
>
> Takashi
>

The only fltk on my machine is the one I built, so the one in
/usr/local/lib should be 64 bit I think. Should I rebuild it with
--with-libdir=/usr/local/lib64 ?
The fltk-1.2.x config.log shows it found my machine to be of x86_64
architecture...
I seem to have lots of these compile but not link errors...
Perhaps my linker is bad? Im just using the one that came with FC3t1. I
had the same problem with FedoraCore2 though I think...

Thank you for your help!
-thewade


-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=5047&alloc_id=10808&op=click
