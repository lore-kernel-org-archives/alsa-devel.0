From: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Subject: Re: [PATCH 1/2] ASoC: Intel: Rename SST trace event
 header to be less generic.
Date: Tue, 18 Feb 2014 11:24:38 +0000
Message-ID: <1392722678.2304.20.camel@loki>
References: <1392720110-4278-1-git-send-email-liam.r.girdwood@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id 1AF1426517F
 for <alsa-devel@alsa-project.org>; Tue, 18 Feb 2014 12:24:58 +0100 (CET)
In-Reply-To: <1392720110-4278-1-git-send-email-liam.r.girdwood@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Tue, 2014-02-18 at 10:41 +0000, Liam Girdwood wrote:
> The Intel audio DSP SST trace event header has been renamed from sst.h
> to intel-sst.h in order to avoid any confusion with any future
> Samoa Standard Time drivers ;)
> 

bah, I'll need to resend this one. It passed module build, but failed on
built-in (as I had built-in the driver for some other tests).

Liam 
