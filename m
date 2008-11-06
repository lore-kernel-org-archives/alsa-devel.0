From: Toby <dryfter@gmail.com>
Subject: Re: Creative Sound Blaster X-Fi and X-Fi Titanium
	Series Linux 32bit/64bit Driver Source released
Date: Fri, 7 Nov 2008 10:36:09 +1100
Message-ID: <8fe68c970811061536n52c6c819v58145401002555be@mail.gmail.com>
References: <5501535d0811060746y60d18e6boc8c5ad34a63fb92b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rn-out-0910.google.com (rn-out-0910.google.com [64.233.170.185])
	by alsa0.perex.cz (Postfix) with ESMTP id 02023103860
	for <alsa-devel@alsa-project.org>; Fri,  7 Nov 2008 00:36:10 +0100 (CET)
Received: by rn-out-0910.google.com with SMTP id j67so880736rne.21
	for <alsa-devel@alsa-project.org>; Thu, 06 Nov 2008 15:36:09 -0800 (PST)
In-Reply-To: <5501535d0811060746y60d18e6boc8c5ad34a63fb92b@mail.gmail.com>
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
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

2008/11/7 Bjoern Olausson <lkmlist@gmail.com>:
> Creative released a driver today....
> I am hasitating to install it.. the last one was so crappy and I just
> installed my gentoo new ;-)
>
> But it looks really like the SOURCE, so maybe it will help to pimp the
> ALSA driver (would rather see an implementation in alsa then an driver
> from Creative)

Is the new driver providing an ALSA device, or an OSS-style /dev/dsp one?

Personally I'd rather see an open-source driver make it into ALSA to
support the X-Fi, rather than relying upon Creative's terrible quality
and dreadful timeliness.

I'll try out the Creative driver on the weekend, and see if it works
where the ALSA one doesn't. (I just get loops of static from the
experimental ALSA driver.. it's like a memory ring buffer somewhere is
*meant* to be getting filled with an audio stream, but isn't - but the
card is still playing from it.)

Cheers.
Toby

-- 
Turning and turning in the widening gyre
The falcon cannot hear the falconer
Things fall apart; the center cannot hold
Mere anarchy is loosed upon the world
