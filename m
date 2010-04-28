From: Timur Tabi <timur@freescale.com>
Subject: Re: [PATCH 1/2] powerpc: add platform registration for
 ALSA SoC drivers
Date: Wed, 28 Apr 2010 12:27:13 -0500
Message-ID: <4BD86FF1.1090507@freescale.com>
References: <1272314980-23679-1-git-send-email-timur@freescale.com>
	<1272350168.24542.6.camel@pasglop> <1272355624.3204.52.camel@odin>
	<g2mfa686aa41004271324g8ff0d67fi3df4336cb25e9acc@mail.gmail.com>
	<4BD74D0C.40303@freescale.com>
	<q2xfa686aa41004272237ld1ffc08fhebb55ff84b51d1c2@mail.gmail.com>
	<u2xed82fe3e1004280635vaeb792d2xf86996cac299ba2b@mail.gmail.com>
	<j2zfa686aa41004280657g49db18d9g563e643e16ca64e9@mail.gmail.com>
	<k2ped82fe3e1004280920xb1d8ef7ew34f86fd0ae67cf61@mail.gmail.com>
	<j2lfa686aa41004280947wbd8a90aeo3516475aa0987c78@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	by alsa0.perex.cz (Postfix) with ESMTP id CBB51244CF
	for <alsa-devel@alsa-project.org>;
	Wed, 28 Apr 2010 19:27:16 +0200 (CEST)
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw02.freescale.net (8.14.3/az33egw02) with ESMTP id
	o3SHREpe019460
	for <alsa-devel@alsa-project.org>; Wed, 28 Apr 2010 10:27:14 -0700 (MST)
Received: from az33exm25.fsl.freescale.net (az33exm25.am.freescale.net
	[10.64.32.16])
	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id o3SHZcno012642
	for <alsa-devel@alsa-project.org>; Wed, 28 Apr 2010 12:35:38 -0500 (CDT)
In-Reply-To: <j2lfa686aa41004280947wbd8a90aeo3516475aa0987c78@mail.gmail.com>
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
Cc: alsa-devel@alsa-project.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>, kumar.gala@freescale.com, broonie@opensource.wolfsonmicro.com, linuxppc-dev@ozlabs.org, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

Grant Likely wrote:

> Didn't you just finish saying that you cannot see any situation where
> you would want the SSI devices linked into a single audio device?  So
> then if both SSIs are being used for audio, then do you not need a
> machine driver for each ssi?

That's right.  But in order for my fabric/machine driver to be called at all, I thought I needed to make it a platform driver and use platform_device_register_simple() and platform_driver_register().

>> Are you saying that I should call platform_device_register_simple()
>> from the SSI's driver initialization function, fsl_ssi_init()?
> 
> No, I'm saying call it from the probe hook.

But then platform_device_register_simple() will be called twice, and it should be called only once. 

I must be missing something here.

> However, you should probably do a two stage platform_device_alloc() /
> platform_device_add() so you can add data (node pointer) to the
> platform device before it gets probed by the machine driver.

Don't you mean platform_device_add_resources() instead of platform_device_add()?  That is, use platform_device_add_resources() too add information about each SSI that gets probed, and then after all of the SSIs are probed, then call platform_device_add().

If that's what you mean, then where do I call platform_device_add()?

> I'm not talking about platform_data or about the ssi driver decoding
> things that the machine driver needs.  I'm talking about giving the
> machine driver a pointer to the ssi device tree node so you don't need
> to go through weird gymnastics to find the correct node again.

The only gymnastics I need to go through is this:

while ((np = of_find_compatible_node(np, NULL, "fsl,mpc8610-ssi"))) {

This finds every SSI node.  I then extract the information from the SSI nodes and all the other nodes, and then register it with ASoC. 

-- 
Timur Tabi
Linux kernel developer at Freescale
