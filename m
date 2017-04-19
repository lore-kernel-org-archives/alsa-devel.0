From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [PATCH] ASoC: Intel: Skylake: fix dereference
 before NULL check on ebus
Date: Wed, 19 Apr 2017 16:32:49 +0300
Message-ID: <20170419133249.ac3sdmn7kqjbxaii@mwanda>
References: <20170419121613.12353-1-colin.king@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from aserp1040.oracle.com (aserp1040.oracle.com [141.146.126.69])
 by alsa0.perex.cz (Postfix) with ESMTP id 1E8C2266A4B
 for <alsa-devel@alsa-project.org>; Wed, 19 Apr 2017 15:33:07 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20170419121613.12353-1-colin.king@canonical.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Colin King <colin.king@canonical.com>
Cc: alsa-devel@alsa-project.org, Dharageswari R <dharageswari.r@intel.com>, Vinod Koul <vinod.koul@intel.com>, Pardha Saradhi K <pardha.saradhi.kesapragada@intel.com>, Jayachandran B <jayachandran.b@intel.com>, kernel-janitors@vger.kernel.org, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jeeja KP <jeeja.kp@intel.com>, "Subhransu S . Prusty" <subhransu.s.prusty@intel.com>, linux-kernel@vger.kernel.org, Yong Zhi <yong.zhi@intel.com>
List-Id: alsa-devel@alsa-project.org

On Wed, Apr 19, 2017 at 01:16:13PM +0100, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> ebus is being NULL checked however it is being dereferenced
> earlier on the assignment bus = ebus_to_hbus(ebus).  Fix this
> by moving the assignment to after the NULL check on ebus to
> avoid a NULL pointer dereference error.
> 

ebus_to_hbus() doesn't dereference "ebus" it just uses it for pointer
math.

#define ebus_to_hbus(ebus)      (&(ebus)->bus)

If you pass a NULL to there, it returns an offset starting from NULL but
it doesn't Oops.

regards,
dan carpenter
