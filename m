From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH v4] ASoC: dfbmcs320: make the driver common
 for other BT modules
Date: Tue, 21 May 2013 20:23:16 +0200
Message-ID: <519BBB94.5010408@metafoo.de>
References: <1368879900-28395-1-git-send-email-Baohua.Song@csr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailhost.informatik.uni-hamburg.de
 (mailhost.informatik.uni-hamburg.de [134.100.9.70])
 by alsa0.perex.cz (Postfix) with ESMTP id 3311E261A97
 for <alsa-devel@alsa-project.org>; Tue, 21 May 2013 20:20:46 +0200 (CEST)
In-Reply-To: <1368879900-28395-1-git-send-email-Baohua.Song@csr.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Barry Song <21cnbao@gmail.com>
Cc: alsa-devel@alsa-project.org, lgirdwood@gmail.com, Workgroup.Linux@csr.com, Graeme Gregory <graeme@openmoko.org>, broonie@kernel.org, Barry Song <Baohua.Song@csr.com>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

On 05/18/2013 02:25 PM, Barry Song wrote:
> DFBM-CS320 is only one of bluetooth modules using CSR bluetooth chips, we
> don't want everyone to have a seperate codec driver. anyway, the feature
> of Bluetooth SCO is same on all platforms, so this patch makes the
> DFBM-CS320 driver become a common BT SCO link driver.
> 
> Cc: Graeme Gregory <graeme@openmoko.org> Cc: Lars-Peter Clausen
> <lars@metafoo.de> Signed-off-by: Barry Song <Baohua.Song@csr.com> --- v4: 
> change "select SND_SOC_DFBMCS320" to "select SND_SOC_BT_SCO" for OpenMOKO
> user as v3 missed this
> 

Looks good to me.

Acked-by: Lars-Peter Clausen <lars@metafoo.de>
