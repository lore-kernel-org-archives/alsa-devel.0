From: Lu Guanqun <guanqun.lu@intel.com>
Subject: Re: [PATCH] ASoC: Remove special casing for
 registerless widgets
Date: Sat, 2 Apr 2011 16:22:00 +0800
Message-ID: <20110402082200.GI14553@qtel.sh.intel.com>
References: <1301730541-10767-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<20110402080755.GG14553@qtel.sh.intel.com>
	<20110402081244.GH14553@qtel.sh.intel.com>
	<20110402081801.GC28417@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [143.182.124.37])
	by alsa0.perex.cz (Postfix) with ESMTP id 57F721037FC
	for <alsa-devel@alsa-project.org>;
	Sat,  2 Apr 2011 10:22:33 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20110402081801.GC28417@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Sat, Apr 02, 2011 at 04:18:02PM +0800, Mark Brown wrote:
> On Sat, Apr 02, 2011 at 04:12:44PM +0800, Lu Guanqun wrote:
> > On Sat, Apr 02, 2011 at 04:07:55PM +0800, Lu Guanqun wrote:
> 
> > > But I still don't quite understand the write compression, it aims at
> > > reducing the number of register writes, however in
> > > dapm_seq_run_coalesced, it calls snd_soc_update_bits.
> 
> > I mean, for write compression or not, as long as its widget register is
> > valid, it will be updated. So I don't see why write compression would
> > reduce the number...
> 
> The idea is that since you often have all the enable bits together in a
> small set of registers if you're enabling two of the same widget type at
> once and they're both in the same register you can do it with one write.
> For example, if you're doing a stereo playback this will usually mean
> that enabling left and right DACs is one register write.  This is also
> good for pop/click performance as it ensures that both channels turn on
> simultaneously.

Thanks for the explaination. I get the idea.

> You can see this quite easily if you turn on DAPM pop debugging with a
> short delay - write to asoc/$CARD/dapm_pop_time in debugfs and start a
> playback or something and you'll see logging showing the writes being
> combined.

I'll try this and see the differences.

Thanks Mark!

-- 
guanqun
