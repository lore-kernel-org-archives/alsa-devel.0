From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: wm8974 and sam9g45 atmel
Date: Fri, 24 Jun 2011 13:09:44 +0100
Message-ID: <20110624120943.GG9483@opensource.wolfsonmicro.com>
References: <4DF0E2B4.7040401@ecsproject.com>
	<20110610103118.GA26441@sirena.org.uk>
	<4DFB1CEA.2060308@ecsproject.com> <4DFB6CA5.9010202@ecsproject.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 81F3624489
	for <alsa-devel@alsa-project.org>;
	Fri, 24 Jun 2011 14:09:46 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <4DFB6CA5.9010202@ecsproject.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Michele Da Rold <michele.darold@ecsproject.com>
Cc: dp@opensource.wolfsonmicro.com, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Fri, Jun 17, 2011 at 05:03:01PM +0200, Michele Da Rold wrote:

> it's better to use wm8974 like master? because I have see that the
> atmel ssc is not so good generating clocks....

Probably in your system, yes.  The most important thing from an audio
performance point of view is that the clocks are all derived from the
same clock source - if this is like other Atmel systems then you need to
make the CODEC clock master on the audio bus as the MCLK output from the
CPU is not synchronous with the audio clocks.
