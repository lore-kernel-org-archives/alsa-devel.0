From: "Clemens Ladisch" <cladisch@fastmail.net>
Subject: Re: Unable to find an usable access for 'default'
Date: Fri, 06 Jul 2007 12:50:27 +0200
Message-ID: <1183719027.2620.1198799059@webmail.messagingengine.com>
References: <468ACB86.1040303@freescale.com>
	<1183530859.19025.1198427403@webmail.messagingengine.com>
	<468CE7AD.8020305@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out1.smtp.messagingengine.com (out1.smtp.messagingengine.com
	[66.111.4.25]) by alsa0.perex.cz (Postfix) with ESMTP id 65D1F245A4
	for <alsa-devel@alsa-project.org>;
	Fri,  6 Jul 2007 12:50:28 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <468CE7AD.8020305@freescale.com>
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
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Timur Tabi wrote:
> Clemens Ladisch wrote:
> > It means that the plug plugin (that the ALSA lib uses to automatically
> > convert between sample formats) was not able to find any combination of
> > format/rate/channels/access that would work with your hardware.
> 
> ... When you say "access", what do you mean by that?

ALSA-lib's access type specifies whether to use mmap or not, and whether
the sample are interleaved or not.  (The SNDRV_PCM_INFO_*INTERLEAVED and
SNDRV_PCM_INFO_MMAP* flags specify the capabilities of the device.)

> > It is possible that some entries in the snd_pcm_hardware struct are set
> > in an inconsistent way.  Please show the code of the driver.
> 
> I'd like to show the code, but the project is unannounced, so I can't
> yet.  Can you give me a suggestion as to what I should be looking for to
> resolve this?

Look at the values in the snd_pcm_hardware structure and at the
constraints the driver adds manually, if there are any.


HTH
Clemens
