From: "Clemens Ladisch" <cladisch@fastmail.net>
Subject: Re: Bug: aplay/alsa-lib problem on mips (openwrt,
	uclibc)
Date: Thu, 24 Aug 2006 10:34:02 +0200
Message-ID: <1156408442.3263.269301419@webmail.messagingengine.com>
References: <eciaah$qi9$1@ultimate100.geggus.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Content-Disposition: inline
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
To: Sven Geggus <sven@geggus.net>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Sven Geggus wrote:
> I almost succeeded in running alsa (1.0.11/snd-usb-audio) on openwrt (Kernel
> 2.4.32, uClibc-0.9.28). While OSS emulation is working aplay just
> generates an error:
> 
> # /usr/local/bin/aplay -f cd -t raw </dev/urandom 
> Playing raw data 'stdin' : Signed 16 bit Little Endian, Rate 44100 Hz, Stereo
> aplay: set_params:1012: unable to install sw params:
> ...
> xfer_align: 718523216

This value is impossible.

I would guess that the kernel and alsa-lib have not been compiled with the
same compiler or compiler options, i.e., some structure layouts are
different.

Please check that sizeof(struct snd_pcm_sw_params) is the same in the kernel
and in userspace, and/or print out the values in *params in the
snd_pcm_sw_params() function in alsa-kernel/core/pcm_native.c.


HTH
Clemens

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
