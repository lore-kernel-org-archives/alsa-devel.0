From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: alsa-lib: snd_device_name_hint() function
Date: Wed, 11 Oct 2006 16:12:21 +0200 (CEST)
Message-ID: <Pine.LNX.4.61.0610111601300.8848@tm8103.perex-int.cz>
References: <Pine.LNX.4.61.0610111323470.8848@tm8103.perex-int.cz>
	<s5hd58zkp0n.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from gate.perex.cz (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 4B24A165
	for <alsa-devel@alsa-project.org>;
	Wed, 11 Oct 2006 16:12:22 +0200 (MEST)
In-Reply-To: <s5hd58zkp0n.wl%tiwai@suse.de>
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
Cc: ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Wed, 11 Oct 2006, Takashi Iwai wrote:

> At Wed, 11 Oct 2006 13:45:53 +0200 (CEST),
> Jaroslav Kysela wrote:
> > 
> > Hi,
> > 
> > 	because no one objected against new snd_device_name_hint() 
> > function prototype (see bellow for hg URL), I commited my implementation 
> > to the hg repository.
> 
> Hmm... a bit too early to commit to the public tree, I'm afraid.
> (People can't always answer in a day after a new post -- and I even
>  didn't look at code/API closely yet.)
> But it's no big problem since it's alsa-lib not the kernel tree, we
> can play freely :)

I would like to push patches as fast as possible in the development phase. 
We can eventually revert them before 1.0.14 final.

> > http://hg.alsa-project.org/alsa-lib?cs=b4ac1aee3f07
> > 
> > 	Additions from last update:
> > 
> > 1) add hint {} section to the device definition
> >    hint.description "Description"
> >    hint.device integer
> >    hint.device_input integer
> >    hint.device_output integer
> > 2) hint 0 - disable listing of this device definition
> > 3) show device name like:
> > 
> > front:CARD=Intel,DEV=0|ALC880 Analog: Front speakers and multichannel output
> > 
> > 4) notify available direction (if possible) in comment like
> > 
> > spdif:CARD=Intel,DEV=0|ALC880 Digital {Playback}: IEC958 (S/PDIF) Output
> 
> Isn't it better to split the device name and the description to
> separate strings?

Maybe, but it does not matter. I chose one container rather than playing 
with complex structures or defining group of indexes.

> I see some problems in the descriptions shown via aplay -L:
> 
> - The description doesn't include the hardware name.
>   you get same description texts for all cards.

Yes, it makes sense to add the card's longname and device number for fine 
device identification into description. I will do.

> - All alises are shown.  For example, I get both iec958 and
>   spdif although they are identical.

Yes, but it's not easy. Probably, it should be fixed in configuration.

> - Similar problems are seen for sudrround* defintions.  They
>   show all same texts.

Configuration problem.

> - The most important one, default PCM, has no description at all. 

I forget to mention that I defined hints only for HDA hardware. I'll add 
configuration for other hardware soon.

Here's output from my HDA machine:

null
    Discard all samples (playback) or generate zero samples (capture)
front:CARD=Intel,DEV=0
    ALC880 Analog: Front speakers and multichannel output
surround40:CARD=Intel,DEV=0
    ALC880 Analog: Front speakers and multichannel output
surround41:CARD=Intel,DEV=0
    ALC880 Analog: Front speakers and multichannel output
surround50:CARD=Intel,DEV=0
    ALC880 Analog: Front speakers and multichannel output
surround51:CARD=Intel,DEV=0
    ALC880 Analog: Front speakers and multichannel output
surround71:CARD=Intel,DEV=0
    ALC880 Analog: Front speakers and multichannel output
iec958:CARD=Intel,DEV=0
    ALC880 Digital {Playback}: IEC958 (S/PDIF) Output
spdif:CARD=Intel,DEV=0
    ALC880 Digital {Playback}: IEC958 (S/PDIF) Output
default:CARD=Intel
    ALC880 Analog: Default dmix+softvol + dsnoop device
dmix:CARD=Intel
    ALC880 Analog: Direct sample mixing device
dsnoop:CARD=Intel
    ALC880 Analog: Direct sample snooping device

> My goal isn't for tools like aplay.  It's fine to show all devices for
> aplay since it's a lowlevel program and should handle in a lowlelvel
> manner.  But, for GUI programs that you can do everyhing only with
> mouse click without guess work, API should be designed to provide a
> good enough usability.  So, obviously, that's the difference we see.

I'm sorry, but a click maybe a wrong click. I agree that we need to 
describe devices to be understandable for normal users, of course.

Also, I would like to reorder devices in alsa.conf (like move default 
device as first etc.). Any objections?

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SUSE Labs

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
