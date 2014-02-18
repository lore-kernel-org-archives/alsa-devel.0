From: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Subject: Re: [PATCH 000/105] Rename soc_enum.max field
Date: Tue, 18 Feb 2014 13:25:47 +0000
Message-ID: <1392729947.2304.31.camel@loki>
References: <1392722967-12472-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [143.182.124.37])
 by alsa0.perex.cz (Postfix) with ESMTP id BCAB32658A9
 for <alsa-devel@alsa-project.org>; Tue, 18 Feb 2014 14:26:17 +0100 (CET)
In-Reply-To: <1392722967-12472-1-git-send-email-tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

On Tue, 2014-02-18 at 12:29 +0100, Takashi Iwai wrote:
> Hi,
> 
> this is the first chunk of the whole patch serires, preliminary works
> for renaming the confusing field name and minor clean ups in the
> relevant places.
> 
> After this chunk, SOC_ENUM_*_DECL() macro cleanup and the actual fixes
> for the wrong number of enum items will follow.
> 
> Then introduce SOC_ENUM_SINGLE_CONST() & co for omitting the explicit
> ARRAY_SIZE() call, and apply it in the later patches.

I've had a quick look at all patches and all :-

Acked-by: Liam Girdwood <liam.r.girdwood@linux.intel.com>

Mark, you can leave out my Ack if it's going to be a PITA to add it due
to number of patches.

Liam
