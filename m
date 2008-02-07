From: "Andrew Paprocki" <andrew@ishiboo.com>
Subject: Re: HG vs GIT
Date: Thu, 7 Feb 2008 06:45:10 -0500
Message-ID: <76366b180802070345u705c1a72ibebb27d909028405@mail.gmail.com>
References: <Pine.LNX.4.61.0802071024530.8113@tm8103.perex-int.cz>
	<s5habmdknw0.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rv-out-0910.google.com (rv-out-0910.google.com [209.85.198.186])
	by alsa0.perex.cz (Postfix) with ESMTP id E82412458F
	for <alsa-devel@alsa-project.org>; Thu,  7 Feb 2008 12:45:11 +0100 (CET)
Received: by rv-out-0910.google.com with SMTP id k20so1946416rvb.32
	for <alsa-devel@alsa-project.org>; Thu, 07 Feb 2008 03:45:10 -0800 (PST)
In-Reply-To: <s5habmdknw0.wl%tiwai@suse.de>
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
Cc: ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Feb 7, 2008 6:27 AM, Takashi Iwai <tiwai@suse.de> wrote:
> BTW, one big annoying thing is that developers have no complete kernel
> tree to access, and thus the patches that touch outside the ALSA
> subdirectory cannot be merged easily.  People often send patches
> fixing together with OSS, etc, and I had to skip them.  So, frankly,
> I'd love to have an access to the whole kernel tree.  But, OTOH, this
> would make harder for other naive guys to give it a try because they
> need to download the big linux kernel tree git.

I was just wondering about this the other day.. I don't think using
kernel git trees would put anyone off. Anyone working on a sound card
driver would most likely already be familiar with using git w/ the
upstream kernel anyway.

My own personal alsa use is in kernels with no loadable module
support, so I can't use the standalone package to build modules
anyway. I need the code integrated into the tree and I just do it by
hand right now.

I've tinkered with libata (git) as well as alsa, and I think having it
in git makes it a bit easier when dealing with upstream updates and
merging.

-Andrew
