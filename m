From: Liam Girdwood <liam.girdwood@wolfsonmicro.com>
Subject: Re: Porting ARM ALSA driver to 2.6.16 kernel
Date: Wed, 14 Jun 2006 16:13:35 +0100
Message-ID: <1150298015.25027.60.camel@localhost.localdomain>
References: <200606140830.55570.wille@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <200606140830.55570.wille@freescale.com>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: wille@freescale.com
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Wed, 2006-06-14 at 08:30 -0600, Ross Wille wrote:
> Hi,
> 
> I have an ALSA sound driver working on an ARM platform running on a 
> 2.6.10 kernel.  But when I ported this driver to the 2.6.16.19 kernel 
> it does not work.  The device nodes show up, but when I try to call any 
> of the OSS-emulation ioctls (for example, SNDCTL_DSP_SETFMT) I get a 
> -EINVAL return code from the ioctl call and a "No usable accesses" 
> error gets printed to the console.  (I do have OSS emulation enabled in 
> the kernel.)
> 

The only problem I've experienced lately with ALSA on ARM is this gcc
optimisation bug:-

http://gcc.gnu.org/bugzilla/show_bug.cgi?id=27363

This only applies to gcc 4.1.0 (it's fixed in 4.1.1) and caused the
SNDRV_PCM_FORMAT_* refinement (in sound/core/pcm_native.c) to break.

A few things to also check:-

 o Does aplay/arecord and alsamixer work (they don't use OSS
emulation) ?
 o Does the Dummy driver work ?

HTH

Liam
