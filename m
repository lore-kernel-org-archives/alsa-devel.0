From: "Grant Likely" <grant.likely@secretlab.ca>
Subject: Re: [PATCH] ASoC drivers for the Freescale MPC8610 SoC
Date: Thu, 3 Jan 2008 12:13:08 -0700
Message-ID: <fa686aa40801031113od68e2a3m6cb60b8fa6f26c17@mail.gmail.com>
References: <11981089894052-git-send-email-timur@freescale.com>
	<9e4733910801010925j67192427o4e0e824b9d7e0ad0@mail.gmail.com>
	<9e4733910801010942y47e4cdbfge5e0d3e44ab96760@mail.gmail.com>
	<477BAB67.4080003@freescale.com>
	<fa686aa40801020812o471e18e6u9fe20676d320e958@mail.gmail.com>
	<477D24AA.4050804@freescale.com>
	<fa686aa40801031017n42f6fbf1nb2da5097ef13cf3c@mail.gmail.com>
	<477D2F52.7090306@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.244])
	by alsa0.perex.cz (Postfix) with ESMTP id 64827103880
	for <alsa-devel@alsa-project.org>; Thu,  3 Jan 2008 20:13:09 +0100 (CET)
Received: by an-out-0708.google.com with SMTP id c36so1457552ana.80
	for <alsa-devel@alsa-project.org>; Thu, 03 Jan 2008 11:13:08 -0800 (PST)
In-Reply-To: <477D2F52.7090306@freescale.com>
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
To: Scott Wood <scottwood@freescale.com>
Cc: linuxppc-dev@ozlabs.org, alsa-devel@alsa-project.org, Timur Tabi <timur@freescale.com>
List-Id: alsa-devel@alsa-project.org

On 1/3/08, Scott Wood <scottwood@freescale.com> wrote:
> Grant Likely wrote:
> > On 1/3/08, Timur Tabi <timur@freescale.com> wrote:
> >> Grant Likely wrote:
> >>
> >>> Why not be a child of the i2c bus with a phandle to the ssi bus?
> >> Because when I probe the SSI node, I want to know what the attached codec is.
> >>   So if anything, I would need a pointer from the SSI bus *to* the respective
> >> child on the I2C bus.
> >
> > That's fine too (it's what is done with Ethernet PHYs).  My preference
> > is the other way around, but it's not a big issue in this case.
>
> I'd just link in both directions, and let software follow it in
> whichever direction it prefers.

Gah!  Don't do that!  Then you need to maintain both directions in the
dts file.  Software is good at generating reverse mappings.  Don't put
that burden on the dts author.  (the software principle of defining
things in one place only applies here)

g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
grant.likely@secretlab.ca
(403) 399-0195
