From: David Henningsson <david.henningsson@canonical.com>
Subject: Re: [PATCH] ALSA: hda - initialize audio InfoFrame to
 be all zero
Date: Tue, 22 Jul 2014 08:52:31 +0200
Message-ID: <53CE0A2F.3070204@canonical.com>
References: <f37b3349bd0a4f5989cf503f578e25ad0f7d160e.1394572173.git.mengdong.lin@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id C3BBA26548E
 for <alsa-devel@alsa-project.org>; Tue, 22 Jul 2014 08:52:33 +0200 (CEST)
In-Reply-To: <f37b3349bd0a4f5989cf503f578e25ad0f7d160e.1394572173.git.mengdong.lin@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: mengdong.lin@intel.com, alsa-devel@alsa-project.org, tiwai@suse.de
List-Id: alsa-devel@alsa-project.org

Hi,

It looks like this patch should have been sent to stable, is there any 
reason why it wasn't?

On 2014-03-11 22:12, mengdong.lin@intel.com wrote:
> From: Mengdong Lin <mengdong.lin@intel.com>
>
> This patch initialized the local audio InfoFrame variable 'ai' to be all zero,
> thus the data bytes will indicate "Refer to Stream Header" by default.
>
> Signed-off-by: Mengdong Lin <mengdong.lin@intel.com>
>
> diff --git a/sound/pci/hda/patch_hdmi.c b/sound/pci/hda/patch_hdmi.c
> index 5ef9503..3ab7063 100644
> --- a/sound/pci/hda/patch_hdmi.c
> +++ b/sound/pci/hda/patch_hdmi.c
> @@ -1062,6 +1062,7 @@ static void hdmi_pin_setup_infoframe(struct hda_codec *codec,
>   {
>   	union audio_infoframe ai;
>
> +	memset(&ai, 0, sizeof(ai));
>   	if (conn_type == 0) { /* HDMI */
>   		struct hdmi_audio_infoframe *hdmi_ai = &ai.hdmi;
>
>

-- 
David Henningsson, Canonical Ltd.
https://launchpad.net/~diwic
