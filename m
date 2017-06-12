From: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Subject: Re: [PATCH] topology: delete output file if parsing
 fails.
Date: Mon, 12 Jun 2017 18:44:08 +0100
Message-ID: <1497289448.30929.237.camel@loki>
References: <1497022422-5974-1-git-send-email-liam.r.girdwood@linux.intel.com>
 <s5h7f0k2nil.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by alsa0.perex.cz (Postfix) with ESMTP id 2C66A266E89
 for <alsa-devel@alsa-project.org>; Mon, 12 Jun 2017 19:44:22 +0200 (CEST)
In-Reply-To: <s5h7f0k2nil.wl-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Sat, 2017-06-10 at 11:35 +0200, Takashi Iwai wrote:
> On Fri, 09 Jun 2017 17:33:42 +0200,
> Liam Girdwood wrote:
> > 
> > Currently the binary output file is left when parsing fails. This confuses
> > GNU Make if the parsing fails and causes the compilation to partially
> > complete.
> > 
> > Signed-off-by: Liam Girdwood <liam.r.girdwood@linux.intel.com>
> 
> Applied, thanks.
> 
> But at the next time, please specify which repo to apply.
> It took some time until I figured out it's for alsa-utils.

Apologies, I was doing some alsa-lib patches at the same time. This did
make me realize we do have some other similar named areas that overlap
in the kernel and in alsa-lib, but they are probably manageable for the
moment.

Thanks

Liam
