From: Russell King <rmk+alsa@arm.linux.org.uk>
Subject: Re: An driver error when I using aplay!
Date: Mon, 7 Jun 2004 11:17:29 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040607111729.A23059@flint.arm.linux.org.uk>
References: <Pine.HPX.4.33n.0406070920300.6374-100000@studcom.urz.uni-halle.de> <20040607092522.29704.qmail@web15206.mail.bjs.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <20040607092522.29704.qmail@web15206.mail.bjs.yahoo.com>; from cooloney@yahoo.com.cn on Mon, Jun 07, 2004 at 05:25:22PM +0800
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Roc Wu <cooloney@yahoo.com.cn>
Cc: Clemens Ladisch <clemens@ladisch.de>, Alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Mon, Jun 07, 2004 at 05:25:22PM +0800, Roc Wu wrote:
>  --- Clemens Ladisch <clemens@ladisch.de> µÄÕýÎÄ£º>
> Roc Wu wrote:
> > > > # ./aplay -t wav -f U8 -r 22050 alarm.wav
> > > > Playing WAVE 'alarm.wav' : Unsigned 8 bit, Rate
> > 22050 Hz, Mono
> > > > ALSA lib
> > pcm_plug.c:727:(snd_pcm_plug_hw_refine_schange)
> > > > Unable to find an usable access for 'default'
> > > > aplay: set_params:832: Sample format non
> > available
> > > >
> > > > And the kernel driver will dump out the message
> > as below:
> > > > Badness in aaci_pcm_close at
> > sound/arm/aaci.c:404
> > 
> > This seems to be a bug in the sound driver.

Actually, I disagree.  It's an ALSA bug.  The warning is created if
the AACI close method is called while the DMA or IO is still running.
If DMA is still running here, we've already freed the DMA buffer, so
we're either reading from or writing to memory we don't own - which is
a major bug.

The question is therefore: why is ALSA trying to shut down and free a
device which still has DMA running?  To be more explicit, why didn't
ALSA call the trigger callback with SNDRV_PCM_TRIGGER_STOP prior to
calling the hw_free or close methods?

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core


-------------------------------------------------------
This SF.Net email is sponsored by the new InstallShield X.
>From Windows to Linux, servers to mobile, InstallShield X is the one
installation-authoring solution that does it all. Learn more and
evaluate today! http://www.installshield.com/Dev2Dev/0504
