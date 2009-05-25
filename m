From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH V3 2/4] AC97 driver for mpc5200
Date: Mon, 25 May 2009 16:22:38 +0100
Message-ID: <20090525152237.GK18290@sirena.org.uk>
References: <20090525013606.3073.86753.stgit@terra>
	<20090525013849.3073.96729.stgit@terra>
	<fa686aa40905242316j3e8b46e7mcc71dc34df209003@mail.gmail.com>
	<9e4733910905250815r4a6fa205s26531f08fe99131a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 527D72433E
	for <alsa-devel@alsa-project.org>;
	Mon, 25 May 2009 17:22:46 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <9e4733910905250815r4a6fa205s26531f08fe99131a@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jon Smirl <jonsmirl@gmail.com>
Cc: Grant Likely <grant.likely@secretlab.ca>, linuxppc-dev@ozlabs.org, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Mon, May 25, 2009 at 11:15:34AM -0400, Jon Smirl wrote:

> The link always runs at 12.288Mhz. Each frame is 256 bits. Worst case
> you wait for two frames, 42us. If it doesn't respond in 42us the codec

Note that some embedded systems will choose to vary the AC97 link clock.
The most common case is where there's a PLL on the CODEC - the CODEC
will start up misclocked at whatever the input frequency it's got is and
then be reclocked using register writes to configure the PLL.
