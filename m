From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: au1x: convert to platform drivers.
Date: Mon, 2 Nov 2009 11:53:55 +0000
Message-ID: <20091102115354.GG29351@sirena.org.uk>
References: <1257016508-13195-1-git-send-email-manuel.lauss@gmail.com>
	<20091102113247.GE29351@sirena.org.uk>
	<f861ec6f0911020339x3816f6c0oe8ec935800f9f56a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 47119103824
	for <alsa-devel@alsa-project.org>; Mon,  2 Nov 2009 12:53:55 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <f861ec6f0911020339x3816f6c0oe8ec935800f9f56a@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Manuel Lauss <manuel.lauss@googlemail.com>
Cc: Manuel Lauss <manuel.lauss@gmail.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Mon, Nov 02, 2009 at 12:39:11PM +0100, Manuel Lauss wrote:

> Great, thanks.  I'll add you to all other asoc related patches in the future.
> Off-topic: I'm not really up-to-date on ASoC; how is multi-device support
> coming along?  I received a new system which has 2 independet audio
> systems, one with AC97 WM9715 + touchscreen, the other I2S.  Some day
> I'd like to support the touch interface and I2S at the same time ;-)

If they're two completely unrelated audio subsystems then it might
actually work at the minute if you register two ASoC devices with
different device numbers, I've had reports that people are succesfully
doing this.
