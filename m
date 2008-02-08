From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: 1.0.16rc2 -build issues
Date: Fri, 08 Feb 2008 11:43:19 +0100
Message-ID: <47AC3247.9000703@ladisch.de>
References: <200802081006.00982.gineera@aspect135.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out4.smtp.messagingengine.com (out4.smtp.messagingengine.com
	[66.111.4.28]) by alsa0.perex.cz (Postfix) with ESMTP id 909BB24584
	for <alsa-devel@alsa-project.org>; Fri,  8 Feb 2008 11:41:29 +0100 (CET)
In-Reply-To: <200802081006.00982.gineera@aspect135.co.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Alan Horstmann <gineera@aspect135.co.uk>
Cc: Takashi Iwai <tiwai@suse.de>, ALSA devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Alan Horstmann wrote:
> I tried out yesterdays tarball hg20080207 to confirm DSP2000 Midi stuff before 
> pointing another DSP2000 user to it.  Build proceeded OK but I did notice the 
> following warnings, which I might have missed previously, or they could be 
> new.  Do you care about redefinitions?
> 
> pcm_oss.c:639:1: warning: "AFMT_S32_LE" redefined
> In file included from pcm_oss.c:43:
> /lib/modules/2.4.21-99-athlon/build/include/linux/soundcard.h:562:1: warning: 
> this is the location of the previous definition

This warnings are caused by harmless whitespace in the 2.4.x soundcard.h
file.


Regards,
Clemens
