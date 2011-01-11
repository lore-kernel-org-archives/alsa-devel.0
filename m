From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: Missing patches for 2.6.38 merge?
Date: Tue, 11 Jan 2011 22:17:49 +0000
Message-ID: <20110111221749.GA28212@opensource.wolfsonmicro.com>
References: <s5hipxvi6rm.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 6D17D24485
	for <alsa-devel@alsa-project.org>; Tue, 11 Jan 2011 23:17:51 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <s5hipxvi6rm.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Tue, Jan 11, 2011 at 08:23:41PM +0100, Takashi Iwai wrote:

> Mark, Liam, do you guys have still many pending updates?  If so, please
> forward quickly.  Also, if a brief summary of this merge in ASoC area
> is ready, it'd be helpful.

Big update...

 - Enhancements to multi-component from Jarkko Nikula allowing multiple
   devices of the same type to be included in one system (and handling
   other overlaps between devices) and support cross device DAPM. 

 - Support from Dimitris Papastamos for compressing the register cache in
   memory using either an rbtree or LZO, giving substantial memory savings
   on CODECs with large register maps.

 - Addition of trace points around DAPM and register I/O operation,
   allowing very low overhead logging without interfering with the main
   system log, useful for collecting verbose diagnostics without
   interfering with system operation and for always enabled flight recorder
   style tracking for intermittent problems.

 - Restructuring of the Samsung CPU support from Jassi Brar, including a
   number of really good usability improvements.

 - New CODEC drivers for ALC5621/2/3, WM8737, WM8770 and WM8958.

 - Machine support for HP iPAQ H1940, HP t5325 thin clients and OpenRC
   Ultimate.
