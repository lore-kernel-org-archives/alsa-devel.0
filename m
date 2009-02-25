From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: [PATCH 4/7] ASoC: Fix Zylonite voice
	interface	stereo configurations
Date: Wed, 25 Feb 2009 16:22:42 +0000
Message-ID: <20090225162241.GE31637@sirena.org.uk>
References: <20090225104701.GA20221@rakim.wolfsonmicro.main>
	<1235558902-20314-4-git-send-email-broonie@opensource.wolfsonmicro.com>
	<20090225160617.GH11203@buzzloop.caiaq.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id CBE7124338
	for <alsa-devel@alsa-project.org>; Wed, 25 Feb 2009 17:22:42 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20090225160617.GH11203@buzzloop.caiaq.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Daniel Mack <daniel@caiaq.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Wed, Feb 25, 2009 at 05:06:17PM +0100, Daniel Mack wrote:
> On Wed, Feb 25, 2009 at 10:48:19AM +0000, Mark Brown wrote:
> > We always run in the first timeslot of one.

> I'm currently fiddling around with these bits in order to find a
> suitable configuration where the codec is master, so this is

Several people have reported problems in slave mode, unfortunately I've
no hardware which allows me to do tests in slave mode so I'm a bit stuck
there.

> interesting. As the whole frame in I2S is 64 bits long and one FIFO
> entry has 32 bits of audio data - how can you only deal with one
> timeslot and still playback stereo?

The I2S frame length depends on the number of bits per sample.

> As you set SND_SOC_DAIFMT_I2S, the MOD bit in SSCR0 is set which means
> you are actually running in network mode, right?

> This register really appears mazy to me - sorry if these are obvious
> things I missed.

We are running in network mode without an actual network.
