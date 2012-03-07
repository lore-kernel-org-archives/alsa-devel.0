From: Liam Girdwood <lrg@ti.com>
Subject: Re: [PATCH v2] ASoC: DAPM - Use dev_warn for debugfs
 warning message.
Date: Wed, 07 Mar 2012 09:48:50 +0000
Message-ID: <1331113730.3829.7.camel@odin>
References: <1331057605-4542-1-git-send-email-lrg@ti.com>
	<20120306200810.GC19635@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na3sys009aog124.obsmtp.com (na3sys009aog124.obsmtp.com
	[74.125.149.151])
	by alsa0.perex.cz (Postfix) with ESMTP id 92DC21040B2
	for <alsa-devel@alsa-project.org>; Wed,  7 Mar 2012 10:48:54 +0100 (CET)
Received: by wicr5 with SMTP id r5so5047339wic.17
	for <alsa-devel@alsa-project.org>; Wed, 07 Mar 2012 01:48:52 -0800 (PST)
In-Reply-To: <20120306200810.GC19635@opensource.wolfsonmicro.com>
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
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Tue, 2012-03-06 at 20:08 +0000, Mark Brown wrote:
> On Tue, Mar 06, 2012 at 06:13:25PM +0000, Liam Girdwood wrote:
> > Remove printk(KERN_WARNING) and use dev_warn() instead.
> 
> Applied, thanks.
> 
> Everyone else seems to be doing ASoC: thing: rather than having a -.  As
> far as I remember it was Peter that started it, though other people
> (including me) adopted it too.

Historically since 2005 the ASoC patch subject prefix has never been in
any fixed style. My personal preference is the same as Takashi's for
HDA, but I've no problems changing a - to a :. Lets make it more
official now and have :-

ASoC: thing: change

Regards

Liam
