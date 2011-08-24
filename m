From: Lu Guanqun <guanqun.lu@intel.com>
Subject: Re: [PATCH 2/3] ALSA: core: release the constraint
 check for replace ops
Date: Wed, 24 Aug 2011 14:08:54 +0800
Message-ID: <20110824060854.GE3551@guanqun-laptop.sh.intel.com>
References: <20110824031234.5279.46501.stgit@localhost6.localdomain6>
	<20110824031239.5279.97696.stgit@localhost6.localdomain6>
	<s5hzkizpcuz.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
	by alsa0.perex.cz (Postfix) with ESMTP id E47DB103833
	for <alsa-devel@alsa-project.org>;
	Wed, 24 Aug 2011 08:08:54 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <s5hzkizpcuz.wl%tiwai@suse.de>
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
Cc: ALSA <alsa-devel@alsa-project.org>, "clemens@ladisch.de" <clemens@ladisch.de>
List-Id: alsa-devel@alsa-project.org

On Wed, Aug 24, 2011 at 02:01:08PM +0800, Takashi Iwai wrote:
> At Wed, 24 Aug 2011 11:12:39 +0800,
> Lu Guanqun wrote:
> > 
> > Suppose the ALSA card already has a number of MAX_USER_CONTROLS controls, and
> > the user wants to replace one, it should not fail at this condition check.
> 
> It'd be simpler to ignore the check when replace flag is set?
> The proposed change here looks too tricky, IMO...

Agreed. I'll cook another one.

-- 
guanqun
