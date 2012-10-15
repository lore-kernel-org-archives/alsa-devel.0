From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: sound/pci/hda/hda_codec.c:1435:46: error:
 'AC_VERB_GET_CON' undeclared
Date: Mon, 15 Oct 2012 09:59:45 +0900
Message-ID: <20121015005944.GC24935@opensource.wolfsonmicro.com>
References: <20121012170109.GD20312@localhost> <s5h7gquixlv.wl%tiwai@suse.de>
 <20121014023953.GA8713@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id F1A7726262D
 for <alsa-devel@alsa-project.org>; Mon, 15 Oct 2012 03:00:02 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20121014023953.GA8713@localhost>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Fengguang Wu <fengguang.wu@intel.com>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, kernel-janitors@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Sun, Oct 14, 2012 at 10:39:53AM +0800, Fengguang Wu wrote:

> OK. Takashi, Mark, the build system can now avoid testing selected
> trees during the merge window. Shall I add your trees to the list?

For me I'd really want to be able to keep the for-next branch covered,
it's better to have the false positives than to loose that coverage.
