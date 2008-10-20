From: "John Kacur" <jkacur@gmail.com>
Subject: Re: No pcm device?
Date: Mon, 20 Oct 2008 14:51:04 +0200
Message-ID: <520f0cf10810200551y9b4b6c9xc67f7b025497b96e@mail.gmail.com>
References: <520f0cf10810200534j3ccb84cag3e012c4e101de2fe@mail.gmail.com>
	<20081020124038.GB24360@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from wf-out-1314.google.com (wf-out-1314.google.com [209.85.200.174])
	by alsa0.perex.cz (Postfix) with ESMTP id D1BA8103805
	for <alsa-devel@alsa-project.org>;
	Mon, 20 Oct 2008 14:51:23 +0200 (CEST)
Received: by wf-out-1314.google.com with SMTP id 24so1812919wfg.23
	for <alsa-devel@alsa-project.org>; Mon, 20 Oct 2008 05:51:04 -0700 (PDT)
In-Reply-To: <20081020124038.GB24360@sirena.org.uk>
Content-Disposition: inline
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
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Mon, Oct 20, 2008 at 2:40 PM, Mark Brown <broonie@sirena.org.uk> wrote:
> On Mon, Oct 20, 2008 at 02:34:39PM +0200, John Kacur wrote:
>> I'm not sure if the hardware I have makes this problem simple for me,
>> or difficult, because it seems to differ from other ASoC code.
>> Basically, I have a i2s as transport, connected to max5556 driving the
>> output. (and a few other chips related to amplification and muting)
>
> This all seems very normal for ASoC - something like a stereo DAC
> connected to a CPU via I2S is exactly the sort of situation that ASoC is
> designed to handle.  However...
>
>> There is however no sound card, thus no PCM device. Now the question
>> is how to proceed? In other words what kind of minimal PCM layer do I
>> need if any?
>
> ...the goal of ASoC is to provide a sound card to user space via the
> ALSA APIs so if you're trying to do something else then there's a
> massive mismatch between that and what ASoC is designed to achieve.
>
> Could you please clarify what you're attempting to do here?
>

On a simple level, I'm just trying to provide sound, by implementing
an alsa driver. I've implemented a low-level library that can
manipulate all my hardware's i2s registers, and I've been mirroring
other alsa-soc drivers, and I'm at the point where I'm scratching my
head over what to do about PCM. The confusion to me, is that the code
seems to describe actually hardware - and the only thing I can think
of it what my hardware i2s is capable of transmitting, does that sound
right?
