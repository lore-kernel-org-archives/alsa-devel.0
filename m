From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: [PATCH] ASoC drivers for the Freescale MPC8610 SoC
Date: Thu, 10 Jan 2008 15:10:36 -0500
Message-ID: <9e4733910801101210w5846bb4ds38a603a489ef0522@mail.gmail.com>
References: <9e4733910801010925j67192427o4e0e824b9d7e0ad0@mail.gmail.com>
	<20080106004637.GJ4326@localhost.localdomain>
	<47824AA3.5070808@freescale.com>
	<20080107182853.GA17312@sirena.org.uk>
	<20080110034919.GI17816@localhost.localdomain>
	<9e4733910801092141m5d4476d0l1c081307fd5c1969@mail.gmail.com>
	<1199961015.19903.270.camel@localhost.localdomain>
	<47863C31.50309@freescale.com>
	<fa686aa40801100801p3da98eecn44401b17fe652da8@mail.gmail.com>
	<478641E3.5070404@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from nz-out-0506.google.com (nz-out-0506.google.com [64.233.162.239])
	by alsa0.perex.cz (Postfix) with ESMTP id 82831246F2
	for <alsa-devel@alsa-project.org>; Thu, 10 Jan 2008 21:10:38 +0100 (CET)
Received: by nz-out-0506.google.com with SMTP id m22so452389nzf.2
	for <alsa-devel@alsa-project.org>; Thu, 10 Jan 2008 12:10:36 -0800 (PST)
In-Reply-To: <478641E3.5070404@freescale.com>
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
To: Timur Tabi <timur@freescale.com>
Cc: alsa-devel@alsa-project.org, Grant Likely <grant.likely@secretlab.ca>, linuxppc-dev@ozlabs.org, Olof Johansson <olof@lixom.net>, david@gibson.dropbear.id.au
List-Id: alsa-devel@alsa-project.org

On 1/10/08, Timur Tabi <timur@freescale.com> wrote:
> Grant Likely wrote:
>
> > The driver doesn't need to be 100% correct.  Drivers are easy to
> > change if they aren't quite right.  There are no long term
> > consequences.
>  >
> > However, the device tree issues must be addressed before it is merged
> > and deployed.  Otherwise we end up having to support poorly designed
> > trees over the long term.
>
> I agree.  Correct me if I'm wrong, but I think the only device tree "issue" is
> the definition of the 'codec' node under the SSI node.  If so, I'm not sure what
> other changes need to be mode.

Isn't your codec is i2c controlled? Where does the main node for the
code live, i2c bus or ssi bus? What does the link between the buses
look like for pointing to the codec entry?

What about fsl,ssi being too generic for a compatible type?

>
> --
> Timur Tabi
> Linux kernel developer at Freescale
>


-- 
Jon Smirl
jonsmirl@gmail.com
