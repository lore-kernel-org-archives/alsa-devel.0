From: Mark Knecht <markknecht@attbi.com>
Subject: Re: NEW hdsp 9652 problems - {WAS: alsaconf -L -
	where's Waldo?)
Date: 21 Mar 2003 11:36:50 -0800
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1048275411.11177.106.camel@Wizard>
References: <20030321190143.EFQV3545.sccrgwc04.attbi.com@mail09.voicenet.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <20030321190143.EFQV3545.sccrgwc04.attbi.com@mail09.voicenet.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Paul Davis <paul@linuxaudiosystems.com>
Cc: Alsa-Devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Fri, 2003-03-21 at 11:05, Paul Davis wrote:
> >   Well, I guess thanks then for saving the rest of my vacation Friday
> >from being a total waste of time. I took the day off to focus on getting
> >this Alsa stuff going. Now I find I cannot. Too bad for me I guess. 
> 
> mark - i'm not trying to apportion blame, but i would note that if you
> had not updated the firmware, this would not have happened. also, i
> had hoped that takashi or jaroslav would have applied the patches
> already mailed to the mailing list to CVS, but they chose not for
> various reasons.

Paul,
   I completely accept responsibility for this series of problems.
Between September and December I had an opportunity to choose what
hardware to buy. I made my choice, right or wrong. From December until
today I have waited for this hardware to really work, but it doesn't
work today. Two weeks ago, wanting to compare Linux and Windows in more
depth, and making no real progress with Linux, I pressed the button and
allowed RME's software to update my card so that I could use the best
they have to offer in Windows. It killed Linux. That was my choice, wise
or not.

   On the positive side, I must tell people that Linux kicks but. I can
run my box with Linux/Alsa/Jack, doing recording, or playing CDs, at sub
3mS latencies. I've pushed it down to 1.2mS and it's not failed, but I
think it might. The same box, running Win XP, cannot do better than 12mS
and seems to work better at 23mS. Guess which one I'd rather be using
when I use soft synths live?

   This issue is not your fault, nor your responsility to fix. You are
quite busy with two very important projects, Jack and Ardour. You don't
need to become a focal point for developing specifc drivers. I don't
expect it of you.

   I have come to understand just how much Alsa support is on a very
adhoc basis. It is not possible, I think, for any user like myself to
depend on a specific piece of hardware having support, or really knowing
when any piece of hardware will _ever_ be supported. I've also come to
find out just how much Alsa and Jack are still at the point of changing
protocols. This causes things to break. Beyond that, there is a general
sense that if developers want to change things and cause stuff to break,
then users should just put up with it, or learn to compile kernels, or
spend their time reading web sites to find solutions for problems that
didn't exist the day before. I don't think that works very well, but I
have no power to influence the outcome of you or anyone else in the
development community when you press your buttons.

   The unfortunate part of this adventure into Linuxland is that 6
months has gone by and I have barely written music. This is not what I
want, nor the way I'm willing to spend my time. 

   Will this machine ever work in the future? I don't know, but I hope
so. In the meantime I have a shiny new Athlon XP 2600+, 512MB of PC2700
DRAM, RME HDSP 9652 and a disk drive that's doing 45-50MB/Sec sitting
here doing nothing but fetchmail.

Cheers,
Mark


> 
> i use my H-DSP almost every day, and it works without problems for
> most things (you know most of the issues). the problems you have had
> are unfortunate, and i regret them, but unfortunately i do not have
> write access to ALSA CVS (i'm not sure i want it), and trying to
> support the very confusing situation that RME have created with the
> H-DSP has been hard to do (2 PCI rev numbers, 2 incompatible ROM-based
> firmware versions, 2 versions of the driver-loaded "firmware", plus
> the hdsp-9652 which is "a lot" like the h-dsp but has no driver-loaded
> firmware and different register access rules .... sigh).
> 
> i believe that my work and now thomas's will be available very soon,
> and will make the hdsp a truly phenomenal card under linux. thomas
> also has written an almost-finished version of totalmix for linux
> (with bitmaps from RME), and that is really impressive to see
> running. 
> 
> next time you go to upgrade the firmware on anything (your BIOS, a
> SCSI adapter, a sound card), its best to be sure to ask first if it
> will affect existing driver's ability to interact with the h/w.
> 
> --p
> 
> 




-------------------------------------------------------
This SF.net email is sponsored by:Crypto Challenge is now open! 
Get cracking and register here for some mind boggling fun and 
the chance of winning an Apple iPod:
http://ads.sourceforge.net/cgi-bin/redirect.pl?thaw0031en
