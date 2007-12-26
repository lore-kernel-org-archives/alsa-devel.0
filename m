From: Tobin Davis <tdavis@dsl-only.net>
Subject: Re: snd-hda-intel driver on sony VGN TZ11MN
Date: Wed, 26 Dec 2007 13:11:59 -0800
Message-ID: <1198703519.3732.183.camel@razman.gruemaster.com>
References: <b7edaa10712230415q69c64e9cj56d3a4bdd444d04c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from iron2.pdx.net (iron2.pdx.net [69.64.224.71])
	by alsa0.perex.cz (Postfix) with ESMTP id 932901038EB
	for <alsa-devel@alsa-project.org>; Wed, 26 Dec 2007 22:12:01 +0100 (CET)
In-Reply-To: <b7edaa10712230415q69c64e9cj56d3a4bdd444d04c@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jonathan Coe <jonathanbcoe@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Could you also supply the sound codec information?  Type
"cat/proc/asound/card0/codec*" and look for the Codec line near the top.
With this info, I can add the necessary information to the driver,
thanks.

Tobin

On Sun, 2007-12-23 at 12:15 +0000, Jonathan Coe wrote:

> The sound appears to play using audio players but no sound comes out
> of the speakers. Plugging in headphones and removing them leads to
> sound coming out of the speakers. This behaviour can be corrected by
> passing suitable parameters to the driver module.
> 
> >From lspci:
> Subsystem: 104d:900e
> 
> Arguments added to /etc/modprobe.d/sound:
> options snd-hda-intel model=hippo
> 
> I hope this is all the information you need to get this working. If
> not please email and I'll be happy to help if I can.
> 
> kind regards,
> Jon
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

-- 
Tobin Davis <tdavis@dsl-only.net>
