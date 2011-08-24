From: Lu Guanqun <guanqun.lu@intel.com>
Subject: Re: [PATCH 3/3] ALSA: core: set kcontrol's count field
	correctly
Date: Wed, 24 Aug 2011 14:17:57 +0800
Message-ID: <20110824061757.GF3551@guanqun-laptop.sh.intel.com>
References: <20110824031234.5279.46501.stgit@localhost6.localdomain6>
	<20110824031243.5279.93859.stgit@localhost6.localdomain6>
	<s5hy5yjpclx.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	by alsa0.perex.cz (Postfix) with ESMTP id A869B24558
	for <alsa-devel@alsa-project.org>;
	Wed, 24 Aug 2011 08:17:58 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <s5hy5yjpclx.wl%tiwai@suse.de>
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

On Wed, Aug 24, 2011 at 02:06:34PM +0800, Takashi Iwai wrote:
> At Wed, 24 Aug 2011 11:12:43 +0800,
> Lu Guanqun wrote:
> > 
> > I don't see how info's owner field relates to kcontrol's count field. It should
> > assign to info's count instead.
> > 
> > Let's assume this scenario:
> > 
> > 1. user reads the control element from kernel (the owner field is set)
> > 2. user changes some values
> > 3. user issues 'SNDRV_CTL_IOCTL_ELEM_REPLACE' ioctl.
> > 
> > With the original code, 'kctl' here gets a large count number due to its
> > non-empty owner field. Therefore it fails on subsequent call snd_ctl_new().
> 
> In IOCTL_ELEM_ADD and REPLACE, count and owner struct fields have
> different meanings from others.  The count contains the array size,
> not the number of identical elements.  And the owner contains the
> number of elements to be created.  So, the current code is correct.

This sounds tricky...

in snd_ctl_elem_info():
	info->owner = pid_vnr(vd->owner->pid);
} else {
	info->owner = -1;

This is where owner of info get assigned, but it's not number of
elements to be created. I'm a bit unclear on this.

> 
> What we need is the documentation of this feature...

So my test case seems to be wrong, but how should I change it? Do I need
to clear the owner field when user space application sends down the
REPLACE ioctl?

-- 
guanqun
