From: Jesse Barnes <jbarnes@virtuousgeek.org>
Subject: Re: [PATCH v2] pass ELD to HDMI/DP audio driver
Date: Fri, 29 Jul 2011 13:07:59 -0700
Message-ID: <20110729130759.37aca083@jbarnes-desktop>
References: <20110629062013.GA17296@localhost>
	<20110629131013.GA10900@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <dri-devel-bounces+sf-dri-devel=m.gmane.org@lists.freedesktop.org>
In-Reply-To: <20110629131013.GA10900@localhost>
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
Cc: alsa-devel@alsa-project.org, Wang Zhenyu <zhenyu.z.wang@intel.com>, "intel-gfx@lists.freedesktop..." <intel-gfx@lists.freedesktop.org>, dri-devel@lists.freedesktop.org, Ben Skeggs <bskeggs@redhat.com>, Christopher White <c.white@pulseforce.com>, Jeremy Bush <contractfrombelow@gmail.com>, "Bossart,
	Pierre-louis" <pierre-louis.bossart@intel.com>
List-Id: alsa-devel@alsa-project.org

On Wed, 29 Jun 2011 21:10:13 +0800
Wu Fengguang <fengguang.wu@intel.com> wrote:

> Update: according to the spec, limit max a/v latencies to 500ms and
> avoid overflowing the ELD field Aud_Synch_Delay[7:0].
> 
> Thanks to Pierre for pointing this out!
> 
> btw, the drm_edid_to_eld() function reuses some code from Ben Skeggs.
> Ben, please add your Signed-off-by if the patch looks OK to you :)

Looks like this needs to be refreshed against Keith's drm-intel-next
tree (some trivial conflicts).

I tested this on a Sandy Bridge laptop I have but wasn't able to get
audio through my DP->HDMI dongle to my HDMI TV.

Does the HDMI HDA codec need any special parameters to work?

Thanks,
-- 
Jesse Barnes, Intel Open Source Technology Center
