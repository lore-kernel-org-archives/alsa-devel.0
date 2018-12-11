From: Andy Shevchenko <andriy.shevchenko@intel.com>
Subject: Re: [PATCH v3 02/14] ASoC: SOF: Add Sound Open
 Firmware KControl support
Date: Wed, 12 Dec 2018 01:25:44 +0200
Message-ID: <20181211232544.GP10650@smile.fi.intel.com>
References: <20181211212318.28644-1-pierre-louis.bossart@linux.intel.com>
 <20181211212318.28644-3-pierre-louis.bossart@linux.intel.com>
 <20181211222308.GH10650@smile.fi.intel.com>
 <f89f955d-ff90-a027-4046-e1861e59e203@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Content-Disposition: inline
In-Reply-To: <f89f955d-ff90-a027-4046-e1861e59e203@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: alsa-devel@alsa-project.org, Seppo Ingalsuo <seppo.ingalsuo@linux.intel.com>, tiwai@suse.de, Daniel Baluta <daniel.baluta@gmail.com>, liam.r.girdwood@linux.intel.com, vkoul@kernel.org, broonie@kernel.org, sound-open-firmware@alsa-project.org, Alan Cox <alan@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

On Tue, Dec 11, 2018 at 04:48:37PM -0600, Pierre-Louis Bossart wrote:
> > > +	max_size =3D (be->max < max_size) ? be->max : max_size;
> > min() / max() ?
> =

> Good catch, this can be simplified.
> =

> Not sure I like max_size =3D min (be->max, max_size), it's confusing.

Hmm... It shows intention. For _max size_ you choose _minimum_ value out of=
 two.

> =

> Maybe
> =

> if (be->max < max_size)
> =

> =A0=A0=A0 max_size =3D be->max;

It's minor, just choose one style and use it.

-- =

With Best Regards,
Andy Shevchenko
