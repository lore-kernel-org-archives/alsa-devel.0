From: =?ISO-8859-1?Q?Andr=E9_Prado?= <andreprado88@gmail.com>
Subject: Retrieving the number of input channels on a sound card
Date: Wed, 8 Jun 2011 11:18:28 -0300
Message-ID: <BANLkTi=Arh13UZ67DTEnpvNtdPzfuSrtng@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pz0-f51.google.com (mail-pz0-f51.google.com
	[209.85.210.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 7051D103929
	for <alsa-devel@alsa-project.org>;
	Wed,  8 Jun 2011 16:18:30 +0200 (CEST)
Received: by pzk26 with SMTP id 26so276717pzk.38
	for <alsa-devel@alsa-project.org>; Wed, 08 Jun 2011 07:18:28 -0700 (PDT)
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

Hello. I am new to Alsa programming and i want to get the number of
input channels on an audio device.
I am reading a lot of tutorials and documentations but i am struggling
to do this.

Here is a code i've saw to  Lists the hardware names of MIDI output
device/sub-devices. I've understood it. But i want to get the number
of input channels.

Any help is appreciated. THanks

// listmidi.c
// Lists the hardware names of MIDI output device/sub-devices
// upon each ALSA sound card in the system.
//
// Compile as:
// gcc -o listmidi listmidi.c -lasound

#include <stdio.h>
#include <string.h>
#include <alsa/asoundlib.h>

int main(int argc, char **argv)
{
   register int  err;
   int           cardNum;

   // Start with first card
   cardNum =3D -1;

   for (;;)
   {
      snd_ctl_t *cardHandle;

      // Get next sound card's card number. When "cardNum" =3D=3D -1, then =
ALSA
      // fetches the first card
      if ((err =3D snd_card_next(&cardNum)) < 0)
      {
         printf("Can't get the next card number: %s\n", snd_strerror(err));
         break;
      }

      // No more cards? ALSA sets "cardNum" to -1 if so
      if (cardNum < 0) break;

      // Open this card's control interface. We specify only the card
number -- not
      // any device nor sub-device too
      {
      char   str[64];

      sprintf(str, "hw:%i", cardNum);
      if ((err =3D snd_ctl_open(&cardHandle, str, 0)) < 0)
      {
         printf("Can't open card %i: %s\n", cardNum, snd_strerror(err));
         continue;
      }
      }

      {
      int      devNum;

      // Start with the first MIDI device on this card
      devNum =3D -1;
		=

      for (;;)
      {
         snd_rawmidi_info_t  *rawMidiInfo;
         register int        subDevCount, i;

         // Get the number of the next MIDI device on this card
         if ((err =3D snd_ctl_rawmidi_next_device(cardHandle, &devNum)) < 0)
         {
            printf("Can't get next MIDI device number: %s\n",
snd_strerror(err));
            break;
         }

         // No more MIDI devices on this card? ALSA sets "devNum" to -1 if =
so.
         // NOTE: It's possible that this sound card may have no MIDI
devices on it
         // at all, for example if it's only a digital audio card
         if (devNum < 0) break;

         // To get some info about the subdevices of this MIDI device
(on the card), we need a
         // snd_rawmidi_info_t, so let's allocate one on the stack
         snd_rawmidi_info_alloca(&rawMidiInfo);
         memset(rawMidiInfo, 0, snd_rawmidi_info_sizeof());

         // Tell ALSA which device (number) we want info about
         snd_rawmidi_info_set_device(rawMidiInfo, devNum);

         // Get info on the MIDI outs of this device
         snd_rawmidi_info_set_stream(rawMidiInfo, SND_RAWMIDI_STREAM_OUTPUT=
);

         i =3D -1;
         subDevCount =3D 1;

         // More subdevices?
         while (++i < subDevCount)
         {
            // Tell ALSA to fill in our snd_rawmidi_info_t with info
on this subdevice
            snd_rawmidi_info_set_subdevice(rawMidiInfo, i);
            if ((err =3D snd_ctl_rawmidi_info(cardHandle, rawMidiInfo)) < 0)
            {
               printf("Can't get info for MIDI output subdevice
hw:%i,%i,%i: %s\n", cardNum, devNum, i, snd_strerror(err));
               continue;
            }

            // Print out how many subdevices (once only)
            if (!i)
            {
               subDevCount =3D snd_rawmidi_info_get_subdevices_count(rawMid=
iInfo);
               printf("\nFound %i MIDI output subdevices on card
%i\n", subDevCount, cardNum);
            }

            // NOTE: If there's only one subdevice, then the subdevice
number is immaterial,
            // and can be omitted when you specify the hardware name
            printf((subDevCount > 1 ? "    hw:%i,%i,%i\n" : "
hw:%i,%i\n"), cardNum, devNum, i);
         }
      }
      }

      // Close the card's control interface after we're done with it
      snd_ctl_close(cardHandle);
   }

   snd_config_update_free_global();
}

-- =

Att
Andr=E9
