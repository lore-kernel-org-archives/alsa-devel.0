From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: Re: [PATCH 2/5] [RFC] ALSA ASOC Support for 5912 osk
Date: Mon, 29 Sep 2008 14:08:49 +0300
Message-ID: <20080929110849.GE13245@gandalf.research.nokia.com>
References: <dfeb90390809290248h5638e275n458e80743954c0cf@mail.gmail.com>
	<20080929110419.GC27647@sirena.org.uk>
Reply-To: felipe.balbi@nokia.com
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx06.nokia.com (smtp.nokia.com [192.100.122.233])
	by alsa0.perex.cz (Postfix) with ESMTP id 58303243E5
	for <alsa-devel@alsa-project.org>;
	Mon, 29 Sep 2008 13:09:22 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20080929110419.GC27647@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ext Mark Brown <broonie@sirena.org.uk>
Cc: Jarkko Nikula <jarkko.nikula@nokia.com>, alsa-devel@alsa-project.org, Arun KS <arunks@mistralsolutions.com>, felipe.balbi@nokia.com
List-Id: alsa-devel@alsa-project.org

On Mon, Sep 29, 2008 at 12:04:22PM +0100, ext Mark Brown wrote:
> On Mon, Sep 29, 2008 at 03:18:32PM +0530, Arun KS wrote:
> > Adding ASOC machine driver for osk
> 
> This also looks good - a couple of very minor points below:
> 
> BTW, it's "ASoC" not "ASOC".
> 
> > + * osk.c  --  SoC audio for 5912 OSK
> 
> I don't know anything in particular about these boards but perhaps it
> would be a good idea to include the part number in the name in case
> someone decides it's a good idea to make an OSK for another OMAP
> variant?  Google suggests that the board is referred to as the OSK
> generally so probably not but I thought I'd better ask - though you do
> use 5192OSK as well.

yes, and they already exist. We had 2430osk as well ;-)

-- 
balbi
