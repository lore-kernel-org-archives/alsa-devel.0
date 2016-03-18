From: Tomi Sarvela <tomi.p.sarvela@intel.com>
Subject: Re:
	=?utf-8?b?W0ludGVsLWdmeF0g4pyXIEZpLkNJLkJBVDogZmFp?=
	=?utf-8?q?lure_for_drm/i915/bxt=3A_Fix_off-by-one_error_in_Broxton?=
	=?utf-8?q?_PLL_IDs_=28rev3=29?=
Date: Fri, 18 Mar 2016 09:36:27 +0200
Message-ID: <4588852.AE9c5HdInh@fractal>
References: <1457977942-11772-1-git-send-email-imre.deak@intel.com>
 <1656335.ihdoht0X68@fractal> <s5hshzp6nuj.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id C14EA261293
 for <alsa-devel@alsa-project.org>; Fri, 18 Mar 2016 08:36:31 +0100 (CET)
In-Reply-To: <s5hshzp6nuj.wl-tiwai@suse.de>
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
Cc: Libin Yang <libin.yang@linux.intel.com>, imre.deak@intel.com, alsa-devel@alsa-project.org, intel-gfx@lists.freedesktop.org, Daniel Vetter <daniel@ffwll.ch>
List-Id: alsa-devel@alsa-project.org

On Thursday 17 March 2016 18:00:52 Takashi Iwai wrote:
...

> > CI_DRM_1147 git://anongit.freedesktop.org/drm-intel
> > dbbc6d276864d7b7a3a1edb04f0511153f9c3852
> > 
> > Note that drm-intel-nightly history changes, so the exact commits might
> > not be there any more.
> 
> Well, I have no internal access, so I have no idea which one succeeded
> and which one failed.
> 
> Unfortunately I can't reproduce it in my side.  A simpler unit test
> that can reliably reproduce the issue would be really appreciated...

Sorry, I was being unclear. They all fail on selected machines (ILK, SNB), 
since CI_DRM_1140.

The unit tests that hang quite reliably on first run are
igt@gem_ringfill_basic-default-s3
igt@drv_module_reload_basic
igt@kms_pipe_crc_basic@suspend-read-crc-pipe-[abc]

Tomi
