From: Felix Homann <linuxaudio@showlabor.de>
Subject: Re: [PATCH 1/7] Unify M-Audio Fast Track Ultra and
	Ebox-44 mixer quirks.
Date: Mon, 23 Apr 2012 18:00:03 +0200
Message-ID: <CAFz=ag5PzRJ1eaV819kBtmnfGpM_b+xKBwHaNidd7wxBtK4vMQ@mail.gmail.com>
References: <1335191857-6725-1-git-send-email-linuxaudio@showlabor.de>
	<1335191857-6725-2-git-send-email-linuxaudio@showlabor.de>
	<s5hipgq5vz3.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <s5hipgq5vz3.wl%tiwai@suse.de>
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

Hi,

2012/4/23 Takashi Iwai <tiwai@suse.de>:
> At Mon, 23 Apr 2012 16:37:31 +0200,
> Felix Homann wrote:
>>
>> + =A0 =A0 /* set TLV */
>> + =A0 =A0 if (!tlv_callback) {
>
> I guess you want without !, no?

you're absolutely right.


>> + =A0 =A0 snd_create_std_mono_ctl(mixer, 10, 2, 0x2, USB_MIXER_S16,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "Input B Captu=
re Volume", NULL);
>
> It would be safer to check the error of each call, but then it'd be
> better to make a table and loop over it. =A0You can create a new patch
> for that.

Please, tell Mark Hills. It's his patch you applied a couple of days
ago. I just renamed the functions and added the 'NULL' at the end of
the calls.

Regards,

Felix
