From: Andreas Dannenberg <dannenberg@ti.com>
Subject: Re: Codec "virtual multiplexer" representation
Date: Wed, 17 Feb 2016 23:30:21 -0600
Message-ID: <20160218053021.GE6263@borg.dal.design.ti.com>
References: <56C499A7.2040202@barix.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bear.ext.ti.com (bear.ext.ti.com [192.94.94.41])
 by alsa0.perex.cz (Postfix) with ESMTP id 2232C26067A
 for <alsa-devel@alsa-project.org>; Thu, 18 Feb 2016 06:30:22 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <56C499A7.2040202@barix.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Petr Kulhavy <petr@barix.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Wed, Feb 17, 2016 at 05:02:47PM +0100, Petr Kulhavy wrote:
> Hi,
> 
> I'm writing an ASoC driver for the  TAS5721 amplifier.
> This 2.1 amplifier provides a complex configuration of the audio channels
> (3), PWMs(4) and output(4) mappings.
> However only few (about 6) configurations really make sense.

Petr,
on a related note, I'm currently working on a combined driver (85%
complete) for TAS5720/TAS5722 which are nice but relatively simple
Class-D mono amplifiers. Despite almost having the same P/N there is
little to no similarity with TAS5721 (which gives a another example why
one should be careful with wildcard 'x' in driver names) so there is no
case for a combined driver here but let's make sure we align our
namespace to avoid collision:

tas5720.[c|h] - Driver for TAS5720/TAS5722 (WIP by Andreas)
tas5721.[c|h] - Driver for TAS5721 (WIP by Petr)

Regards,

--
Andreas Dannenberg
Texas Instruments Inc


> 
> I'm trying to model the output configurations in ALSA. In order to avoid a
> complicated set of switches and multiplexers I would like
> to add just one multiplexer like control which selects one of these 6 output
> configurations and a callback function which sets the proper
> registers accordingly (there are 5 affected registers).
> 
> Is there a way to create such a "virtual multiplexer" in ALSA?
> 
> Thanks
> Petr
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
