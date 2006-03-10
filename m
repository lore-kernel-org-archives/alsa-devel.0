From: Lee Revell <rlrevell@joe-job.com>
Subject: Re: How can I link the kernel with libgcc ?
Date: Thu, 09 Mar 2006 22:22:41 -0500
Message-ID: <1141960963.13319.116.camel@mindpipe>
References: <4410D9F0.6010707@kenati.com>
	 <200603100145.k2A1jMem005323@turing-police.cc.vt.edu>
	 <1141956362.13319.105.camel@mindpipe>  <4410EC0D.3090303@kenati.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <4410EC0D.3090303@kenati.com>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Carlos Munoz <carlos@kenati.com>
Cc: Valdis.Kletnieks@vt.edu, linux-kernel@vger.kernel.org, alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

(added alsa-devel to cc:)

On Thu, 2006-03-09 at 19:01 -0800, Carlos Munoz wrote:
> >Audio drivers should never have to directly manipulate the samples -
> >they just manage the DMA buffers and interrupts and wake up the process
> >at the right time.  Mixing, routing, volume control, DSP go in
> >userspace.
>
> Unfortunately, the driver needs to populate several coefficient tables 
> for the hardware to perform silence suppression and other advance 
> features. The values for these tables are calculated using log10 
> operations. I don't  see a clean way to push these operations to user 
> space without the need for custom applications that build the tables and 
> pass them to the driver.

Unless you can do it with fixed point math, or use a static table, you
might have to do just that, with a sysfs interface.  For example the
emu10k1 driver uses an ioctl interface to upload code to the built in
(floating point) DSP.  But new ioctls are frowned upon...

Lee



-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
