From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH v2] ASoC: Intel: Update
	bxt_da7219_max98357a to add a new
Date: Tue, 21 Mar 2017 09:39:34 +0530
Message-ID: <20170321040934.GX2843@localhost>
References: <1489620505-24841-1-git-send-email-harshapriya.n@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id 514EC266FBD
 for <alsa-devel@alsa-project.org>; Tue, 21 Mar 2017 05:08:24 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1489620505-24841-1-git-send-email-harshapriya.n@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Harsha Priya <harshapriya.n@intel.com>
Cc: alsa-devel@alsa-project.org, broonie@kernel.org, sathyanarayana.nujella@intel.com
List-Id: alsa-devel@alsa-project.org

On Wed, Mar 15, 2017 at 04:28:25PM -0700, Harsha Priya wrote:
> This patch adds a platform clock widget to turn off the clock only when
> both headset capture and headset playback are not in use. This removes
> turning off the clock in hw_free so that the clock is on when
> either capture or playback of headset is in progress.

Acked-by: Vinod Koul <vinod.koul@intel.com>

-- 
~Vinod
