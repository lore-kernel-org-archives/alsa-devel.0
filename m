From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [PATCH -next] ASoC: Intel: bytcht_es8316: Set
 correct platform drvdata in snd_byt_cht_es8316_mc_probe()
Date: Wed, 9 Jan 2019 12:40:39 +0300
Message-ID: <20190109094039.GD1718@kadam>
References: <1547023011-8321-1-git-send-email-weiyongjun1@huawei.com>
 <20190109092924.GB1743@kadam>
 <21a053d4-ed3c-5dce-9630-e72c783914ae@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from userp2130.oracle.com (userp2130.oracle.com [156.151.31.86])
 by alsa0.perex.cz (Postfix) with ESMTP id 008A52665E5
 for <alsa-devel@alsa-project.org>; Wed,  9 Jan 2019 10:41:32 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <21a053d4-ed3c-5dce-9630-e72c783914ae@redhat.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: alsa-devel@alsa-project.org, kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.com>, Jie Yang <yang.jie@linux.intel.com>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Liam Girdwood <liam.r.girdwood@linux.intel.com>, Vinod Koul <vkoul@kernel.org>, Mark Brown <broonie@kernel.org>, Wei Yongjun <weiyongjun1@huawei.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

On Wed, Jan 09, 2019 at 10:33:38AM +0100, Hans de Goede wrote:
> Hi,
> 
> On 09-01-19 10:29, Dan Carpenter wrote:
> > I think the correct fix is actually this (untested):
> 
> Right, I'm pretty sure the soc framework depends on dev_get_drvdata
> returning the snd_soc_card and I forgot about this when adding
> the remove function.
> 
> Wei Yongjun, thank you for catching this.
> 
> Dan, thank you for the correct version of the patch :)
> 
> Dan, can you do an official submission of the correct version of the
> patch, with a Reported-by: Wei Yongjun <weiyongjun1@huawei.com>
> or shall I submit your version upstream ?

Wei can resend and get authorship credit.  I only wrote the patch by
accident because it was easier than explaining.  (Or if you really don't
want to, Wei, then message me and I will do it).

regards,
dan carpenter
