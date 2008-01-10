From: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH v3] [POWERPC] Update MPC8610 HPCD to
	support audio drivers
Date: Thu, 10 Jan 2008 17:00:12 -0600
Message-ID: <4786A37C.2040905@freescale.com>
References: <12000050651235-git-send-email-timur@freescale.com>	<12000050664035-git-send-email-timur@freescale.com>
	<fa686aa40801101452q608907f3rf6f98a5d091d09d9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	by alsa0.perex.cz (Postfix) with ESMTP id C04132479C
	for <alsa-devel@alsa-project.org>; Fri, 11 Jan 2008 00:42:52 +0100 (CET)
In-Reply-To: <fa686aa40801101452q608907f3rf6f98a5d091d09d9@mail.gmail.com>
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
Cc: olof@lixom.net, linuxppc-dev@ozlabs.org, alsa-devel@alsa-project.org, Timur Tabi <timur@freescale.com>, david@gibson.dropbear.id.au
List-Id: alsa-devel@alsa-project.org

Grant Likely wrote:
>> +                dma@21300 {
>> +                        #address-cells = <1>;
>> +                        #size-cells = <1>;
>> +                        compatible = "fsl,mpc8610-dma", "fsl,eloplus-dma";
>> +                        cell-index = <0>;
>> +                        reg = <21300 4>; /* DMA general status register */
>> +                        ranges = <0 21100 200>;
>> +
>> +                        dma-channel@0 {
>> +                               compatible = "fsl,mpc8610-dma-channel",
>> +                                       "fsl,eloplus-dma-channel";
> 
> Nit: you probably don't need the compatible property for these channel
> nodes since they are 100% dependent on the parent for describing the
> behaviour.

The compatible property in the child nodes gives the driver the option 
of matching the channel rather than the whole thing.

-Scott
