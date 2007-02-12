From: maser rati <maseriyer@yahoo.com>
Subject: Re: Question about AT73C213.conf
Date: Sun, 11 Feb 2007 21:25:32 -0800 (PST)
Message-ID: <3548.95497.qm@web37706.mail.mud.yahoo.com>
References: <986463.63422.qm@web37709.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <986463.63422.qm@web37709.mail.mud.yahoo.com>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hello Takashi,

I was wondering if you have any suggestions regarding
the email thread below.

Appreciate your input.

Thanks.
iyer
--- maser rati <lazardo12@yahoo.com> wrote:

> Takashi,
>  
>  Thanks for your response..
>  
>  Here are the steps followed in installing the
> alsa-lib on an ARM board:  
>  
>  ALSA-lib install steps:
>  
>  [root@localhost alsa-lib-1.0.12]#
> CC=armv5l-linux-gcc ./configure --build=i386-linux
> --prefix=/board-rfs --host=armv5l-linux
> --target=armv5l-linux --enable-shared=yes
> --enable-static=no --disable-hwdep --disable-instr
> --with-headers=/board-rfs/usr/include/
>  
>  [root@localhost alsa-lib-1.0.12]# make
> TARGET_ARCH=arm 
>  
>  [root@localhost alsa-lib-1.0.12]# make
> install_root=/board-rfs prefix="/board-rfs" install
>  
>  Appreciate your input.
>  
>  -iyer
> 
> Takashi Iwai <tiwai@suse.de> wrote: At Mon, 5 Feb
> 2007 17:05:23 -0800 (PST),
> maser rati wrote:
> > 
> > Hello,
> > 
> > We are trying to get the audio chip (AT73C213)
> that comes on the AT91SAM9261-EK
> > development board working. alsa-lib and
> alsa-utils, version 1.0.12 are currently
> > installed.
> > 
> > # aplay -l shows that the audio chip is recognized
> as a playback device (and has a
> > driver).
> > # aplay -L fails; there aren't any PCM devices
> configured.
> > # alsaconf fails too.
> > 
> > We can't seem to find .conf files for any Atmel
> chips among the Alsa docs and files.
> > 
> > I assume the missing .conf file is the issue. Has
> anyone been successful with this?
> 
> Basically it should work even without the dedicated
> card's *.conf file
> as alsa-lib takes pcm/default.conf.  How did you
> install alsa-lib and
> co?
> 
> 
> Takashi
> 
>
-------------------------------------------------------------------------
> Using Tomcat but need to do more? Need to support
> web services, security?
> Get stuff done quickly with pre-integrated
> technology to make your job easier.
> Download IBM WebSphere Application Server v.1.0.1
> based on Apache Geronimo
>
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@lists.sourceforge.net
>
https://lists.sourceforge.net/lists/listinfo/alsa-devel
> 
> 
>  
> ---------------------------------
> Don't be flakey. Get Yahoo! Mail for Mobile and 
> always stay connected to friends.>
-------------------------------------------------------------------------
> Using Tomcat but need to do more? Need to support
> web services, security?
> Get stuff done quickly with pre-integrated
> technology to make your job easier.
> Download IBM WebSphere Application Server v.1.0.1
> based on Apache Geronimo
>
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642>
_______________________________________________
> Alsa-devel mailing list
> Alsa-devel@lists.sourceforge.net
>
https://lists.sourceforge.net/lists/listinfo/alsa-devel
> 



 
____________________________________________________________________________________
Have a burning question?  
Go to www.Answers.yahoo.com and get answers from real people who know.

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier.
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
