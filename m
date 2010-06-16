From: Manuel Lauss <manuel.lauss@googlemail.com>
Subject: Re: [PATCH RFC 1/3] sound: ac97: Add GPIO manipulation
	hooks
Date: Wed, 16 Jun 2010 10:00:19 +0200
Message-ID: <AANLkTik3PHoo-1Is-yrzzTRjeH9G7v8LUgqxBzgVRQDi__40464.7348019809$1276675229$gmane$org@mail.gmail.com>
References: <1276617347-3522-1-git-send-email-manuel.lauss@googlemail.com>
	<1276617347-3522-2-git-send-email-manuel.lauss@googlemail.com>
	<20100615160253.GK14510@rakim.wolfsonmicro.main>
	<s5h1vc7o1i3.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <s5h1vc7o1i3.wl%tiwai@suse.de>
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
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, alsa-devel@vger.kernel.org, linux-input@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Wed, Jun 16, 2010 at 9:55 AM, Takashi Iwai <tiwai@suse.de> wrote:
>> > =A0include/sound/ac97_codec.h | =A0 =A02 ++
>> > =A01 files changed, 2 insertions(+), 0 deletions(-)
>> >
>> > diff --git a/include/sound/ac97_codec.h b/include/sound/ac97_codec.h
>> > index 4940045..db3aee1 100644
>> > --- a/include/sound/ac97_codec.h
>> > +++ b/include/sound/ac97_codec.h
>> > @@ -437,6 +437,8 @@ struct snd_ac97_bus_ops {
>> > =A0 =A0 unsigned short (*read) (struct snd_ac97 *ac97, unsigned short =
reg);
>> > =A0 =A0 void (*wait) (struct snd_ac97 *ac97);
>> > =A0 =A0 void (*init) (struct snd_ac97 *ac97);
>> > + =A0 void (*setgpio) (struct snd_ac97 *ac97, unsigned short gpio);
>> > + =A0 unsigned short (*getgpio) (struct snd_ac97 *ac97);
>
> Can this be handled simply in read/write callbacks in the controller
> side? =A0In callbacks, you can check whether reg =3D=3D AC97_GPIO_STATUS =
and
> handle differently for such an access.

Interesting Idea, and as a bonus requires no changes to the wm97xx code.

Thank you!
      Manuel Lauss
