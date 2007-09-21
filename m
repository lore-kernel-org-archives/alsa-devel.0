From: "Clemens Ladisch" <cladisch@fastmail.net>
Subject: Re: OSS app works but aplay does not with
 SNDRV_PCM_FMTBIT_U32_LE
Date: Fri, 21 Sep 2007 08:43:25 +0200
Message-ID: <1190357005.17098.1211823659@webmail.messagingengine.com>
References: <0MKpCa-1IXhxr0egN-0007WC@mrelay.perfora.net>
	<1190184377.23573.1211414421@webmail.messagingengine.com>
	<0MKp8S-1IY1GZ25ZF-0008LO@mrelay.perfora.net>
	<1190217792.23470.1211502657@webmail.messagingengine.com>
	<0MKp8S-1IY3QT3Lfw-0008HE@mrelay.perfora.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out2.smtp.messagingengine.com (out2.smtp.messagingengine.com
	[66.111.4.26]) by alsa0.perex.cz (Postfix) with ESMTP id 4DB012412E
	for <alsa-devel@alsa-project.org>;
	Fri, 21 Sep 2007 08:43:26 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <0MKp8S-1IY3QT3Lfw-0008HE@mrelay.perfora.net>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Steve Strobel <steve.strobel@link-comm.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Steve Strobel wrote:
> At 10:03 AM 9/19/2007, Clemens Ladisch wrote:
> >Steve Strobel wrote:
> > > At 12:46 AM 9/19/2007, Clemens Ladisch wrote:
> > > > or did you create a card-specific .conf file for your controller?
> > >
> > > Not intentionally, but there might be one left over from the AD1836
> > > driver I started with (I have just been modifying that driver,
> > > planning to rename it after I get it working).  Where would I look
> > > for such a file?
> >
> >In /usr/share/alsa/cards/, with the driver name.
> 
> I don't have a file there;  that directory doesn't even exist:
> Should I have a configuration file in one of those places?  If I 
> don't, where do the default values come from?

Well, there is an alsa.conf somewhere, otherwise the utils wouldn't run.

> >Does it work when running aplay with the parameter "-D plughw"?
> 
> No.  It searches through more rules, but still says, "Sample format 
> non available".  I put a log of the console output with and without 
> "-D plughw" at <http://link-comm.com/temp/aplay-log.txt> to save
> bandwidth.

Now it says that access RW_INTERLEAVED doesn't work.
I'd really like to see the source code of the driver, especially the
snd_pcm_hardware structure.

> One thing I hadn't noticed before is the message:
> 
> ALSA lib ../../../src/pcm/pcm_params.c:2152:(snd_pcm_hw_refine_slave) Slave PCM not usable
> refine done - result = -22
> 
> Does a result code of -22 mean anything significant?

Nothing that hasn't been already been told in the error message.
-EINVAL is expected in this case.

> You wrote in an earlier message:> > snd_pcm_hw_refine()
>  > > ACCESS = 00000000ffffffffffffffff -> 0000000000000008
>  > > FORMAT = 0000000000000400 -> 0000000000000000
>  >
>  > aplay tries to set S32_LE, but the driver doesn't accept it.
> 
> I think I understand how the driver uses the snd_pcm_hardware_t 
> structure to tell ALSA what it supports, but I don't understand how 
> ALSA tries to set things in return.  I am surprised that it would try 
> to set it to a data type that the driver never said it could 
> support.

A configuration file can force a specific sample format.  Usually, only
dmix does that.


Regards,
Clemens
