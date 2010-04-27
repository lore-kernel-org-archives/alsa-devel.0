From: Timur Tabi <timur@freescale.com>
Subject: Re: [PATCH 1/2] powerpc: add platform registration for
	ALSA SoC	drivers
Date: Tue, 27 Apr 2010 15:53:57 -0500
Message-ID: <4BD74EE5.4020806@freescale.com>
References: <1272314980-23679-1-git-send-email-timur@freescale.com>
	<1272350168.24542.6.camel@pasglop>
	<20100427095440.GA15492@rakim.wolfsonmicro.main>
	<1272362955.24542.24.camel@pasglop>
	<j2pfa686aa41004271327v1658e33bgd170ecc9735f285b@mail.gmail.com>
	<20100427205004.GB15083@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	by alsa0.perex.cz (Postfix) with ESMTP id 344EF2435F
	for <alsa-devel@alsa-project.org>;
	Tue, 27 Apr 2010 22:53:59 +0200 (CEST)
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw02.freescale.net (8.14.3/az33egw02) with ESMTP id
	o3RKrwuZ019145
	for <alsa-devel@alsa-project.org>; Tue, 27 Apr 2010 13:53:58 -0700 (MST)
Received: from az33exm25.fsl.freescale.net (az33exm25.am.freescale.net
	[10.64.32.16])
	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id o3RL2JuH019822
	for <alsa-devel@alsa-project.org>; Tue, 27 Apr 2010 16:02:19 -0500 (CDT)
In-Reply-To: <20100427205004.GB15083@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>, kumar.gala@freescale.com, Grant Likely <grant.likely@secretlab.ca>, linuxppc-dev@ozlabs.org, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

Mark Brown wrote:
> Hrm, the only issue that's been raised upstream is multi-CODEC (there
> are one or two other things that boil down to multi-CODEC, but nothing
> else I'm aware of).  If you schedule something please announce it here,
> I believe that UDS generally has arrangements for remote participation.

Keep in mind that the phandle-type properties can accept multiple phandles.  So for instance, if I had two codecs attached to an SSI, the SSI node would look like this:

	ssi@16000 {
		compatible = "fsl,mpc8610-ssi";
		...
		codec-handle = <&cs4270_1 &cs4270_2>;
	};

-- 
Timur Tabi
Linux kernel developer at Freescale
