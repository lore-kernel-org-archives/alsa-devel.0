From: Alan Horstmann <gineera@aspect135.co.uk>
Subject: Re: Scope of snd_pcm_hw_params_alloca() ?
Date: Fri, 14 Mar 2008 12:19:57 +0000
Message-ID: <200803141219.57453.gineera@aspect135.co.uk>
References: <200803131621.51271.gineera@aspect135.co.uk>
	<s5h63vqvaj8.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp.talktalk.net (wmsmtp.opaltelecom.net [62.24.128.253])
	by alsa0.perex.cz (Postfix) with ESMTP id E527F24649
	for <alsa-devel@alsa-project.org>; Fri, 14 Mar 2008 13:19:11 +0100 (CET)
In-Reply-To: <s5h63vqvaj8.wl%tiwai@suse.de>
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

On Thursday 13 March 2008 16:44, you wrote:
> At Thu, 13 Mar 2008 16:21:51 +0000,
>
> Alan Horstmann wrote:
> > snd_pcm_hw_params_alloca() is part of the user API -right?  But
> > accomplished as a #define in pcm.h.
>
> Because alloca can be used only with a macro due to its nature.
>
> > However if it is called inside a function, and the pointer stored for
> > future use, after leaving the function the allocation seems to have gone,
> > and attempting thereafter to use the pointer to access the hwparams space
> > in another API function results in seg-fault.

So would it be better in this case to use the malloc /free functions if 
possible?  Am I right that they are not provided in salsa, so alloca would be 
necessary to use that lib?

Alan
