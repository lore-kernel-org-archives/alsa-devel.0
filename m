From: Daniel Jacobowitz <drow@false.org>
Subject: Re: [RFC] [Patch 1/2] Add virtual master control
Date: Wed, 30 Jan 2008 10:19:10 -0500
Message-ID: <20080130151909.GA11068@caradoc.them.org>
References: <s5hprx12x6x.wl%tiwai@suse.de> <s5hlk7p2wvm.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from nan.false.org (NaN.false.org [208.75.86.248])
	by alsa0.perex.cz (Postfix) with ESMTP id 2F2FE10389A
	for <alsa-devel@alsa-project.org>; Wed, 30 Jan 2008 16:19:13 +0100 (CET)
Received: from nan.false.org (localhost [127.0.0.1])
	by nan.false.org (Postfix) with ESMTP id 3E279983AF
	for <alsa-devel@alsa-project.org>; Wed, 30 Jan 2008 15:19:11 +0000 (GMT)
Received: from caradoc.them.org (22.svnf5.xdsl.nauticom.net [209.195.183.55])
	by nan.false.org (Postfix) with ESMTP id 21E7E9801D
	for <alsa-devel@alsa-project.org>; Wed, 30 Jan 2008 15:19:11 +0000 (GMT)
Received: from drow by caradoc.them.org with local (Exim 4.68)
	(envelope-from <drow@caradoc.them.org>) id 1JKEiU-0004Dt-2P
	for alsa-devel@alsa-project.org; Wed, 30 Jan 2008 10:19:10 -0500
Content-Disposition: inline
In-Reply-To: <s5hlk7p2wvm.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Thu, Dec 20, 2007 at 04:45:17PM +0100, Takashi Iwai wrote:
> This patch adds the virtual master control to sound core.
> 
> 
> Takashi
> 
> diff -r 1207d46e60b3 core/Kconfig
> --- a/core/Kconfig	Mon Dec 03 15:15:59 2007 +0100
> +++ b/core/Kconfig	Mon Dec 03 15:46:17 2007 +0100
> @@ -15,6 +15,9 @@ config SND_RAWMIDI
>  config SND_RAWMIDI
>  	tristate
>  	depends on SND
> +
> +config SND_VMASTER
> +	bool
>  
>  config SND_SEQUENCER
>  	tristate "Sequencer support"

When you committed this to hg, you put vmaster.c into hda instead of
core - could you explain why?  I'd like to use it with ice1724.

-- 
Daniel Jacobowitz
CodeSourcery
