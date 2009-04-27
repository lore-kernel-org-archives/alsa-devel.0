From: Jon Smirl <jonsmirl@gmail.com>
Subject: Re: Driver code with mpc5200 pointer problem.
Date: Mon, 27 Apr 2009 09:50:01 -0400
Message-ID: <9e4733910904270650g204d2660y7e3b9ea03446a752@mail.gmail.com>
References: <9e4733910904260825o68d5b9dndbf92cdbc4a4e48e@mail.gmail.com>
	<alpine.LNX.2.00.0904261838010.25064@eeebox2.perex-int.cz>
	<9e4733910904261114u20e8376ci26a13a5210a4aa0b@mail.gmail.com>
	<20090427092514.GB1760@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qy0-f103.google.com (mail-qy0-f103.google.com
	[209.85.221.103])
	by alsa0.perex.cz (Postfix) with ESMTP id 9ED45103824
	for <alsa-devel@alsa-project.org>;
	Mon, 27 Apr 2009 15:50:02 +0200 (CEST)
Received: by qyk1 with SMTP id 1so4495431qyk.16
	for <alsa-devel@alsa-project.org>; Mon, 27 Apr 2009 06:50:01 -0700 (PDT)
In-Reply-To: <20090427092514.GB1760@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@sirena.org.uk>
Cc: alsa-devel mailing list <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Mon, Apr 27, 2009 at 5:25 AM, Mark Brown <broonie@sirena.org.uk> wrote:
> On Sun, Apr 26, 2009 at 02:14:44PM -0400, Jon Smirl wrote:
>
>> Yes, it wants continuous memory. I added SNDRV_PCM_HW_PARAM_PERIODS
>> and things are working better.
>> That was a better solution than breaking up operations into multiple
>> DMA requests.
>
> Does that patch need merging for 2.6.30 (you said I2S was broken)?

Grant and I are the only two active users of I2S and we're passing
patches to each other.  I don't have I2S completely fixed yet.

I'll post a series today that reorgs things to make my real patches
easier to apply. The series has already been posted on linux-ppc and
ack'd by Grant. He want it to go in via the ALSA trees. It is a
passive change that splits mpc5200_i2s.c into multiple files and
breaks out the DMA code. I need to rename a couple of globally visible
functions before posting it again.

My real patches fix up i2s and implement ac97.

-- 
Jon Smirl
jonsmirl@gmail.com
