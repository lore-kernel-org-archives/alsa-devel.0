From: Jon Smirl <jonsmirl@gmail.com>
Subject: Re: [PATCH] alsa/soc: add locking to mpc5200-psc-ac97
	driver
Date: Tue, 30 Jun 2009 14:33:18 -0400
Message-ID: <9e4733910906301133n4928cfc4h3ce4ee2aef53fa73@mail.gmail.com>
References: <20090629234214.12670.9082.stgit@localhost.localdomain>
	<20090630061847.GA24164@pengutronix.de>
	<fa686aa40906300950m15b7d48av953c0c738f6bf0e7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qy0-f185.google.com (mail-qy0-f185.google.com
	[209.85.221.185])
	by alsa0.perex.cz (Postfix) with ESMTP id 461E924380
	for <alsa-devel@alsa-project.org>;
	Tue, 30 Jun 2009 20:33:20 +0200 (CEST)
Received: by qyk15 with SMTP id 15so357903qyk.16
	for <alsa-devel@alsa-project.org>; Tue, 30 Jun 2009 11:33:18 -0700 (PDT)
In-Reply-To: <fa686aa40906300950m15b7d48av953c0c738f6bf0e7@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Grant Likely <grant.likely@secretlab.ca>
Cc: linuxppc-dev@ozlabs.org, alsa-devel@alsa-project.org, Wolfram Sang <w.sang@pengutronix.de>, broonie@sirena.org.uk
List-Id: alsa-devel@alsa-project.org

On Tue, Jun 30, 2009 at 12:50 PM, Grant Likely<grant.likely@secretlab.ca> w=
rote:
> On Tue, Jun 30, 2009 at 12:18 AM, Wolfram Sang<w.sang@pengutronix.de> wro=
te:
>>> +
>>> + =A0 =A0 /* Force clear the data valid bit */
>>> + =A0 =A0 in_be32(&psc_dma->psc_regs->ac97_data);
>>> +
>>
>> No mutex involved here. I think this is either a separate patch or it ne=
eds at
>> least to be mentioned in the patch description.
>
> Oops, that was sloppy. =A0Yes, I'll put this into a separate patch. =A0Th=
anks.

Now that you have added the mutexes, do you ever need to force clear
the valid bit?
Maybe log an error if this happens so that we can track down why.

-- =

Jon Smirl
jonsmirl@gmail.com
