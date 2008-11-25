From: "Keith A. Milner" <maillist@superlative.org>
Subject: Re: Build patch failure.
Date: Tue, 25 Nov 2008 23:53:06 +0000
Message-ID: <200811252353.06825.maillist@superlative.org>
References: <200811242310.29792.maillist@superlative.org>
	<s5hd4gkr4am.wl%tiwai@suse.de> <492C62E4.1090202@audioscience.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mercury.safeukdns.net (mercury.safeukdns.net [77.92.84.1])
	by alsa0.perex.cz (Postfix) with ESMTP id 0A5681037E3
	for <alsa-devel@alsa-project.org>; Wed, 26 Nov 2008 00:53:09 +0100 (CET)
Received: from [82.152.152.239] (port=33972 helo=asmodeus.superlative.org)
	by mercury.safeukdns.net with esmtpsa (TLSv1:AES128-SHA:128)
	(Exim 4.69) (envelope-from <maillist@superlative.org>)
	id 1L57iN-0006dE-Co
	for alsa-devel@alsa-project.org; Tue, 25 Nov 2008 23:53:07 +0000
In-Reply-To: <492C62E4.1090202@audioscience.com>
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
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Tuesday 25 November 2008 20:41:08 Eliot Blennerhassett wrote:
> Hi Takashi,
>
> are the git repositories mentioned below the recommended ones, or only
> until git.alsa-project.org alsa-kmirror and alsa-driver become usable
> again?
>
> I.e. should they be listed here as the preferred ones here
> http://www.alsa-project.org/main/index.php/GIT_Server#Occasional_Developers

>
> Takashi Iwai wrote:
> > FYI, the corresponding GIT repos are:
> >     git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound-2.6.git
> >    
> > git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/alsa-driver-build.git
> >
> > Link these two repos via alsa-driver*/utils/setup-alsa-kernel script.
> > See INSTALL file in alsa-driver repo for details.

Yes, I was wondering the same thing.

The alsa-driver-build.git looks equivalent to the alsa-driver git repo, but 
the sound-2.6.get is HUGE (I've not finished downloading it yet so I don't 
know if it's equivalent to kmirror but I suepct it isnt.

On another note, I see the alsa-driver/INSTALL file still refers to the 
Mercurial repository. Does this need to be rewritten for git?

Cheers,

-- 
Keith A. Milner
