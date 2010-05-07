From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 10/11] ASoC: S3C64XX: IISv4: Add CPU driver
Date: Fri, 7 May 2010 17:44:49 +0100
Message-ID: <20100507164448.GE25793@rakim.wolfsonmicro.main>
References: <1272351431-3981-1-git-send-email-jassi.brar@samsung.com>
	<20100505143046.GA9530@rakim.wolfsonmicro.main>
	<v2u1b68c6791005061833r9a98cbbbk771cce705d82a5cd@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 84AAB1038B6
	for <alsa-devel@alsa-project.org>;
	Fri,  7 May 2010 18:44:51 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <v2u1b68c6791005061833r9a98cbbbk771cce705d82a5cd@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: jassi brar <jassisinghbrar@gmail.com>
Cc: alsa-devel@alsa-project.org, ben-linux@fluff.org, Jassi Brar <jassi.brar@samsung.com>, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

On Fri, May 07, 2010 at 10:33:39AM +0900, jassi brar wrote:

> That is strange, because I am able to cleanly apply these 11 patches
> against commit  cb7cf44c880aeb8caf8 of for-2.6.35
> Could you please try again?

I had another poke at this and managed to get the last two applied,
thanks.  However, the audio-bus clock for the IISv4 block on the S3C6410
is still not set up in -next.  If that doesn't get sorted out it might
be as well to mark it BROKEN again since it can't actually be used.
