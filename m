From: "Sebastian H." <vand2@gmx.de>
Subject: Re: Alsamixer-Qt4 0.4.0 released
Date: Mon, 09 Aug 2010 16:08:26 +0200
Message-ID: <4C600BDA.5090400@gmx.de>
References: <4C595A52.7030401@gmx.de>
	<AANLkTin0b0yBvVeVEGrWdkXUYh1J5Hwvj7Hu29iw3oV2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.gmx.net (mailout-de.gmx.net [213.165.64.23])
	by alsa0.perex.cz (Postfix) with SMTP id 8B960103817
	for <alsa-devel@alsa-project.org>;
	Mon,  9 Aug 2010 16:12:29 +0200 (CEST)
In-Reply-To: <AANLkTin0b0yBvVeVEGrWdkXUYh1J5Hwvj7Hu29iw3oV2@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Niels Mayer <nielsmayer@gmail.com>
Cc: ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hello Niels

> This mixer is a major improvement over alsamixergui and alsamixer.

That's good to hear. It always bugged me that certain things that are
supposed to be simple can be extraordinary complicated in linux. Like
altering the output/input volume.

> Unfortunately with envy24-based soundcards, it doesn't do the right
> thing w/r/t the ice1712's built-in digital mixer (
> http://nielsmayer.com/envy24control/envy24mixer-architecture.png ).
> There's up to eight pairs of input monitors and PCM output monitors
> that feed the mixer through L/R sliders that look like:
> http://nielsmayer.com/envy24control/Mudita24-102-Monitor-Inputs.png
> http://nielsmayer.com/envy24control/Mudita24-102-Monitor-Outputs.png
> (Application shown in screenshots is envy24control modification known
> as "mudita24"
>  http://nielsmayer.com/envy24control/mudita24-1.0.3.tar.gz . )
> 
> In alsamixer-qt4, both the left and right sides of these attenuators
> are controlled simultaneously, rather than individually. Likewise, the
> mutes are controlled simultaneously when they should be individually
> controllable left and right. Note that each of these controls has a
> front left capture and a front right capture that must be controlled
> individually.

Ok, I thought that the main area - for simplicity - should only contain
combined mono sliders and if people really want to alter channels they
could use the channel mixer (button on the sidebar).

But if a combined mono slider is not appropriate at all for a
multi channel element I wonder how get to known about it from
the ALSA API. Or to put in an other way: When should all channel
sliders be displayed instead of a combined mono slider?
Is it when
  snd_mixer_selem_has_playback_volume_joined ( elem ) == 0?
or when
  snd_mixer_selem_is_capture_mono ( elem ) == 0?
or must there be a string comparison plus element
database in the mixer application (not desireable IMHO)?


> Furthermore, there appears to be a bug alsamixer-qt4 in
> that it takes the value for the left setting for one channel (ie.
> shows 100%) and then for the next it takes the setting for the right
> (i.e. shows 0%). This gives an alternating pattern of sliders and
> mutes that doesn't correspond to the alsa values. Of course, once
> alsamixer-qt4 changes the values, then you have to go back in
> envy24control and fix all values where left and right sides got set to
> same value. http://nielsmayer.com/envy24control/Screenshot-Alsamixer-Qt4.png
> is what it looks like.

For the combined sliders the left channel value is take because
SND_MIXER_SCHN_MONO == SND_MIXER_SCHN_FRONT_LEFT
and on a slider change all channel values are adjusted.
That seemed to me the most appropriate behaviour for a combined slider.
And if a combined slider is the wrong choice for ane element it's again
the question mentioned above.

As far as I can see the alsamixer-qt4 screenshot shows the
same value for the left channel as in the Mudita24 screenshot.
The alternating of the left channel is present there, too.


> (Btw "Delta IEC958 Input Status" should not be "writeable" -- it's a
> status indicator, but in alsamixer-qt4, it doesn't turn on when then
> digital input has signal).

Ok, this surely can be fixed, too. But how do I know that an element is
not writeable.

Best,
Sebastian
