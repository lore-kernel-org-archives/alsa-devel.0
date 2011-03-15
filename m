From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: codec power question
Date: Tue, 15 Mar 2011 11:30:30 +0000
Message-ID: <20110315113030.GB17277@sirena.org.uk>
References: <1300182023.1497.7.camel@vkoul-udesk3>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 2C65B1038CB
	for <alsa-devel@alsa-project.org>; Tue, 15 Mar 2011 12:30:33 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1300182023.1497.7.camel@vkoul-udesk3>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "Koul, Vinod" <vinod.koul@intel.com>
Cc: alsa <alsa-devel@alsa-project.org>, Mark Brown <broonie@opensource.wolfsonmciro.com>, Liam <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Tue, Mar 15, 2011 at 03:10:23PM +0530, Koul, Vinod wrote:

> In some cases the audio stream is kept ON and idle by application. In
> that case codec is also ON. Is there a mechanism where DAPM can detect
> this idle condition and turn off the idle widgets or turn of the codec
> BIAS

If this is happening it's a framework bug - if there are no active audio
streams through the device then it should be brought down to the lowest
power state.  The application doesn't have any direct control over the
CODEC power except by configuring audio streams.  Can you provide any
more details on how this happens?

Note that for playback streams there's a delay before things are powered
down to avoid delays, pops and clicks when doing things like changing
tracks.  By default the delay is 5s.
