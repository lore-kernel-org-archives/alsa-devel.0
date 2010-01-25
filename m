From: shariff <shariffsinbox@gmail.com>
Subject: Re: Reg: Audio recording with twl4030 codec
Date: Mon, 25 Jan 2010 13:52:55 +0530
Message-ID: <1cbe56071001250022n66f271ecu66f12710c8b8e334@mail.gmail.com>
References: <1cbe56071001220157u5133ae91mf89dabb2f4da8fdb@mail.gmail.com>
	<1cbe56071001220459n511c41d7ya117ca8b19c11ae5@mail.gmail.com>
	<1cbe56071001242332r4fcf5a3dyd509750e39ca9377@mail.gmail.com>
	<201001251014.40494.peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pw0-f53.google.com (mail-pw0-f53.google.com
	[209.85.160.53])
	by alsa0.perex.cz (Postfix) with ESMTP id 7067A103840
	for <alsa-devel@alsa-project.org>; Mon, 25 Jan 2010 09:22:57 +0100 (CET)
Received: by pwi4 with SMTP id 4so6045261pwi.32
	for <alsa-devel@alsa-project.org>; Mon, 25 Jan 2010 00:22:55 -0800 (PST)
In-Reply-To: <201001251014.40494.peter.ujfalusi@nokia.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi Peter,

Thanks for you suggestions.

Regards,
Shariff

On Mon, Jan 25, 2010 at 1:44 PM, Peter Ujfalusi <peter.ujfalusi@nokia.com>w=
rote:

> Hello,
>
> Let's put alsa-devel back to the CC...
>
> On Monday 25 January 2010 09:32:45 ext shariff wrote:
> > Hi Peter,
> >
> > 1) As we only have one Main MIC when I am recording in stereo mode by
> >  specifying "-c 2", one channel is silent and one channel is recorded
> >  properly.
>
> As it should. Just as a sidenote, I'm usually using -f dat for the format,
> which
> gives 48KHz, stereo 16LE
>
> >
> > 2) But still the recorded channel is noisy, how can I reduce the noise =
of
> >  the recorded channel?
>
> Hmm, what kind of noise?
> How are you configuring the dai with the snd_soc_dai_set_fmt?
> For stereo it should be (if OMAP is slave, TWL is master):
> SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_NB_NF | SND_SOC_DAIFMT_CBM_CFM;
>
> For TDM mode (four channel):
> SND_SOC_DAIFMT_DSP_A | SND_SOC_DAIFMT_IB_NF | SND_SOC_DAIFMT_CBM_CFM;
>
> See omap3beagle.c how it is done.
>
> >
> > I have one more question. ( Regarding Audio path)
> >
> > --->  If I want to avoid that one channel silent, do I need to connect
> "SUB
> >  MIC or AUXR"?( as these are connected  right ADC).
>
> If you want audio data there, than yes you need another mic for the right
> channel.
>
> > ----> If I need to record 4 channel audio without any silent channel do=
 I
> >  need to connect digital microphones also?
>
> You can duplicate the channel 1 and 3 to channel 2 and 4, meaning that you
> route
> the ADCL and ADCR to these channels (TX1 and TX2 path are both analog).
> You can also hook up a stereo digital mic to the digimic1 interface, but
> remember, that the digimic needs 48KHz sampling rate.
>
> --
> P=E9ter
>
> >
> > Regards,
> > Shariff
> >
> > On Fri, Jan 22, 2010 at 6:29 PM, shariff
> >  <shariffsinbox@gmail.com<mailto:shariffsinbox@gmail.com>> wrote: Hi
> Peter,
> >
> > Thank you very much for your suggestions.
> >
> > Regards,
> > Shariff
> >
> >
> > On Fri, Jan 22, 2010 at 6:11 PM, Peter Ujfalusi
> >  <peter.ujfalusi@nokia.com<mailto:peter.ujfalusi@nokia.com>> wrote:
> Hello,
> >
> > On Friday 22 January 2010 11:57:23 ext shariff wrote:
> > > Hi all,
> > >
> > >         I am working with OMAP3 based custom board that has twl4030
> codec
> > > & using linux-2.6.29 kernel from opensource.
> >
> > This is kind of old...
> >
> > >         I have some queries regarding Audio recording.
> > >
> > >        Audio codec is connected to twl4030 as bellow
> > >
> > >                                   TWL4030
> > >
> > >                              |--------------------|
> > >                              |
> > >                              |                    |------ MAINMIC
> > >
> > >       McBSP2  ------  |i2s/tdm         |
> > >
> > >                              | ___________|
> > >
> > >       --> One Analog MIC is connected to Main Mic and I am using Audio
> > > path not the Voice path.
> > >
> > >            After selecting Main Mic through amixer control.
> > >
> > >            and recording audio using "arecord -c 1 -r 8000 -f S16_LE =
-t
> > > wav -d 20 record-file.wav"
> >
> > The hardware should have been opened in stereo mode, since it is not
> >  supporting the mono, you can verify it by appending -v to arecord and
> see
> >  how the HW has been opened at the end.
> >
> > >        --> Here record is successful but with lot of noise.
> > >
> > >           1) Can we record Mono(1 channel) through I2S from TWL4030
> > > codec?
> >
> > The TWL codec "Audio" path is either stereo or 4 channel.
> > You need to record stereo/4 channel, and than extract/use the data from
> the
> > valid channel.
> > In case of Main mic it is the left channel, or Channel 1 or/and 2
> >  (depending on the routings) in four channel mode.
> >
> > >           2) To record stereo(2 channels), do we need two Mic's ? (i.e
> do
> > > I need Sub Mic also).
> >
> > No you don't need. The right channel will not contain valid data (most
> >  likely it is going to be silent).
> >
> > You need to enable the Mic bias 1 for the main mic in your machine
> driver,
> >  if you have not done that yet:
> >
> > static const struct snd_soc_dapm_widget your_widgets[] =3D {
> > ...
> >        SND_SOC_DAPM_MIC("Your Mic", NULL),
> > ...
> > };
> >
> > static const struct snd_soc_dapm_route your_audio_map[] =3D {
> > ...
> >        {"MAINMIC", NULL, "Mic Bias 1"},
> >        {"Mic Bias 1", NULL, "Your Mic"},
> > ...
> > };
> >
> > I'm not sure about the state of the twl soc codec driver in 2.6.29, but
> my
> >  guess is that it should work.
> >
> > Are there any capture routing option for TX1 path, which selects between
> >  Analog and Digimic0? If there is than that has to be set to analog as
> >  well.
> >
> > > Regards,
> > > Shariff
> >
> > --
> > P=E9ter
> >
>
