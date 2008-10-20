From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: No pcm device?
Date: Mon, 20 Oct 2008 13:40:39 +0100
Message-ID: <20081020124038.GB24360@sirena.org.uk>
References: <520f0cf10810200534j3ccb84cag3e012c4e101de2fe@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id D21411038DA
	for <alsa-devel@alsa-project.org>;
	Mon, 20 Oct 2008 14:40:56 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <520f0cf10810200534j3ccb84cag3e012c4e101de2fe@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: John Kacur <jkacur@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Mon, Oct 20, 2008 at 02:34:39PM +0200, John Kacur wrote:
> I'm not sure if the hardware I have makes this problem simple for me,
> or difficult, because it seems to differ from other ASoC code.
> Basically, I have a i2s as transport, connected to max5556 driving the
> output. (and a few other chips related to amplification and muting)

This all seems very normal for ASoC - something like a stereo DAC
connected to a CPU via I2S is exactly the sort of situation that ASoC is
designed to handle.  However...

> There is however no sound card, thus no PCM device. Now the question
> is how to proceed? In other words what kind of minimal PCM layer do I
> need if any?

...the goal of ASoC is to provide a sound card to user space via the
ALSA APIs so if you're trying to do something else then there's a
massive mismatch between that and what ASoC is designed to achieve.

Could you please clarify what you're attempting to do here?
