From: Chris Wilson <chris@chris-wilson.co.uk>
Subject: Re: [PATCH v5] drm/i915: pass ELD to HDMI/DP audio driver
Date: Mon, 05 Sep 2011 12:04:50 +0100
Message-ID: <d08817$1bhf7j@azsmga001.ch.intel.com>
References: <20110902081428.GA19621@localhost>
	<20110903211510.GA11600@localhost>
	<aefc95$1b1bat@orsmga001.jf.intel.com>
	<20110905011400.GB24561@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <dri-devel-bounces+sf-dri-devel=m.gmane.org@lists.freedesktop.org>
In-Reply-To: <20110905011400.GB24561@localhost>
List-Unsubscribe: <http://lists.freedesktop.org/mailman/options/dri-devel>,
	<mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <http://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <http://lists.freedesktop.org/mailman/listinfo/dri-devel>,
	<mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: dri-devel-bounces+sf-dri-devel=m.gmane.org@lists.freedesktop.org
Errors-To: dri-devel-bounces+sf-dri-devel=m.gmane.org@lists.freedesktop.org
To: Wu Fengguang <fengguang.wu@intel.com>
Cc: zhenyu.z.wang@intel.com, intel-gfx@lists.freedesktop.org, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, dri-devel@lists.freedesktop.org, Ben Skeggs <bskeggs@redhat.com>, Jeremy Bush <contractfrombelow@gmail.com>, Christopher White <c.white@pulseforce.com>, michael.fu@intel.com, pierre-louis.bossart@intel.com
List-Id: alsa-devel@alsa-project.org

On Mon, 5 Sep 2011 09:14:00 +0800, Wu Fengguang <fengguang.wu@intel.com> wrote:
> On Sun, Sep 04, 2011 at 08:08:37PM +0800, Chris Wilson wrote:
> > On Sun, 4 Sep 2011 05:15:10 +0800, Wu Fengguang <fengguang.wu@intel.com> wrote:
> > This patch should be split between adding the core drm functionality to
> > build the ELD and the introduction of i915 support.
> 
> OK. I didn't do this because I was not sure if it's OK to just add the
> drm_*() functions without any code to call them..

Right, we don't introduce new interfaces without users - but it is
acceptable to say "... which will be used by i915 in a following patch" if
you want to clarify the need for the interface. It just helps to
compartmentalize the damage should we find something goes horribly wrong
later.
-Chris

-- 
Chris Wilson, Intel Open Source Technology Centre
