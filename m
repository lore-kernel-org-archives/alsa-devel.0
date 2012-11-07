From: anish kumar <anish198519851985@gmail.com>
Subject: Re: commit: dpcm: Allow FE to be opened without valid
	BE routes
Date: Wed, 07 Nov 2012 21:56:39 +0900
Message-ID: <1352292999.1574.6.camel@anish-Inspiron-N5050>
References: <mailman.495.1352127790.820.alsa-devel@alsa-project.org>
 <1352221394.4968.38.camel@anish-Inspiron-N5050>
 <20121107084856.GC12323@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pa0-f51.google.com (mail-pa0-f51.google.com
 [209.85.220.51])
 by alsa0.perex.cz (Postfix) with ESMTP id D6C1F264FEA
 for <alsa-devel@alsa-project.org>; Wed,  7 Nov 2012 13:56:49 +0100 (CET)
Received: by mail-pa0-f51.google.com with SMTP id kq12so1040624pab.38
 for <alsa-devel@alsa-project.org>; Wed, 07 Nov 2012 04:56:48 -0800 (PST)
In-Reply-To: <20121107084856.GC12323@opensource.wolfsonmicro.com>
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
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, lrg@ti.com
List-Id: alsa-devel@alsa-project.org

On Wed, 2012-11-07 at 09:48 +0100, Mark Brown wrote:
> On Wed, Nov 07, 2012 at 02:03:14AM +0900, anish kumar wrote:
> 
> > As I can see this commit has changed the log level from dev_warn to
> > dev_dbg but this has caused a subtle problem.Right now we rely on this
> > warning to find out issues related to "application not sending UCM
> 
> You shouldn't be relying on parsing dmesg for anything, that's never
> going to be robust as you've just found.  dmesg is for humans. 
Probably I couldn't explain the problem clearly.Problem is that in our
case we get sometimes(very random) audio mute in android devices due to
UCM commands from the platform not sent properly or sent in such a way
that FE and BE don't get connected.
This issues are very hard to reproduce and only gets reproduced randomly
by the test engineer and when it does happen, test engineer takes crash
dump and provides us the log.So it is almost impossible to know what
caused this audio mute at that time and all we have is this very
log(dev_warn(FE and BE not connected)) to let us know that this mute was
due to platform and not codec or any other problem with the kernel.
Anyway looks like this idea is not liked by the community so I won't
push further.
Thanks for reading.
> 
> > If everyone agrees then I would be more than happy to send a patch.
> 
> Please come up with a better way of identifying this; something like
> information in debugfs for example or working on getting the media
> controller API support merged and then using that to parse out the
> routing map from that and notice the misconfiguration.  This would
> be much better anyway since the same thing can happen elsewhere in DAPM
> and your current mechanism.
