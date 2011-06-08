From: =?ISO-8859-1?Q?Andr=E9_Prado?= <andreprado88@gmail.com>
Subject: Re: Retrieving the number of input channels on a sound
	card
Date: Wed, 8 Jun 2011 16:20:10 -0300
Message-ID: <BANLkTinzkkZuryF-=Xqar5dh0vV-L6q6Lw@mail.gmail.com>
References: <BANLkTi=Arh13UZ67DTEnpvNtdPzfuSrtng@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pv0-f179.google.com (mail-pv0-f179.google.com
	[74.125.83.179]) by alsa0.perex.cz (Postfix) with ESMTP id 30BB12457F
	for <alsa-devel@alsa-project.org>;
	Wed,  8 Jun 2011 21:20:12 +0200 (CEST)
Received: by pvf33 with SMTP id 33so411836pvf.38
	for <alsa-devel@alsa-project.org>; Wed, 08 Jun 2011 12:20:11 -0700 (PDT)
In-Reply-To: <BANLkTi=Arh13UZ67DTEnpvNtdPzfuSrtng@mail.gmail.com>
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
List-Id: alsa-devel@alsa-project.org

I Found it out.. hope it helps someone.

    snd_pcm_t *capture_handle;
    snd_pcm_hw_params_t *hw_params;

    snd_pcm_open( &capture_handle, str, SND_PCM_STREAM_PLAYBACK, 0 );
    snd_pcm_hw_params_malloc (&hw_params);

    snd_pcm_hw_params_any(capture_handle, hw_params);

    unsigned int num_canais =3D 0;
    int ret;

    ret =3D snd_pcm_hw_params_get_channels(hw_params, &num_canais);

    printf("Number of channels: %i\n",num_canais);



2011/6/8 Andr=E9 Prado <andreprado88@gmail.com>:
> Hello. I am new to Alsa programming and i want to get the number of
> input channels on an audio device.
> I am reading a lot of tutorials and documentations but i am struggling
> to do this.
>
> Here is a code i've saw to =A0Lists the hardware names of MIDI output
> device/sub-devices. I've understood it. But i want to get the number
> of input channels.
>
> Any help is appreciated. THanks
>
> // listmidi.c
> // Lists the hardware names of MIDI output device/sub-devices
> // upon each ALSA sound card in the system.
> //
> // Compile as:
> // gcc -o listmidi listmidi.c -lasound
>
> #include <stdio.h>
> #include <string.h>
> #include <alsa/asoundlib.h>
>
> int main(int argc, char **argv)
> {
> =A0 register int =A0err;
> =A0 int =A0 =A0 =A0 =A0 =A0 cardNum;
>
> =A0 // Start with first card
> =A0 cardNum =3D -1;
>
> =A0 for (;;)
> =A0 {
> =A0 =A0 =A0snd_ctl_t *cardHandle;
>
> =A0 =A0 =A0// Get next sound card's card number. When "cardNum" =3D=3D -1=
, then ALSA
> =A0 =A0 =A0// fetches the first card
> =A0 =A0 =A0if ((err =3D snd_card_next(&cardNum)) < 0)
> =A0 =A0 =A0{
> =A0 =A0 =A0 =A0 printf("Can't get the next card number: %s\n", snd_strerr=
or(err));
> =A0 =A0 =A0 =A0 break;
> =A0 =A0 =A0}
>
> =A0 =A0 =A0// No more cards? ALSA sets "cardNum" to -1 if so
> =A0 =A0 =A0if (cardNum < 0) break;
>
> =A0 =A0 =A0// Open this card's control interface. We specify only the card
> number -- not
> =A0 =A0 =A0// any device nor sub-device too
> =A0 =A0 =A0{
> =A0 =A0 =A0char =A0 str[64];
>
> =A0 =A0 =A0sprintf(str, "hw:%i", cardNum);
> =A0 =A0 =A0if ((err =3D snd_ctl_open(&cardHandle, str, 0)) < 0)
> =A0 =A0 =A0{
> =A0 =A0 =A0 =A0 printf("Can't open card %i: %s\n", cardNum, snd_strerror(=
err));
> =A0 =A0 =A0 =A0 continue;
> =A0 =A0 =A0}
> =A0 =A0 =A0}
>
> =A0 =A0 =A0{
> =A0 =A0 =A0int =A0 =A0 =A0devNum;
>
> =A0 =A0 =A0// Start with the first MIDI device on this card
> =A0 =A0 =A0devNum =3D -1;
>
> =A0 =A0 =A0for (;;)
> =A0 =A0 =A0{
> =A0 =A0 =A0 =A0 snd_rawmidi_info_t =A0*rawMidiInfo;
> =A0 =A0 =A0 =A0 register int =A0 =A0 =A0 =A0subDevCount, i;
>
> =A0 =A0 =A0 =A0 // Get the number of the next MIDI device on this card
> =A0 =A0 =A0 =A0 if ((err =3D snd_ctl_rawmidi_next_device(cardHandle, &dev=
Num)) < 0)
> =A0 =A0 =A0 =A0 {
> =A0 =A0 =A0 =A0 =A0 =A0printf("Can't get next MIDI device number: %s\n",
> snd_strerror(err));
> =A0 =A0 =A0 =A0 =A0 =A0break;
> =A0 =A0 =A0 =A0 }
>
> =A0 =A0 =A0 =A0 // No more MIDI devices on this card? ALSA sets "devNum" =
to -1 if so.
> =A0 =A0 =A0 =A0 // NOTE: It's possible that this sound card may have no M=
IDI
> devices on it
> =A0 =A0 =A0 =A0 // at all, for example if it's only a digital audio card
> =A0 =A0 =A0 =A0 if (devNum < 0) break;
>
> =A0 =A0 =A0 =A0 // To get some info about the subdevices of this MIDI dev=
ice
> (on the card), we need a
> =A0 =A0 =A0 =A0 // snd_rawmidi_info_t, so let's allocate one on the stack
> =A0 =A0 =A0 =A0 snd_rawmidi_info_alloca(&rawMidiInfo);
> =A0 =A0 =A0 =A0 memset(rawMidiInfo, 0, snd_rawmidi_info_sizeof());
>
> =A0 =A0 =A0 =A0 // Tell ALSA which device (number) we want info about
> =A0 =A0 =A0 =A0 snd_rawmidi_info_set_device(rawMidiInfo, devNum);
>
> =A0 =A0 =A0 =A0 // Get info on the MIDI outs of this device
> =A0 =A0 =A0 =A0 snd_rawmidi_info_set_stream(rawMidiInfo, SND_RAWMIDI_STRE=
AM_OUTPUT);
>
> =A0 =A0 =A0 =A0 i =3D -1;
> =A0 =A0 =A0 =A0 subDevCount =3D 1;
>
> =A0 =A0 =A0 =A0 // More subdevices?
> =A0 =A0 =A0 =A0 while (++i < subDevCount)
> =A0 =A0 =A0 =A0 {
> =A0 =A0 =A0 =A0 =A0 =A0// Tell ALSA to fill in our snd_rawmidi_info_t wit=
h info
> on this subdevice
> =A0 =A0 =A0 =A0 =A0 =A0snd_rawmidi_info_set_subdevice(rawMidiInfo, i);
> =A0 =A0 =A0 =A0 =A0 =A0if ((err =3D snd_ctl_rawmidi_info(cardHandle, rawM=
idiInfo)) < 0)
> =A0 =A0 =A0 =A0 =A0 =A0{
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 printf("Can't get info for MIDI output subdev=
ice
> hw:%i,%i,%i: %s\n", cardNum, devNum, i, snd_strerror(err));
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 continue;
> =A0 =A0 =A0 =A0 =A0 =A0}
>
> =A0 =A0 =A0 =A0 =A0 =A0// Print out how many subdevices (once only)
> =A0 =A0 =A0 =A0 =A0 =A0if (!i)
> =A0 =A0 =A0 =A0 =A0 =A0{
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 subDevCount =3D snd_rawmidi_info_get_subdevic=
es_count(rawMidiInfo);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 printf("\nFound %i MIDI output subdevices on =
card
> %i\n", subDevCount, cardNum);
> =A0 =A0 =A0 =A0 =A0 =A0}
>
> =A0 =A0 =A0 =A0 =A0 =A0// NOTE: If there's only one subdevice, then the s=
ubdevice
> number is immaterial,
> =A0 =A0 =A0 =A0 =A0 =A0// and can be omitted when you specify the hardwar=
e name
> =A0 =A0 =A0 =A0 =A0 =A0printf((subDevCount > 1 ? " =A0 =A0hw:%i,%i,%i\n" =
: "
> hw:%i,%i\n"), cardNum, devNum, i);
> =A0 =A0 =A0 =A0 }
> =A0 =A0 =A0}
> =A0 =A0 =A0}
>
> =A0 =A0 =A0// Close the card's control interface after we're done with it
> =A0 =A0 =A0snd_ctl_close(cardHandle);
> =A0 }
>
> =A0 snd_config_update_free_global();
> }
>
> --
> Att
> Andr=E9
>



-- =

Att
Andr=E9
