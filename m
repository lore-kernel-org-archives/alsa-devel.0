From: Alan Horstmann <gineera@aspect135.co.uk>
Subject: Re: 1.0.16rc2 -build issues
Date: Fri, 8 Feb 2008 10:06:00 +0000
Message-ID: <200802081006.00982.gineera@aspect135.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp.talktalk.net (wmsmtp.opaltelecom.net [62.24.128.253])
	by alsa0.perex.cz (Postfix) with ESMTP id 371DF2455A
	for <alsa-devel@alsa-project.org>; Fri,  8 Feb 2008 10:44:09 +0100 (CET)
Content-Disposition: inline
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
Cc: ALSA devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hi Takashi,

I tried out yesterdays tarball hg20080207 to confirm DSP2000 Midi stuff before 
pointing another DSP2000 user to it.  Build proceeded OK but I did notice the 
following warnings, which I might have missed previously, or they could be 
new.  Do you care about redefinitions?

pcm_oss.c:639:1: warning: "AFMT_S32_LE" redefined
In file included from pcm_oss.c:43:
/lib/modules/2.4.21-99-athlon/build/include/linux/soundcard.h:562:1: warning: 
this is the location of the previous definition
pcm_oss.c:640:1: warning: "AFMT_S32_BE" redefined
/lib/modules/2.4.21-99-athlon/build/include/linux/soundcard.h:563:1: warning: 
this is the location of the previous definition
pcm_oss.c:641:1: warning: "AFMT_S24_LE" redefined
/lib/modules/2.4.21-99-athlon/build/include/linux/soundcard.h:558:1: warning: 
this is the location of the previous definition
pcm_oss.c:642:1: warning: "AFMT_S24_BE" redefined
/lib/modules/2.4.21-99-athlon/build/include/linux/soundcard.h:559:1: warning: 
this is the location of the previous definition

Regards

Alan
