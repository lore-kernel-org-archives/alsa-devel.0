From: Liam Girdwood <lg@opensource.wolfsonmicro.com>
Subject: Re: ASOC: Best way to get private data from
	machine	driver to the other drivers?
Date: Tue, 02 Oct 2007 17:37:47 +0100
Message-ID: <1191343067.12060.17.camel@localhost.localdomain>
References: <46FD6EAA.5050801@freescale.com>
	<1191236021.3318.41.camel@localhost.localdomain>
	<47016B52.1060702@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (unknown [80.75.67.54])
	by alsa0.perex.cz (Postfix) with ESMTP id 110C7243C2
	for <alsa-devel@alsa-project.org>;
	Tue,  2 Oct 2007 18:37:48 +0200 (CEST)
In-Reply-To: <47016B52.1060702@freescale.com>
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

On Mon, 2007-10-01 at 16:49 -0500, Timur Tabi wrote:
> Liam Girdwood wrote:
> 
> > Could you have a look at the V2 i.mx31 SSI driver and let me know if we
> > need further changes for better dts support.
> 
> I'm trying to port the CS4270 codec driver (it's easier) to ASOC v2, and I see 
> that you don't have snd_pcm_rate_to_rate_bit().  Where did it go?
> 

We never had a snd_pcm_rate_to_rate_bit() in the ASoC code, perhaps you
mean something else ?

Liam
