From: Felix Homann <linuxaudio@showlabor.de>
Subject: Re: [PATCH 1/3] Unify M-Audio Fast Track Ultra and
	Ebox-44 mixer quirks.
Date: Mon, 23 Apr 2012 11:57:32 +0200
Message-ID: <CAFz=ag4aCsmhsRzSicL3u9RkQsuxy6WOaHv=HX-CGgMJp-M-vg@mail.gmail.com>
References: <1335172568-13502-1-git-send-email-linuxaudio@showlabor.de>
	<1335172568-13502-2-git-send-email-linuxaudio@showlabor.de>
	<s5hwr562380.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <s5hwr562380.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, patch@alsa-project.org, mark@pogo.org.uk
List-Id: alsa-devel@alsa-project.org

2012/4/23 Takashi Iwai <tiwai@suse.de>:
>> Allows for specifying a TLV callback.
>
> Too little information as the patch changelog.
> Please be more specific what and how is implemented there.

OK.

> This should be snd_create_std_mono_ctl(), no?

Yes, I wasn't aware that I had only fixed this in a later commit.

> Each patch should be able to be built properly. =A0Otherwise it breaks
> the bisection.

Yes, that makes sense.


>> +/* Create a volume control for FTU devices*/
>> +static int snd_maudio_ftu_create_volume_ctls(struct usb_mixer_interface=
 *mixer)
>> =A0{
>> =A0 =A0 =A0 char name[64];
>> - =A0 =A0 int in, out, err;
>> + =A0 =A0 unsigned int id, control, cmask;
>> + =A0 =A0 int in, out, err, val_type;
>> +
>> + =A0 =A0 id =3D 5;
>> + =A0 =A0 val_type =3D USB_MIXER_S16;
>
> Give const. =A0I don't mind use such styles instead of define or
> hard-coded in the function calls, but then it should be marked as
> const properly.

I don't mind to use a define here. Just tell me what you prefer.

I'll prepare a coreccted patch set soon.

Regards,

Felix
