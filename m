From: Steven Eckhoff <steven.eckhoff.opensource@gmail.com>
Subject: Re: [alsa-devel][PATCH 2/3] ASoC: TSCS42xx: Remove Playback/Capture
 in names
Date: Wed, 20 Jun 2018 12:34:53 -0500
Message-ID: <20180620173451.GA3900@t7-ThinkPad-E560>
References: <cover.1528143829.git.steven.eckhoff.opensource@gmail.com>
 <a1f30fe79d376bb1dea4c41a34f198310a8ff9a4.1528143829.git.steven.eckhoff.opensource@gmail.com>
 <20180618113154.GC6928@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180618113154.GC6928@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Mon, Jun 18, 2018 at 12:31:54PM +0100, Mark Brown wrote:
> Really?  They're part of the spec so it indicates that the apps have a
> problem...

I apologize for the delayed response.

I am unable to reproduce the issue that I was seeing with controls that
had Playback or Capture in their names. I am going look into this
further.

I was seeing an issue with amixer set where it would not find the
control, but I could use the numid. I wanted to make sure that it would
always work, so I could provide amixer set commands using the name of
the control in our documentation.

Regards,

Steven
