From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH] alsa/soc: add locking to mpc5200-psc-ac97
	driver
Date: Tue, 30 Jun 2009 10:50:34 -0600
Message-ID: <fa686aa40906300950m15b7d48av953c0c738f6bf0e7@mail.gmail.com>
References: <20090629234214.12670.9082.stgit@localhost.localdomain>
	<20090630061847.GA24164@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-px0-f200.google.com (mail-px0-f200.google.com
	[209.85.216.200])
	by alsa0.perex.cz (Postfix) with ESMTP id AE935103860
	for <alsa-devel@alsa-project.org>;
	Tue, 30 Jun 2009 18:50:56 +0200 (CEST)
Received: by pxi38 with SMTP id 38so234492pxi.16
	for <alsa-devel@alsa-project.org>; Tue, 30 Jun 2009 09:50:54 -0700 (PDT)
In-Reply-To: <20090630061847.GA24164@pengutronix.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Wolfram Sang <w.sang@pengutronix.de>
Cc: linuxppc-dev@ozlabs.org, alsa-devel@alsa-project.org, broonie@sirena.org.uk
List-Id: alsa-devel@alsa-project.org

On Tue, Jun 30, 2009 at 12:18 AM, Wolfram Sang<w.sang@pengutronix.de> wrote:
>> +
>> + =A0 =A0 /* Force clear the data valid bit */
>> + =A0 =A0 in_be32(&psc_dma->psc_regs->ac97_data);
>> +
>
> No mutex involved here. I think this is either a seperate patch or it nee=
ds at
> least to be mentioned in the patch description.

Oops, that was sloppy.  Yes, I'll put this into a separate patch.  Thanks.

g.
