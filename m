From: Daniel Vetter <daniel.vetter@ffwll.ch>
Subject: Re: [alsa-devel] [PATCH v2] drm/i915: HDMI - Clear
 Audio Enable bit for Hot Plug unconditionally
Date: Thu, 13 Sep 2012 16:18:08 +0200
Message-ID: <CAKMK7uFBSAFXoLiE43r5AXYdbk2x5vdfFgD-4YP2RFi_axyoHw@mail.gmail.com>
References: <1347506340-2683-1-git-send-email-xingchao.wang@intel.com>
	<s5hipbie7px.wl%tiwai@suse.de>
	<CA+v+29iZRjp0ha6cFhR5o5xySQuF4Wgrd_tmiHOR=n0oM=B0Yw@mail.gmail.com>
	<s5h8vceyqd9.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <intel-gfx-bounces+gcfxdi-intel-gfx=m.gmane.org@lists.freedesktop.org>
In-Reply-To: <s5h8vceyqd9.wl%tiwai@suse.de>
List-Unsubscribe: <http://lists.freedesktop.org/mailman/options/intel-gfx>,
	<mailto:intel-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <http://lists.freedesktop.org/archives/intel-gfx>
List-Post: <mailto:intel-gfx@lists.freedesktop.org>
List-Help: <mailto:intel-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <http://lists.freedesktop.org/mailman/listinfo/intel-gfx>,
	<mailto:intel-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: intel-gfx-bounces+gcfxdi-intel-gfx=m.gmane.org@lists.freedesktop.org
Errors-To: intel-gfx-bounces+gcfxdi-intel-gfx=m.gmane.org@lists.freedesktop.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, intel-gfx@lists.freedesktop.org, stable@vger.kernel.org, michael.fu@intel.com, fengguang.wu@intel.com
List-Id: alsa-devel@alsa-project.org

On Thu, Sep 13, 2012 at 4:00 PM, Takashi Iwai <tiwai@suse.de> wrote:
> But, this makes me wonder why this patch can't go into 3.6.  It's a
> clear bug and the fix is trivial.
>
> Daniel, isn't it better to pick the fix (for 3.6) to drm-intel-fixes,
> then merge back to drm-intel-next?

Well, on a quick read-through it didn't sound serious (just a bit of
noise in dmesg and a few spurious reconfigs), and we're rather late in
the -rc cycle.
Applying this on top of -fixes will cause a conflict, so didn't looked
like I should bother. Also, I _want_ the patch for -next so that git
blame shows the commit and not some random conflicting merge.
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
+41 (0) 79 365 57 48 - http://blog.ffwll.ch
