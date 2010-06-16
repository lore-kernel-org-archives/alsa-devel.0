From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH RFC 1/3] sound: ac97: Add GPIO manipulation
	hooks
Date: Wed, 16 Jun 2010 13:52:13 +0100
Message-ID: <20100616125213.GA24491__46372.3247209147$1276692750$gmane$org@rakim.wolfsonmicro.main>
References: <1276617347-3522-1-git-send-email-manuel.lauss@googlemail.com>
	<1276617347-3522-2-git-send-email-manuel.lauss@googlemail.com>
	<20100615160253.GK14510@rakim.wolfsonmicro.main>
	<s5h1vc7o1i3.wl%tiwai@suse.de>
	<AANLkTik3PHoo-1Is-yrzzTRjeH9G7v8LUgqxBzgVRQDi@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Content-Disposition: inline
In-Reply-To: <AANLkTik3PHoo-1Is-yrzzTRjeH9G7v8LUgqxBzgVRQDi@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@vger.kernel.org, linux-input@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Wed, Jun 16, 2010 at 10:00:19AM +0200, Manuel Lauss wrote:
> On Wed, Jun 16, 2010 at 9:55 AM, Takashi Iwai <tiwai@suse.de> wrote:

> >> > + =A0 void (*setgpio) (struct snd_ac97 *ac97, unsigned short gpio);
> >> > + =A0 unsigned short (*getgpio) (struct snd_ac97 *ac97);

> > Can this be handled simply in read/write callbacks in the controller
> > side? =A0In callbacks, you can check whether reg =3D=3D AC97_GPIO_STATU=
S and
> > handle differently for such an access.

> Interesting Idea, and as a bonus requires no changes to the wm97xx code.

The only thing that worries me there is any non-standard behavior the
chip may implement - it may actually want a write to that register for
some extended functionality.
