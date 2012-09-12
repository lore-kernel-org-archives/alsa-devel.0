From: Daniel Vetter <daniel.vetter@ffwll.ch>
Subject: Re: [PATCH] drm/i915: HDMI - Clear Audio Enable bit for
	Hot Plug
Date: Wed, 12 Sep 2012 11:33:11 +0200
Message-ID: <CAKMK7uEaTbuu_VbxNVoMCD+bBjWv7C47XMFiHHP8xNLudpudiA@mail.gmail.com>
References: <1347493402-2531-1-git-send-email-xingchao.wang@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <intel-gfx-bounces+gcfxdi-intel-gfx=m.gmane.org@lists.freedesktop.org>
In-Reply-To: <1347493402-2531-1-git-send-email-xingchao.wang@intel.com>
List-Unsubscribe: <http://lists.freedesktop.org/mailman/options/intel-gfx>,
	<mailto:intel-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <http://lists.freedesktop.org/archives/intel-gfx>
List-Post: <mailto:intel-gfx@lists.freedesktop.org>
List-Help: <mailto:intel-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <http://lists.freedesktop.org/mailman/listinfo/intel-gfx>,
	<mailto:intel-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: intel-gfx-bounces+gcfxdi-intel-gfx=m.gmane.org@lists.freedesktop.org
Errors-To: intel-gfx-bounces+gcfxdi-intel-gfx=m.gmane.org@lists.freedesktop.org
To: Wang Xingchao <xingchao.wang@intel.com>
Cc: alsa-devel@alsa-project.org, tiwai@suse.de, intel-gfx@lists.freedesktop.org, michael.fu@intel.com, fengguang.wu@intel.com
List-Id: alsa-devel@alsa-project.org

On Thu, Sep 13, 2012 at 1:43 AM, Wang Xingchao <xingchao.wang@intel.com> wrote:
> Clear Audio Enable bit to trigger unsolicated event to notify Audio
> Driver part the HDMI hot plug change. The patch fixed the bug when
> remove HDMI cable the bit was not cleared correctly.
>
> In intel_hdmi_dpms(), if intel_hdmi->has_audio been true, the "Audio enable bit" will
> be set to trigger unsolicated event to notify Alsa driver the change.
>
> intel_hdmi->has_audio will be reset to false from intel_hdmi_detect() after
> remove the hdmi cable, here's debug log:
>
> [  187.494153] [drm:output_poll_execute], [CONNECTOR:17:HDMI-A-1] status updated from 1 to 2
> [  187.525349] [drm:intel_hdmi_detect], HDMI: has_audio = 0
>
> so when comes back to intel_hdmi_dpms(), the "Audio enable bit" will not be cleared. And this
> cause the eld infomation and pin presence doesnot update accordingly in alsa driver side.
>
> This patch will also trigger unsolicated event to alsa driver to notify the hot plug event:
>
> [  187.853159] ALSA sound/pci/hda/patch_hdmi.c:772 HDMI hot plug event: Codec=3 Pin=5 Presence_Detect=0 ELD_Valid=1
> [  187.853268] ALSA sound/pci/hda/patch_hdmi.c:990 HDMI status: Codec=3 Pin=5 Presence_Detect=0 ELD_Valid=0
>
>
> Signed-off-by: Wang Xingchao <xingchao.wang@intel.com>

Can you please rebase this onto latest drm-intel-next? Things move
around quite a bit, I guess the best approach is to just
unconditionally clear the audio bit in intel_disable_hdmi (new
function in drm-intel-next).

Thanks, Daniel
> ---
>  drivers/gpu/drm/i915/intel_hdmi.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/i915/intel_hdmi.c b/drivers/gpu/drm/i915/intel_hdmi.c
> index 98f6024..12dc330 100644
> --- a/drivers/gpu/drm/i915/intel_hdmi.c
> +++ b/drivers/gpu/drm/i915/intel_hdmi.c
> @@ -609,7 +609,7 @@ static void intel_hdmi_dpms(struct drm_encoder *encoder, int mode)
>         u32 temp;
>         u32 enable_bits = SDVO_ENABLE;
>
> -       if (intel_hdmi->has_audio)
> +       if (intel_hdmi->has_audio || mode != DRM_MODE_DPMS_ON)
>                 enable_bits |= SDVO_AUDIO_ENABLE;
>
>         temp = I915_READ(intel_hdmi->sdvox_reg);
> --
> 1.7.9.5
>



-- 
Daniel Vetter
Software Engineer, Intel Corporation
+41 (0) 79 365 57 48 - http://blog.ffwll.ch
