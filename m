From: Herton Ronaldo Krzesinski <herton@mandriva.com.br>
Subject: Re: Adapt eeepc p710 mixer for virtual master control
Date: Sat, 23 Feb 2008 17:35:22 -0300
Message-ID: <200802231735.22388.herton@mandriva.com.br>
References: <200802230157.22461.herton@mandriva.com.br>
	<s5hpruo9d2f.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from perninha.conectiva.com.br (perninha.conectiva.com.br
	[200.140.247.100])
	by alsa0.perex.cz (Postfix) with ESMTP id 6A83524459
	for <alsa-devel@alsa-project.org>; Sat, 23 Feb 2008 21:35:30 +0100 (CET)
In-Reply-To: <s5hpruo9d2f.wl%tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Em Saturday 23 February 2008 07:34:00 Takashi Iwai escreveu:
> At Sat, 23 Feb 2008 01:57:22 -0300,
> Herton Ronaldo Krzesinski wrote:
> > 
> > Adapt eeepc p710 mixer for virtual master control
> >     
> > Currently eeepc p710 mixer doesn't define any slave volume control. This
> > is incompatible with current virtual master control code, that will return
> > -ENOENT in this case.
> > 
> > Signed-off-by: Herton Ronaldo Krzesinski <herton@mandriva.com>
> 
> Thanks, applied to HG tree now.
> 
> But, the error was already fixed in the vmaster code.  No master
> volume will be created if no slaves are found.  But, this fix is
> anyway good to be more consistent.

Ah ok sorry for that, for the two patches I forgot to verify hg tree, I was
looking only in latest 2.6.25-rcX code.

> 
> 
> thanks,
> 
> Takashi
> 

--
[]'s
Herton
