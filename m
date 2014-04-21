From: Stephen Warren <swarren@wwwdotorg.org>
Subject: Re: [PATCHv4 1/2] ALSA: hda/hdmi - Add Nvidia Tegra124
	HDMI support
Date: Mon, 21 Apr 2014 13:46:05 -0600
Message-ID: <5355757D.7010309@wwwdotorg.org>
References: <1397857429-8984-1-git-send-email-dgreid@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from avon.wwwdotorg.org (avon.wwwdotorg.org [70.85.31.133])
 by alsa0.perex.cz (Postfix) with ESMTP id C4A4E2608C9
 for <alsa-devel@alsa-project.org>; Mon, 21 Apr 2014 21:46:09 +0200 (CEST)
In-Reply-To: <1397857429-8984-1-git-send-email-dgreid@chromium.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Dylan Reid <dgreid@chromium.org>, alsa-devel@alsa-project.org
Cc: tiwai@suse.de, Sumit Bhattacharya <sumitb@nvidia.com>, thierry.reding@gmail.com
List-Id: alsa-devel@alsa-project.org

On 04/18/2014 03:43 PM, Dylan Reid wrote:
> From: Sumit Bhattacharya <sumitb@nvidia.com>
> 
> Add the Tegra 12x HDMI controller id to patch_hdmi.

Technically, it's an "HDA CODEC ID" not an "HDMI controller id", but
that's being picky:-)

Acked-by: Stephen Warren <swarren@nvidia.com>
