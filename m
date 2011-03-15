From: "Koul, Vinod" <vinod.koul@intel.com>
Subject: Re: codec power question
Date: Tue, 15 Mar 2011 17:57:27 +0530
Message-ID: <1300192047.19661.5.camel@vkoul-udesk3>
References: <1300182023.1497.7.camel@vkoul-udesk3>
	<20110315113030.GB17277@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	by alsa0.perex.cz (Postfix) with ESMTP id A4AB7103803
	for <alsa-devel@alsa-project.org>; Tue, 15 Mar 2011 13:57:10 +0100 (CET)
In-Reply-To: <20110315113030.GB17277@sirena.org.uk>
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
Cc: alsa <alsa-devel@alsa-project.org>, Mark Brown <broonie@opensource.wolfsonmciro.com>, Liam <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Tue, 2011-03-15 at 17:00 +0530, Mark Brown wrote:
> On Tue, Mar 15, 2011 at 03:10:23PM +0530, Koul, Vinod wrote:
> 
> > In some cases the audio stream is kept ON and idle by application. In
> > that case codec is also ON. Is there a mechanism where DAPM can detect
> > this idle condition and turn off the idle widgets or turn of the codec
> > BIAS
> 
> If this is happening it's a framework bug - if there are no active audio
> streams through the device then it should be brought down to the lowest
> power state.  The application doesn't have any direct control over the
> CODEC power except by configuring audio streams.  Can you provide any
> more details on how this happens?
In andriod, flinger opens the streams at boot and keeps them ON, and
doesn't close the stream when in idle.
Since the stream in ON, codec consumes lot of power, I was wondering if
we have something in asoc to detect this kind of state and do much
better power control.

-- 
~Vinod
