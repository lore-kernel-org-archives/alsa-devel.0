From: Fengguang Wu <fengguang.wu@intel.com>
Subject: Re: sound/pci/hda/hda_codec.c:1435:46: error:
 'AC_VERB_GET_CON' undeclared
Date: Mon, 15 Oct 2012 09:49:26 +0800
Message-ID: <20121015014926.GA7203@localhost>
References: <20121012170109.GD20312@localhost> <s5h7gquixlv.wl%tiwai@suse.de>
 <20121014023953.GA8713@localhost>
 <20121015005944.GC24935@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id 67B93262638
 for <alsa-devel@alsa-project.org>; Mon, 15 Oct 2012 03:49:30 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20121015005944.GC24935@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, kernel-janitors@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Mon, Oct 15, 2012 at 09:59:45AM +0900, Mark Brown wrote:
> On Sun, Oct 14, 2012 at 10:39:53AM +0800, Fengguang Wu wrote:
> 
> > OK. Takashi, Mark, the build system can now avoid testing selected
> > trees during the merge window. Shall I add your trees to the list?
> 
> For me I'd really want to be able to keep the for-next branch covered,
> it's better to have the false positives than to loose that coverage.

Got it, yeah it makes good sense.

Thanks,
Fengguang
