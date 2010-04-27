From: Timur Tabi <timur@freescale.com>
Subject: Re: [PATCH 1/2] powerpc: add platform registration for
 ALSA SoC drivers
Date: Tue, 27 Apr 2010 15:05:36 -0500
Message-ID: <4BD74390.6060601@freescale.com>
References: <1272314980-23679-1-git-send-email-timur@freescale.com>
	<j2qfa686aa41004271221g18f04fbcla8b74861f87b8c84@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	by alsa0.perex.cz (Postfix) with ESMTP id 3C5C5103845
	for <alsa-devel@alsa-project.org>;
	Tue, 27 Apr 2010 22:05:38 +0200 (CEST)
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw02.freescale.net (8.14.3/az33egw02) with ESMTP id
	o3RK5bZd003423
	for <alsa-devel@alsa-project.org>; Tue, 27 Apr 2010 13:05:37 -0700 (MST)
Received: from az33exm25.fsl.freescale.net (az33exm25.am.freescale.net
	[10.64.32.16])
	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id o3RKDxI9029995
	for <alsa-devel@alsa-project.org>; Tue, 27 Apr 2010 15:13:59 -0500 (CDT)
In-Reply-To: <j2qfa686aa41004271221g18f04fbcla8b74861f87b8c84@mail.gmail.com>
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
Cc: linuxppc-dev@ozlabs.org, alsa-devel@alsa-project.org, broonie@opensource.wolfsonmicro.com, kumar.gala@freescale.com, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

Grant Likely wrote:
>> +       /* Register the platform device for the ASoC fabric driver */
>> > +       platform_device_register_simple("snd-soc-mpc8610-hpcd", 0, NULL, 0);
>> > +
> Since this is a temporary measure, this device registration is
> probably best put into the .probe() hook of the i2s driver.  That will
> keep everything contained in the same place until we can hammer out a
> reasonable binding.

This part is not temporary, I think.  The fabric driver will always be a standard platform driver, not an OF driver, because there are no DT nodes that it can probe against.  BenH is suggestion that maybe we can create one, but I'm not sure that's really the best approach.

-- 
Timur Tabi
Linux kernel developer at Freescale
