From: Liviu Dudau <liviu@dudau.co.uk>
Subject: Re: [PATCH] ALSA: ASoC: TLV320AIC23: Unquote NULL from control name
Date: Tue, 7 Mar 2017 00:54:08 +0000
Message-ID: <20170307005408.GB8397@bart.dudau.co.uk>
References: <20170301122628.10392-1-liviu@dudau.co.uk>
 <20170306104118.6v763cejdc3ow6ef@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170306104118.6v763cejdc3ow6ef@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, ALSA devel <alsa-devel@alsa-project.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

Hi Mark,

On Mon, Mar 06, 2017 at 11:41:18AM +0100, Mark Brown wrote:
> On Wed, Mar 01, 2017 at 12:26:28PM +0000, Liviu Dudau wrote:
> > Without this I am getting the following messages at boot on my Trimslice:
> >    tlv320aic23-codec 2-001a: Control not supported for path LLINEIN -> [NULL] -> Line Input
> 
> Please use subject lines matching the style for the subsystem.  This
> makes it easier for people to identify relevant patches.

Other than the additional ALSA: prefix I have matched the format used
by previous commits touching the file. I'm not clear where I have made the
mistake and what would have been the better subject line.

Best regards,
Liviu
