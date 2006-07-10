From: Luca Abeni <lucabe72@email.it>
Subject: Re: Problems with osprey 230 and snd-bt87x
Date: Mon, 10 Jul 2006 15:27:37 +0200
Message-ID: <1152538057.1009.43.camel@labeni.mm.mbigroup.it>
References: <1152523026.1005.28.camel@labeni.mm.mbigroup.it>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from smtp-out2.email.it (smtp-out2.email.it [80.247.70.7])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id EA587167
	for <alsa-devel@alsa-project.org>;
	Mon, 10 Jul 2006 15:23:49 +0200 (MEST)
Received: from labeni.mm.mbigroup.it (unknown [84.233.239.122])by
	smtp-out2.email.it (Email.it) with ESMTP id 73AD71BC4A9for
	<alsa-devel@alsa-project.org>; Mon, 10 Jul 2006 15:23:40 +0200 (CEST)
In-Reply-To: <1152523026.1005.28.camel@labeni.mm.mbigroup.it>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi all,

On Mon, 2006-07-10 at 11:17 +0200, Luca Abeni wrote:
> Hi all,
> 
> I am trying to capture some audio from an osprey 230 card (using the
> snd-bt87x module), but it does not seem to work well.
[...]
> I am pretty sure that the card is not broken, because the driver
> distributed by the manufacturer (a patched version of some old
> "btaudio") is able to correctly capture analog audio.
I had a look at such patched version of btaudio, and it seems that the
osprey 230 card is handled in a different way respect to the osprey200
(which seems to be the one supported by snd-bt87x). In particular, the
patched btaudio driver has some calls to bttv_I2CWrite(), gpio_andor(),
and some other gpio_*. Such calls seem to be used to set the volume on
the osprey230. Maybe this explains why the snd-bt87x driver is not
working properly here.

I also contacted the technical support at ViewCast (the producer of
osprey230), and I've been told that "the drivers are in the midst of a
major rewrite. So, ALSA support should be available in the V4L2 drivers.
Again, I expect, but cannot guarantee, this support in the 2.6.18
kernel". Can anyone confirm that someone is working on ALSA support for
osprey230 cards? (I see that it will not be in 2.6.18, but this is not a
problem... I just want to know if there really is some ongoing work).


			Thanks,
				Luca
-- 
_____________________________________________________________________________
Copy this in your signature, if you think it is important:
                               N O    W A R ! ! !



-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
