From: Nicholas Smethurst <nick.smethurst@gmail.com>
Subject: Re: Getting a full device list
Date: Mon, 14 May 2007 10:36:48 +0200
Message-ID: <46481FA0.8050803@gmail.com>
References: <560009e30704190730q1047b43fh37f5df5fef9ec51f@mail.gmail.com>	<75b66ecd0704190846g4036b493q8d7c2bec8cdc08b2@mail.gmail.com>	<4627B015.7030401@gmail.com>	<75b66ecd0704191145u3414a5e6id9e3f10ef9c6b854@mail.gmail.com>	<4644455B.4080706@gmail.com>	<Pine.LNX.4.61.0705111233090.7579@tm8103.perex-int.cz>	<46444E00.1040808@gmail.com>
	<s5hfy63iea8.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ug-out-1314.google.com (ug-out-1314.google.com [66.249.92.172])
	by alsa0.perex.cz (Postfix) with ESMTP id D8FB82470B
	for <alsa-devel@alsa-project.org>;
	Mon, 14 May 2007 10:36:53 +0200 (CEST)
Received: by ug-out-1314.google.com with SMTP id j3so914555ugf
	for <alsa-devel@alsa-project.org>; Mon, 14 May 2007 01:36:53 -0700 (PDT)
In-Reply-To: <s5hfy63iea8.wl%tiwai@suse.de>
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

Takashi Iwai wrote:
> You can override the values easily in user configuration, e.g. by
> adding the following line to ~/.asoundrc:
> 
> 	defaults.namehist.showall	on
> 
> To force to override even the variable type, you can add '!' modifier,
> 
> 	defaults.namehist.!showall	1
> 

Well I tried doing both of the above in ~/.asoundrc, but I'm still not getting
any listing of the pcm hw or plughw devices, or any plugins.

The only thing that changes is the addition the following when calling the
hints function with "hwdep":

    hw:CARD=PAD
       RME Digi96/8 PAD

    hw:CARD=UART
       MPU-401 UART

    hw:CARD=V8237
       VIA 8237

I'm not sure what hwdep means exactly.. Are these also pcm devices?

Here's my test application.. Is there anything wrong here?

#include <alsa/asoundlib.h>
#include <iostream>

int main()
{
    size_t start, end;
    std::string desc;
    void ** hints, ** str_c;
    char * name_c, * desc_c;
    int index = 0;
    const char * ifaces[] = {
        "card", "pcm", "rawmidi", "timer", "seq", "hwdep", 0
    };

    snd_config_update();

    while (ifaces[index]) {
        std::cout << "---- Trying \"" << ifaces[index] << "\" ----\n\n";
        if (snd_device_name_hint(-1, ifaces[index], &hints) < 0) {
            std::cerr << "hint failed on \"" << ifaces[index] << "\"\n\n";
            ++index;
            continue;
        }

        str_c = hints;
        while (*str_c) {
            name_c = snd_device_name_get_hint(*str_c, "NAME");
            desc_c = snd_device_name_get_hint(*str_c, "DESC");

            std::cout << name_c << "\n";
            start = 0;
            desc = desc_c;
            do {
                end = desc.find("\n", start);
                std::cout << "   " << desc.substr(start, end - start) << "\n";
                start = end + 1;
            } while (end != std::string::npos);
            std::cout << "\n";
            free(name_c);
            free(desc_c);
            ++str_c;
        }
        snd_device_name_free_hint(hints);
        ++index;
    }
    return 0;
}


My system has two soundcards: an RME Digi96/8 PAD and an onboard VIA. The RME
has two devices, and the VIA four.

The result of the test application with showall set to on is the following:

---- Trying "card" ----

hint failed on "card"

---- Trying "pcm" ----

default:CARD=PAD
   RME Digi96/8 PAD, Digi96 IEC958
   Default Audio Device

null
   Discard all samples (playback) or generate zero samples (capture)

default:CARD=UART
   MPU-401 UART
   Default Audio Device

default:CARD=V8237
   VIA 8237, VIA 8237
   Default Audio Device

front:CARD=V8237,DEV=0
   VIA 8237, VIA 8237
   Front speakers

surround40:CARD=V8237,DEV=0
   VIA 8237, VIA 8237
   4.0 Surround output to Front and Rear speakers

surround41:CARD=V8237,DEV=0
   VIA 8237, VIA 8237
   4.1 Surround output to Front, Rear and Subwoofer speakers

surround50:CARD=V8237,DEV=0
   VIA 8237, VIA 8237
   5.0 Surround output to Front, Center and Rear speakers

surround51:CARD=V8237,DEV=0
   VIA 8237, VIA 8237
   5.1 Surround output to Front, Center, Rear and Subwoofer speakers

iec958:CARD=V8237,DEV=0
   VIA 8237, VIA 8237
   IEC958 (S/PDIF) Digital Audio Output

---- Trying "rawmidi" ----

hw:CARD=PAD
   RME Digi96/8 PAD
   Direct rawmidi driver device

hw:CARD=UART,DEV=0
   MPU-401 UART, MPU-401 UART MIDI
   Direct rawmidi driver device

hw:CARD=V8237
   VIA 8237
   Direct rawmidi driver device

---- Trying "timer" ----

---- Trying "seq" ----

---- Trying "hwdep" ----

hw:CARD=PAD
   RME Digi96/8 PAD

hw:CARD=UART
   MPU-401 UART

hw:CARD=V8237
   VIA 8237
