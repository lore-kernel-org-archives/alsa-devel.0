From: ccrome <ccrome@gmail.com>
Subject: Re: [PATCH] fsl_ssi: set fifo watermark to more reliable value
Date: Wed, 4 Jan 2017 10:31:42 -0800
Message-ID: <CAG5mAdzxUhhwjBLWZw6aX_--oAOB0Mbc3+Do-TpNRPqGcC8YVQ@mail.gmail.com>
References: <1483467777-8651-1-git-send-email-caleb@signalessence.com>
 <20170104182712.d3vv47g4v5ylis5e@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org>
In-Reply-To: <20170104182712.d3vv47g4v5ylis5e@sirena.org.uk>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Errors-To: linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org>
To: Mark Brown <broonie@kernel.org>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Timur Tabi <timur@tabi.org>, Xiubo Li <Xiubo.Lee@gmail.com>, linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Nicolin Chen <nicoleotsuka@gmail.com>, Arnaud Mouiche <arnaud.mouiche@invoxia.com>, Fabio Estevam <fabio.estevam@nxp.com>, linuxppc-dev@lists.ozlabs.org
List-Id: alsa-devel@alsa-project.org

On Wed, Jan 4, 2017 at 10:27 AM, Mark Brown <broonie@kernel.org> wrote:
>
> On Tue, Jan 03, 2017 at 10:22:57AM -0800, Caleb Crome wrote:
> > From: Caleb Crome <caleb@crome.org>
> >
> > The fsl_ssi fifo watermark is by default set to 2 free spaces (i.e.
> > activate DMA on FIFO when only 2 spaces are left.)  This means the
>
> Please submit patches using subject lines reflecting the style for the
> subsystem.  This makes it easier for people to identify relevant
> patches.  Look at what existing commits in the area you're changing are
> doing and make sure your subject lines visually resemble what they're
> doing.

Shoot, yes of course.  I forgot to check the subject format against
extant patches.

The subject should be

[PATCH] ASoC: fsl_ssi: set fifo watermark to more reliable value

Correct?

Should I re-submit?

Thanks,
 -Caleb
