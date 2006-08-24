From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: Bug: aplay/alsa-lib problem on mips (openwrt,
 uclibc)
Date: Thu, 24 Aug 2006 14:43:56 +0200 (CEST)
Message-ID: <Pine.LNX.4.61.0608241435580.5772@tm8103-a.perex-int.cz>
References: <eciaah$qi9$1@ultimate100.geggus.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <eciaah$qi9$1@ultimate100.geggus.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Sven Geggus <sven@geggus.net>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Wed, 23 Aug 2006, Sven Geggus wrote:

> Dear alsa developers,
> 
> I almost succeeded in running alsa (1.0.11/snd-usb-audio) on openwrt (Kernel
> 2.4.32, uClibc-0.9.28). While OSS emulation is working aplay just
> generates an error:
> 
> root@(none):/# /usr/local/bin/aplay -f cd -t raw </dev/urandom 
> Playing raw data 'stdin' : Signed 16 bit Little Endian, Rate 44100
> Hz, Stereo
> aplay: set_params:1012: unable to install sw params:
> start_mode: EXPLICIT
> xrun_mode: NONE
> tstamp_mode: NONE
> period_step: 1
> sleep_min: 0
> avail_min: 0
> xfer_align: 718523216

This value looks bogus. Try compile alsa-lib with --with-debug=yes and 
try 'LIBASOUND_DEBUG=1 aplay ...other arguments...'. Perhaps, it shows 
more...

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
