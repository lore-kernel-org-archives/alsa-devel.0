From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: git trees
Date: Fri, 1 Apr 2011 06:39:17 +0900
Message-ID: <20110331213915.GA21726@opensource.wolfsonmicro.com>
References: <4D93C892.6080602@gmail.com>
	<20110331003327.GF21487@opensource.wolfsonmicro.com>
	<4D93D2ED.9040302@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 5D07A10380D
	for <alsa-devel@alsa-project.org>;
	Thu, 31 Mar 2011 23:39:08 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <4D93D2ED.9040302@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Steve Calfee <stevecalfee@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Wed, Mar 30, 2011 at 06:03:41PM -0700, Steve Calfee wrote:

> Thanks for your time. I was already using linux-next - So that would be
> the correct tree when you say linux kernel?

Follow the generic process covered in Documentation/SubmittingPatches.

> If linux-next is the case how long do I have to wait until some of the
> latest asoc patches arrive? I thought that the alsa trees were somewhat
> ahead of the linux-next because they had asoc/alsa patches in them. For
> instance you have patches against both 2.6.39 and 2.6.40 somewhere and I
> don't think they are in linux-next.

Mostly -next will lag my tree by at most 24 hours.  During the period
beween the release of one kernel and the release of the other we don't
put code into -next that isn't intended for -rc1 of the current kernel
in order to help with stabalisation and merge but other than that you
will find the latest ASoC code in -next.
