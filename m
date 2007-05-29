From: "Ash Willis" <ashwillis@programmer.net>
Subject: Re: [PATCH] Disable debugging output for the ALS300
 driver
Date: Tue, 29 May 2007 09:09:39 -0500
Message-ID: <20070529140939.AC7931158CD@ws1-7.us4.outblaze.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from webmail-outgoing.us4.outblaze.com
	(webmail-outgoing.us4.outblaze.com [205.158.62.67])
	by alsa0.perex.cz (Postfix) with ESMTP id C03A52437E
	for <alsa-devel@alsa-project.org>;
	Tue, 29 May 2007 16:09:11 +0200 (CEST)
Received: from unknown (unknown [192.168.8.90])
	by webmail-outgoing.us4.outblaze.com (Postfix) with QMQP id
	9CB631800129
	for <alsa-devel@alsa-project.org>; Tue, 29 May 2007 14:09:44 +0000 (GMT)
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


> ----- Original Message -----
> From: "Takashi Iwai" <tiwai@suse.de>
> To: "Ash Willis" <ashwillis@programmer.net>
> Subject: Re: [alsa-devel] [PATCH] Disable debugging output for the ALS300	driver
> Date: Tue, 29 May 2007 15:08:30 +0200
> 
> 
> At Sat, 26 May 2007 13:26:35 +0000,
> Ash Willis wrote:
> >
> > Disables debugging output in the ALS300 driver.
> > Also contains a whitespace cleanup and a fix for a potential bug.
> >
> > Signed-off-by: Ash Willis <ashwillis@programmer.net>
> 
> Thanks for the patch.  It seems that your MUA breaks the embedded
> patch, so I had to apply it manually.  Could you check whether the
> latest HG is OK for you?

I'm away from home right now. I'll test it as soon as I have a chance
but it looks fine.

> 
> Also I changed "if ((err = ...))" to two individual lines, which is a
> newer standard kernel coding style.
> 

Yeah, I left that for now. I'll go through the tree and tidy up remaining
occurences of this style when I have some time.
It seems that when people add drivers to the tree, they generally copy
already existing drivers. It doesn't make much sense to be copying code
that doesn't fit CodingStyle.

Ash

=
Sports Memorabilia License Plates Signs
All license plates $6 all signs $10 all frames $8 - same day shipping - fun company and selection.
http://a8-asy.a8ww.net/a8-ads/adftrclick?redirectid=a44f49e42c5a283d05f0c963b5c2feb5
