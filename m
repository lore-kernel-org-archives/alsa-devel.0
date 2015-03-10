From: Fengguang Wu <fengguang.wu@intel.com>
Subject: Re: [PATCH baohua] ASoC: sirf: atlas7:
 atlas7_iacc_dai_ops can be static
Date: Tue, 10 Mar 2015 11:41:39 +0800
Message-ID: <20150310034139.GA17221@wfg-t540p.sh.intel.com>
References: <201502060130.hszyNa1F%fengguang.wu@intel.com>
 <20150205170352.GA49811@snb> <20150205171159.GY21293@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by alsa0.perex.cz (Postfix) with ESMTP id 3D66A2614D9
 for <alsa-devel@alsa-project.org>; Tue, 10 Mar 2015 04:41:43 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20150205171159.GY21293@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>, linux-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>, Rongjun Ying <rongjun.ying@csr.com>, kbuild-all@01.org, Barry Song <Barry.Song@csr.com>
List-Id: alsa-devel@alsa-project.org

On Thu, Feb 05, 2015 at 05:11:59PM +0000, Mark Brown wrote:
> On Fri, Feb 06, 2015 at 01:03:52AM +0800, kbuild test robot wrote:
> > sound/soc/sirf/atlas7-iacc.c:168:24: sparse: symbol 'atlas7_iacc_dai_ops' was not declared. Should it be static?
> 
> This file isn't in an upstream tree, should this patch have been sent
> upstream (I suspect non-upstream trees may need a bit of filtering in
> the scripts)?

Good point! I just added some tests trying to avoid this, which should
be much better, but nevertheless not complete enough to cover all cases.
Please help point out inadequate cases when you come across them in future!

Thanks,
Fengguang
