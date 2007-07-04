From: "Clemens Ladisch" <cladisch@fastmail.net>
Subject: Re: Unable to find an usable access for 'default'
Date: Wed, 04 Jul 2007 08:34:19 +0200
Message-ID: <1183530859.19025.1198427403@webmail.messagingengine.com>
References: <468ACB86.1040303@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out1.smtp.messagingengine.com (out1.smtp.messagingengine.com
	[66.111.4.25]) by alsa0.perex.cz (Postfix) with ESMTP id 7699110389E
	for <alsa-devel@alsa-project.org>;
	Wed,  4 Jul 2007 08:34:20 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <468ACB86.1040303@freescale.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Timur Tabi <timur@freescale.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Timur Tabi wrote:
> I'm developing a new ASOC driver, and I get this error message:
> 
> ALSA lib pcm_plug.c:729:(snd_pcm_plug_hw_refine_schange) Unable to find an usable access for 'default'
> 
> Can someone tell me what this means?

It means that the plug plugin (that the ALSA lib uses to automatically
convert between sample formats) was not able to find any combination of
format/rate/channels/access that would work with your hardware.

It is possible that some entries in the snd_pcm_hardware struct are set
in an inconsistent way.  Please show the code of the driver.

> This is on an embedded system, so I don't know if my ALSA installation is 
> correct.  Am I missing some kind of configuration file?

No, when the plug plugin being executed means that the configuration
files for this have been found.


Regards,
Clemens
