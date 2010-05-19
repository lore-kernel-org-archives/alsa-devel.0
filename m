From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: ASoC: Dummy codec driver?
Date: Wed, 19 May 2010 08:02:17 -0700
Message-ID: <1274281337.2698.1046.camel@finisterre.wolfsonmicro.main>
References: <4BF3D7ED.8090805@samsung.com>
	(sfid-20100519_132344_828857_043FB409)
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id AB7D5245DE
	for <alsa-devel@alsa-project.org>;
	Wed, 19 May 2010 17:02:08 +0200 (CEST)
In-Reply-To: <4BF3D7ED.8090805@samsung.com>
	(sfid-20100519_132344_828857_043FB409)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Joonyoung Shim <jy0922.shim@samsung.com>
Cc: alsa-devel@alsa-project.org, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

On Wed, 2010-05-19 at 21:22 +0900, Joonyoung Shim wrote:

> I have a target(The cpu is S5PC110) which doesn't have audio codec, but 
> it needs the audio device node to play audio at the TV via HDMI. The
> S5PC110 HDMI transmits itself to TV the audio data from I2S buffer, so i 
> have made dummy codec driver to create audio device node and to transmit
> audio data to I2S buffer.

> How do you think about the dummy codec driver?

That seems like a good solution to your problem - there's already a few
dummy drivers present in the tree for fixed function devices (so all
they do is set capabilities for the DAI link). This would slot in nicely
beside them.
