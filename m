From: Alan Horstmann <gineera@aspect135.co.uk>
Subject: Scope of snd_pcm_hw_params_alloca() ?
Date: Thu, 13 Mar 2008 16:21:51 +0000
Message-ID: <200803131621.51271.gineera@aspect135.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp.talktalk.net (wmsmtp.opaltelecom.net [62.24.128.253])
	by alsa0.perex.cz (Postfix) with ESMTP id F2CA824497
	for <alsa-devel@alsa-project.org>; Thu, 13 Mar 2008 17:21:19 +0100 (CET)
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
To: ALSA devel <alsa-devel@alsa-project.org>
Cc: Takashi Iwai <tiwai@suse.de>
List-Id: alsa-devel@alsa-project.org

I've spent a couple of days pining this down.

snd_pcm_hw_params_alloca() is part of the user API -right?  But accomplished 
as a #define in pcm.h.

However if it is called inside a function, and the pointer stored for future 
use, after leaving the function the allocation seems to have gone, and 
attempting thereafter to use the pointer to access the hwparams space in 
another API function results in seg-fault.

This seems rather counter-intuitive (ie unexpected) to someone who has no 
knowledge of the inner workings, but simply uses the API; the allocation 
disappears without having been specifically free'd or released in any way.  I 
know that calling it globally gets round the problem, but certainly I could 
do without all the debug needed to discover that.

Comments?

Alan
