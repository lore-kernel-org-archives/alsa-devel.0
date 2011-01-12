From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: Missing patches for 2.6.38 merge?
Date: Wed, 12 Jan 2011 01:04:20 +0000
Message-ID: <1294794260.3338.486.camel@odin>
References: <s5hipxvi6rm.wl%tiwai@suse.de>
	<20110111221749.GA28212@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ww0-f65.google.com (mail-ww0-f65.google.com [74.125.82.65])
	by alsa0.perex.cz (Postfix) with ESMTP id BFA8110387E
	for <alsa-devel@alsa-project.org>; Wed, 12 Jan 2011 02:04:23 +0100 (CET)
Received: by wwb39 with SMTP id 39so15386wwb.8
	for <alsa-devel@alsa-project.org>; Tue, 11 Jan 2011 17:04:23 -0800 (PST)
In-Reply-To: <20110111221749.GA28212@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>, Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Tue, 2011-01-11 at 22:17 +0000, Mark Brown wrote:
> On Tue, Jan 11, 2011 at 08:23:41PM +0100, Takashi Iwai wrote:
> 
> > Mark, Liam, do you guys have still many pending updates?  If so, please
> > forward quickly.  Also, if a brief summary of this merge in ASoC area
> > is ready, it'd be helpful.
> 
> Big update...
> 
>  - Enhancements to multi-component from Jarkko Nikula allowing multiple
>    devices of the same type to be included in one system (and handling
>    other overlaps between devices) and support cross device DAPM. 
> 
>  - Support from Dimitris Papastamos for compressing the register cache in
>    memory using either an rbtree or LZO, giving substantial memory savings
>    on CODECs with large register maps.
> 
>  - Addition of trace points around DAPM and register I/O operation,
>    allowing very low overhead logging without interfering with the main
>    system log, useful for collecting verbose diagnostics without
>    interfering with system operation and for always enabled flight recorder
>    style tracking for intermittent problems.
> 
>  - Restructuring of the Samsung CPU support from Jassi Brar, including a
>    number of really good usability improvements.
> 
>  - New CODEC drivers for ALC5621/2/3, WM8737, WM8770 and WM8958.
> 
>  - Machine support for HP iPAQ H1940, HP t5325 thin clients and OpenRC
>    Ultimate.


 - OMAP4 improvements and preparation for full OMAP4 ABE support.

Thanks

Liam 

-- 
Freelance Developer, SlimLogic Ltd
ASoC and Voltage Regulator Maintainer.
http://www.slimlogic.co.uk
