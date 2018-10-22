From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [asoc:for-4.20 333/424]
 sound/pci/hda/patch_ca0132.c:7650:20: error: implicit declaration of
 function 'pci_iomap'; did you mean 'pcim_iomap'?
Date: Mon, 22 Oct 2018 12:44:21 -0500
Message-ID: <f9c55e50-234f-7b89-cbfa-89606b52f570@linux.intel.com>
References: <201809111307.iuux6Toj%fengguang.wu@intel.com>
 <s5h4lew34fv.wl-tiwai@suse.de> <20180912113128.GF6062@sirena.org.uk>
 <s5hworq6i2m.wl-tiwai@suse.de> <20180912120422.GG6062@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id B79482677D0
 for <alsa-devel@alsa-project.org>; Mon, 22 Oct 2018 19:44:24 +0200 (CEST)
In-Reply-To: <20180912120422.GG6062@sirena.org.uk>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Rakesh Ughreja <rakesh.a.ughreja@intel.com>, kbuild test robot <lkp@intel.com>, kbuild-all@01.org
List-Id: alsa-devel@alsa-project.org


On 9/12/18 7:04 AM, Mark Brown wrote:
> On Wed, Sep 12, 2018 at 02:01:05PM +0200, Takashi Iwai wrote:
>> Mark Brown wrote:
>>> Not on x86 we can't, it's not there - asm/io.h seems safest AFAICT,
>>> everyone has it and both SH and x86 include the pci_iomap.h.
>> Hmm, the code does include <linux/io.h>, and it includes <asm/io.h>
> Yeah, at least not on SH - it is on most architectures.
>
>> I don't think arch/sh/include/asm/io.h includes the necessary thing.
> I'm just about to submit a patch which makes it the (or at least a)
> necessary thing.  This stuff shouldn't be complicated or inconsistent.

Mark, did you submit the patch you mentioned? I can reproduce the issue 
with the latest code so something is still missing - or I didn't find 
it. Thanks!
