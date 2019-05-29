From: Chen-Yu Tsai <wens@csie.org>
Subject: Re: [PATCH v2] ASoC: sun4i-codec: fix first delay on Speaker
Date: Wed, 29 May 2019 20:14:59 +0800
Message-ID: <CAGb2v67dFY+CYBLMe2p9tq6eS9J-SJqAgF-APGdXVjcqbp2Kxw@mail.gmail.com>
References: <1559040459-16488-1-git-send-email-georgii.staroselskii@emlid.com>
 <CAGb2v64osE5yVdpCxSRfpkaq2TqeUUiLUbr3wZWW1rawuqxW-Q@mail.gmail.com>
 <20190529102824.GN2456@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20190529102824.GN2456@sirena.org.uk>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Mark Brown <broonie@kernel.org>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Maxime Ripard <maxime.ripard@bootlin.com>, Danny Milosavljevic <dannym@scratchpost.org>, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, Georgii Staroselskii <georgii.staroselskii@emlid.com>, Jaroslav Kysela <perex@perex.cz>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
List-Id: alsa-devel@alsa-project.org

On Wed, May 29, 2019 at 6:28 PM Mark Brown <broonie@kernel.org> wrote:
>
> On Wed, May 29, 2019 at 10:34:25AM +0800, Chen-Yu Tsai wrote:
>
> > I wonder if we shouldn't just keep the amplifier section powered up
> > all the time.
> > Also it seems not very many codec drivers go all out with DAPM.
>
> Leaving the amplifier powered up all the time is going to burn a lot of
> power and make any pop/click issues in the inputs more apparent.

Sounds like this patch is a better compromise. Thanks for the insight.

The patch is

Reviewed-by: Chen-Yu Tsai <wens@csie.org>
