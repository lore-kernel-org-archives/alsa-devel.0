From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH v5] ucm: add cset-tlv
Date: Wed, 13 Apr 2016 19:09:41 +0530
Message-ID: <20160413133941.GN2274@localhost>
References: <1460544789-29169-1-git-send-email-hychao@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id 7A95C2604D6
 for <alsa-devel@alsa-project.org>; Wed, 13 Apr 2016 15:35:08 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1460544789-29169-1-git-send-email-hychao@chromium.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Hsin-Yu Chao <hychao@chromium.org>
Cc: alsa-devel@alsa-project.org, dgreid@chromium.org
List-Id: alsa-devel@alsa-project.org

On Wed, Apr 13, 2016 at 06:53:09PM +0800, Hsin-Yu Chao wrote:
> This patch enables UCM to set a file in TLV format to kcontrol by:
> cset-tlv "name='<kcontrol-name>' <path-to-file>"
> This new 'cset-tlv' command will be used to write audio DSP to
> specific alsa control, where the driver expectes a file in TLV
> format.
> The TLV file to set to kcontrol will be checked first by file size
> not larger than 16 MB, and then examine if the length field reports
> correct number of bytes in the TLV file.

Reviewed-by: Vinod Koul <vinod.koul@intel.com>

Thanks
-- 
~Vinod
