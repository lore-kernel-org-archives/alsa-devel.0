From: Steve Calfee <stevecalfee@gmail.com>
Subject: Re: git trees
Date: Wed, 30 Mar 2011 18:03:41 -0700
Message-ID: <4D93D2ED.9040302@gmail.com>
References: <4D93C892.6080602@gmail.com>
	<20110331003327.GF21487@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pz0-f51.google.com (mail-pz0-f51.google.com
	[209.85.210.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 514E1103A1E
	for <alsa-devel@alsa-project.org>;
	Thu, 31 Mar 2011 03:03:48 +0200 (CEST)
Received: by pzk26 with SMTP id 26so342731pzk.38
	for <alsa-devel@alsa-project.org>; Wed, 30 Mar 2011 18:03:44 -0700 (PDT)
In-Reply-To: <20110331003327.GF21487@opensource.wolfsonmicro.com>
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

On 03/30/11 17:33, Mark Brown wrote:
> On Wed, Mar 30, 2011 at 05:19:30PM -0700, Steve Calfee wrote:
> 
>> I am starting to look at a new codec driver. I have been looking at the
>> alsa-project wiki describing the various git trees. I am confused
>> because they seem to be lagging the linux releases (ie 2.6.38 is out,
>> not in the two trees I have tried.
> 
> You should be developing against the Linux kernel, not against the out
> of tree ALSA, for ASoC.  This is mostly true for regular ALSA drivers
> too.
> 

Hi Mark,

Thanks for your time. I was already using linux-next - So that would be
the correct tree when you say linux kernel?

If linux-next is the case how long do I have to wait until some of the
latest asoc patches arrive? I thought that the alsa trees were somewhat
ahead of the linux-next because they had asoc/alsa patches in them. For
instance you have patches against both 2.6.39 and 2.6.40 somewhere and I
don't think they are in linux-next.

Regards, Steve
