From: "thewade" <pdman@aproximation.org>
Subject: Re: cascade error using FLTK 1.2 when building alsa-tools-hdspmixer
Date: Mon, 6 Sep 2004 14:54:48 -0600
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200409062054.i86KsmMJ026473@sanctuary.aproximation.org>
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

> At Mon, 6 Sep 2004 12:33:58 -0600,
> thewade wrote:
> > 
> > hello,
> > 
> > I am trying to build the HDSPmixer supplied by alsa-project in 
> > alsa-tools-1.0.6. This application uses FLTK. I tried building it with
> > FLTK-2.0.x but that got me nowhere. FLTK-1.2 gets me to the linker 
> > stage but not further.
> 
> The fltk lib seems missing or installed wrongly.
> Do you have fltk-config?  What shows \"fltk-config --ldflags\"?
> 
> 
> Takashi

[pdman@musicbox pdman]$ fltk-config --ldflags
-L/usr/local/lib -L/usr/X11R6/lib64 -lfltk -lm -lXext -lX11 -lsupc++

That is as it should be, correct?

-thewade


-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=5047&alloc_id=10808&op=click
