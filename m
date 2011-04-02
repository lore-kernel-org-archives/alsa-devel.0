From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: Remove special casing for
 registerless widgets
Date: Sat, 2 Apr 2011 17:18:02 +0900
Message-ID: <20110402081801.GC28417@opensource.wolfsonmicro.com>
References: <1301730541-10767-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<20110402080755.GG14553@qtel.sh.intel.com>
	<20110402081244.GH14553@qtel.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id CB3C31037F2
	for <alsa-devel@alsa-project.org>;
	Sat,  2 Apr 2011 10:17:54 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20110402081244.GH14553@qtel.sh.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Lu Guanqun <guanqun.lu@intel.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Sat, Apr 02, 2011 at 04:12:44PM +0800, Lu Guanqun wrote:
> On Sat, Apr 02, 2011 at 04:07:55PM +0800, Lu Guanqun wrote:

> > But I still don't quite understand the write compression, it aims at
> > reducing the number of register writes, however in
> > dapm_seq_run_coalesced, it calls snd_soc_update_bits.

> I mean, for write compression or not, as long as its widget register is
> valid, it will be updated. So I don't see why write compression would
> reduce the number...

The idea is that since you often have all the enable bits together in a
small set of registers if you're enabling two of the same widget type at
once and they're both in the same register you can do it with one write.
For example, if you're doing a stereo playback this will usually mean
that enabling left and right DACs is one register write.  This is also
good for pop/click performance as it ensures that both channels turn on
simultaneously.

You can see this quite easily if you turn on DAPM pop debugging with a
short delay - write to asoc/$CARD/dapm_pop_time in debugfs and start a
playback or something and you'll see logging showing the writes being
combined.
