From: Liam Girdwood <liam.r.girdwood@intel.com>
Subject: Re: [PATCH 1/2] alsabat: automation test scripts
Date: Tue, 09 Aug 2016 08:47:48 +0100
Message-ID: <1470728868.31650.4.camel@loki>
References: <1470625225-1237-1-git-send-email-focus.luo@linux.intel.com>
 <1470625225-1237-2-git-send-email-focus.luo@linux.intel.com>
 <s5hshuemn7k.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id 254B42657B1
 for <alsa-devel@alsa-project.org>; Tue,  9 Aug 2016 09:47:54 +0200 (CEST)
In-Reply-To: <s5hshuemn7k.wl-tiwai@suse.de>
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
Cc: Focus Luo <focus.luo@intel.com>, focus.luo@linux.intel.com, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Tue, 2016-08-09 at 09:10 +0200, Takashi Iwai wrote:
> On Mon, 08 Aug 2016 05:00:24 +0200,
> focus.luo@linux.intel.com wrote:
> > 
> > From: Focus Luo <focus.luo@intel.com>
> > 
> > This patch includes automated test scripts for linux audio driver
> > based on alsa-lib interface by using alsabat as test tool.
> > It supports analog and display(HDMI/DP) audio test.
> > The package needs the alsa-utils, alsa-lib installed environment.
> > 
> > Signed-off-by: Focus Luo <focus.luo@intel.com>
> 
> You need to modify Makefile.am, too.  Otherwise these contents won't
> be included in the release.
> 

Where would be a good place to install the scripts ? I think the
intention from Focus is that these are local scripts for use by devs and
not really for everyone. They could perhaps go in
${prefix}/share/alsa/abat/tests ?

Thanks

Liam


---------------------------------------------------------------------
Intel Corporation (UK) Limited
Registered No. 1134945 (England)
Registered Office: Pipers Way, Swindon SN3 1RJ
VAT No: 860 2173 47

This e-mail and any attachments may contain confidential material for
the sole use of the intended recipient(s). Any review or distribution
by others is strictly prohibited. If you are not the intended
recipient, please contact the sender and delete all copies.
