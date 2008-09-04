From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: how to convert stereo capture to mono stream
 (hardware incompatibility)
Date: Thu, 04 Sep 2008 12:58:16 +0200
Message-ID: <48BFBF48.9060306@ladisch.de>
References: <AAE526C2-EE39-474B-B9E4-683E62B34D33@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out3.smtp.messagingengine.com (out3.smtp.messagingengine.com
	[66.111.4.27]) by alsa0.perex.cz (Postfix) with ESMTP id CC81B24371
	for <alsa-devel@alsa-project.org>;
	Thu,  4 Sep 2008 12:58:14 +0200 (CEST)
In-Reply-To: <AAE526C2-EE39-474B-B9E4-683E62B34D33@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: brunal <brunal2496@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

brunal wrote:
> There is an implementation of alsa in Julius, but I can't make it
> working with my USB sound card, because when alsa tries to set
> channel capture to 1, I get an error from alsa. Here is the code :
>
>   /* set number of channels */
>    if ((err = snd_pcm_hw_params_set_channels(handle, hwparams, 1)) < 0) {
>      jlog("Error: adin_alsa: cannot set PCM channel to %d (%s)\n", 1, snd_strerror(err));
>      return(FALSE);
>    }
> Which always return FALSE.

I'd guess this program uses a wrong device name.  Make sure that the
default device name is "default", which can automatically convert sample
formats not supported by the hardware, and not "hw".


HTH
Clemens
