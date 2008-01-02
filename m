From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: [PATCH] ASoC drivers for the Freescale MPC8610 SoC
Date: Wed, 2 Jan 2008 13:43:46 -0500
Message-ID: <9e4733910801021043l7571ea00o7b8072b04ca68ad5@mail.gmail.com>
References: <11981089894052-git-send-email-timur@freescale.com>
	<9e4733910801012027p4be16b92r43af773f4e5ae531@mail.gmail.com>
	<477BADF5.9060003@freescale.com>
	<9e4733910801020756p18e12ce8o618b8eae5e7c5a53@mail.gmail.com>
	<fa686aa40801020832y373c091dn925bfe64afddcb81@mail.gmail.com>
	<9e4733910801020912k50dceaebm11b59c1cee571e56@mail.gmail.com>
	<fa686aa40801020922q6fbda176l5fc7c80b5e61281f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rv-out-0910.google.com (rv-out-0910.google.com [209.85.198.186])
	by alsa0.perex.cz (Postfix) with ESMTP id 978312433A
	for <alsa-devel@alsa-project.org>; Wed,  2 Jan 2008 19:43:50 +0100 (CET)
Received: by rv-out-0910.google.com with SMTP id k20so3473894rvb.32
	for <alsa-devel@alsa-project.org>; Wed, 02 Jan 2008 10:43:46 -0800 (PST)
In-Reply-To: <fa686aa40801020922q6fbda176l5fc7c80b5e61281f@mail.gmail.com>
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
To: Grant Likely <grant.likely@secretlab.ca>
Cc: linuxppc-dev@ozlabs.org, alsa-devel@alsa-project.org, Timur Tabi <timur@freescale.com>
List-Id: alsa-devel@alsa-project.org

On 1/2/08, Grant Likely <grant.likely@secretlab.ca> wrote:
> > Alternatively, the best place for this device would be on the ASOC
> > bus, but the ASOC bus hasn't been created when the platform code runs.
> > Maybe I can figure out a place in the platform code to create this
> > device after the ASOC driver has loaded and created the bus. Does the
> > platform code get control back after loading all of the device
> > drivers?
>
> Yes, but it requires the core ASoC code to not be a module.  Then you
> can use machine_device_initcall() to register the device at a later
> time.

How about this for a simpler solution? My mpc5200-psc-ac97 and
mpc5200-psc-i2c drivers can create a device on the ASOC bus named
after the first entry in the compatible field of the root node. That
will cause the correct driver to get activated. I'm in the process of
making ASOC drivers dynamically loadable like the i2c ones.


-- 
Jon Smirl
jonsmirl@gmail.com
