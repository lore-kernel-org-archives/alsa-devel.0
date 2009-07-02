From: pl bossart <bossart.nospam@gmail.com>
Subject: Re: RFC: Jack-detection control elements on HD-audio
Date: Thu, 2 Jul 2009 17:27:52 -0500
Message-ID: <6160a5130907021527t1eda60edx4646dacab586a276@mail.gmail.com>
References: <s5hk538ejj4.wl%tiwai@suse.de>
	<20090619095322.GC5270@sirena.org.uk> <s5h1vpgilhq.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-yx0-f177.google.com (mail-yx0-f177.google.com
	[209.85.210.177])
	by alsa0.perex.cz (Postfix) with ESMTP id 0D7391037F4
	for <alsa-devel@alsa-project.org>;
	Fri,  3 Jul 2009 00:27:53 +0200 (CEST)
Received: by yxe7 with SMTP id 7so529343yxe.16
	for <alsa-devel@alsa-project.org>; Thu, 02 Jul 2009 15:27:53 -0700 (PDT)
In-Reply-To: <s5h1vpgilhq.wl%tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Lennart Poettering <mznyfn@0pointer.de>
List-Id: alsa-devel@alsa-project.org

Takashi,
I looked at your code for jack sensing and I am really confused on how
these evolutions will be used.
It seems to me these additions with the new control apply only to the
HDAudio case. Meaning if Lennart modifies PulseAudio to read the jack
sensing information from the new control, Lennart's code will not work
on embedded platforms which rely on ASoC and plain snd_jack_report /
input layer (or any non-HDAudio based solution for that matter), and
we don't have a generic way to providing the jack information to
PulseAudio.
I had a private discussion with Mark where he stated that ASoC would
not change, and would automatically benefit from this additional
control. That does not seem to be the case.
Either I am missing something (not an unlikely scenario, I am
light-years from my comfort zone here) or everyone is on a different
wavelength.
Thanks for your feedback,
Cheers
- Pierre

On Fri, Jun 19, 2009 at 5:08 AM, Takashi Iwai<tiwai@suse.de> wrote:
>> It'd be nice to keep the input API interface as well - one of the
>> reasons I carried on with the existing input interface was that the
>> existing userspace stuff I found was using the input API in one way or
>> another. =A0In the embedded space it appears to have often been convenie=
nt
>> for people to read jack sense from a GPIO as part of a GPIO keyboard
>> they're already using which was part of the reason it was never really
>> joined up with ALSA in the past.
>
> Don't worry, it's kept as is. =A0The control elements are just
> additions.
