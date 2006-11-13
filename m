From: "Clemens Ladisch" <cladisch@fastmail.net>
Subject: Re: Intel ICH programming & ALSA driver
Date: Mon, 13 Nov 2006 09:51:34 +0100
Message-ID: <1163407894.22401.275661099@webmail.messagingengine.com>
References: <200611101225.55072.witzel.thomas@comcast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <200611101225.55072.witzel.thomas@comcast.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: witzel.thomas@comcast.net, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Thomas Witzel wrote:
> BTW, If anyone cares to help me on this one, I made the code available at:
> https://www.nmr.mgh.harvard.edu/~twitzel/rti8xx.tar.bz2

Thanks.

in function rt_i8xx_singlebuffer_bdbars():
>  /* in case the DMA is running, stop it now
>     I'm setting value to 2, so that the ich state is reset. Otherwise
>     (val = 0) would only pause the DMA
>  */
>  val = 2;
>  busmaster_putbyte(chip, chip->ichd[idx].reg_offset + ICH_REG_OFF_CR, val);

It shouldn't be necessary to reset the DMA engine here.  This code
should be moved to the chip initialization.

And if DMA is running, your code must stop it and wait for it to be
actually stopped before a reset.

After setting the reset bit, you have to wait for the reset to be
completed.

>   chip->ichd[idx].bdbar[1] = cpu_to_le32(0x80000000 | 32768/2);

You allocate a buffer having 262144 bytes.  With 32-bit samples, the
buffer has 65536 samples.  With two channels, it has 32768 frames.  With
two periods in the buffer, one period has 131072 bytes or 32768 samples
or 16384 frames.

The number of samples for this buffer list entry should be 32768.

in function rt_i8xx_interrupt():
>   /* Now at this point we could either do something about setting a new buffer,
>      or just stop the DMA.
>      For now just stop the DMA
>   */
>   val = 2;
>   busmaster_putbyte(ctx->chip, ctx->chip->ichd[1].reg_offset + ICH_REG_OFF_CR, val);

I don't think it's a good idea to reset the DMA when _any_ interrupt
occurs; this could be too early.  You could just wait for it to halt by
itself when the last buffer entry is reached, and reset the DMA when the
device is closed.

in function rt_i8xx_open():
>   mixer_putword(ctx->chip, 0x02, 0x7fff);
>   mixer_putword(ctx->chip, 0x06, 0x7fff);
>   ...

The mixer_putword() function just writes a value to a ICH's mixer
control register.  You have to wait for the write to be completed on the
AC'97 bus before you can write the next value.

>   if(global_sta & 0x100)
>     rtdm_printk("\t Primary CODEC ready\n");

Is it?

>   for(k=0; k<65536; k++)
>     iptr[k] = (65536-k)<<16+(65536);

This generates a triangle wave with a frequency of about 1.5 Hz.  Both
the codec and the analog components will filter it out.

To generate random noise, use something like this:

  unsigned int r = 22222;
  for (k = 0; k < 65536; ++k) {
    r = r * 96314165 + 907633515;
    iptr[k] = r;
  }


HTH
Clemens

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
