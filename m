From: Ben Dooks <ben-alsa@fluff.org>
Subject: Re: [PATCH 1/3] ASoC Samsung S3C24xx I2S support.
Date: Tue, 6 Feb 2007 09:18:03 +0000
Message-ID: <20070206091802.GA14036@trinity.fluff.org>
References: <1170439399.18082.198.camel@localhost.localdomain>
	<s5h7iv0ju2p.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <s5h7iv0ju2p.wl%tiwai@suse.de>
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

On Fri, Feb 02, 2007 at 07:25:02PM +0100, Takashi Iwai wrote:
> At Fri, 02 Feb 2007 18:03:19 +0000,
> Liam Girdwood wrote:
> > 
> > diff -r 0f9c7c3b7657 soc/s3c24xx/s3c24xx-i2s.c
> > --- /dev/null	Thu Jan 01 00:00:00 1970 +0000
> > +++ b/soc/s3c24xx/s3c24xx-i2s.c	Wed Jan 31 16:43:17 2007 +0000
> (snip)
> > +static void s3c24xx_snd_txctrl(int on)
> > +{
> > +	unsigned long iisfcon;
> > +	unsigned long iiscon;
> > +	unsigned long iismod;
> 
> Should be u32.  unsigned long could be 64bit.
> 
> > +static void s3c24xx_snd_rxctrl(int on)
> > +{
> > +	unsigned long iisfcon;
> > +	unsigned long iiscon;
> > +	unsigned long iismod;
> 
> Ditto.
> > +static int s3c24xx_snd_lrsync()
> > +{
> > +	unsigned long iiscon;
> 
> Ditto.
> 
> > +	int timeout = 10000;
> > +
> > +	DBG("Entered %s\n", __FUNCTION__);
> > +
> > +	while (1) {
> > +		iiscon = readl(s3c24xx_i2s.regs + S3C2410_IISCON);
> > +		if (iiscon & S3C2410_IISCON_LRINDEX)
> > +			break;
> > +
> > +		if (--timeout < 0)
> > +			return -ETIMEDOUT;
> > +	}
> 
> How tolerant should it be?  This style of busy loop depends on the
> machine speed and isn't reliable.

The most this should wait is 1 sample period, as it is to synchronise
the left/right word clock to the system (otherwise you get randon channel
flips when the s3c24xx is the iis slave)... it may be worth using jiffies
for the timeout. 

-- 
Ben

Q:      What's a light-year?
A:      One-third less calories than a regular year.


-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier.
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
