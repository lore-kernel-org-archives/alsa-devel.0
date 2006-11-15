From: Tobin Davis <tdavis@dsl-only.net>
Subject: Re: S/PDIF support for Intel HDA Realtek ALC880?
Date: Tue, 14 Nov 2006 23:06:19 -0800
Message-ID: <1163574379.21193.191.camel@razman>
References: <D0623A7E119D564AA1966968BC37AE29C32ABB@srvsegbg19.space.se>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <D0623A7E119D564AA1966968BC37AE29C32ABB@srvsegbg19.space.se>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Peter Carlsson <peter.carlsson@space.se>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

It's possible that your board has been incorrectly configured as a 6
stack w/o spdif.  Here's a simple experiment:  Try loading the sound
drivers with "model=6stack-digout".  If that fixes the SPDIF output,
then great.

Also, to verify that your board is supported, could you submit the pci
subsystem ID?  Use lspci to determine what device the soundcard is, then
lspci -s <pci-id> -vn (where <pci-id> would be the pci device id, i.e.
0:1b).

Tobin

On Wed, 2006-11-15 at 06:58 +0100, Peter Carlsson wrote:
> >Hi Peter
> 
> Hello Jonathan!
> 
> Thanks for the quick response.
> 
> >> I am running Debian (testing) on a Gigabyte GA-K8N51PVMT-9
> >> motherboard with integrated Intel HDA Realtek ALC880 sound.
> >
> >I don't have ALC880 hardware - all my work has been done with 
> >the ALC260.
> >My ability to answer your question is therefore somewhat diminished.
> >
> >> htpc:~# aplay -l
> >> **** List of PLAYBACK Hardware Devices ****
> >> card 0: NVidia [HDA NVidia], device 0: ALC880 Analog [ALC880 Analog]
> >>    Subdevices: 1/1
> >>    Subdevice #0: subdevice #0
> >
> >This suggests there is only one playback device, and that would be the
> >analog interface.  Therefore by default at least it doesn't appear the
> >SPDIF interface is made available.
> >
> >Are you using any options when loading the ALSA modules or do you just
> >go with the defaults?
> 
> No options and I am using a regular kernel. Any suggestions
> what options I might add?
> 
> mythtv@htpc:~$ uname -a
> Linux htpc 2.6.16-2-k7 #1 Fri Aug 18 19:48:42 UTC 2006 i686 GNU/Linux
> 
> mythtv@htpc:~$ dpkg --list alsa-*
> Desired=Unknown/Install/Remove/Purge/Hold
> |
> Status=Not/Installed/Config-files/Unpacked/Failed-config/Half-installed
> |/ Err?=(none)/Hold/Reinst-required/X=both-problems (Status,Err:
> uppercase=bad)
> ||/ Name               Version            Description
> +++-==================-==================-==============================
> ======================
> ii  alsa-base          1.0.13-1           ALSA driver configuration
> files
> ii  alsa-oss           1.0.12-1           ALSA wrapper for OSS
> applications
> ii  alsa-utils         1.0.13-1           ALSA utilities
> 
> >I'll forward your email onto the ALSA developers mailing list for wider
> >viewing.  That way you may get some thoughts from the 
> >developers actually working on ALC880 code.
> 
> Best regards,
> Peter Carlsson
> 
> -------------------------------------------------------------------------
> Take Surveys. Earn Cash. Influence the Future of IT
> Join SourceForge.net's Techsay panel and you'll get the chance to share your
> opinions on IT & business topics through brief surveys - and earn cash
> http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/alsa-devel
-- 
Tobin Davis <tdavis@dsl-only.net>


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
