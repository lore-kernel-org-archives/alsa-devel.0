From: "Alexander E. Patrakov" <patrakov@gmail.com>
Subject: Re: What-did-you-plugin-dialog
Date: Sun, 1 Dec 2013 10:51:29 +0600
Message-ID: <CAN_LGv0F6g6L41Se72zdaq4u0DAPJzRc4ZwCMqPPJ06TCFS=qA@mail.gmail.com>
References: <52947A6E.6010302@canonical.com>
	<1385470453.2226.26.camel@tkkaskin-mobl2.ger.corp.intel.com>
	<52949CCA.2060601@canonical.com>
	<1385473638.2226.48.camel@tkkaskin-mobl2.ger.corp.intel.com>
	<52951347.9000200@canonical.com> <5295A121.2010202@gmail.com>
	<5295A7C2.2090100@canonical.com>
	<CAN_LGv1F4cTB2cK+rL30N3nbbwyxi23cLYHR6emMC5CbNLP4jQ@mail.gmail.com>
	<CAN_LGv0y2WcYMn8M5rjT1d-2jahh_u-W2D_LnRkMsXXD=ENzdA@mail.gmail.com>
	<CAN8cciZ-y397dLGV_xC3xibo3PY9aE-RYQEB4_dkwRtzN+JnqQ@mail.gmail.com>
	<CAN_LGv02cPydDkvP-AZ+EzkF9TVvm1ij0-6vjzp0YWbieg7_fQ@mail.gmail.com>
	<CAN8cciYnQZQzyRmz_=gLLF6w7p3CZbZPKwYZtJpTHEaN3UOt_Q@mail.gmail.com>
Reply-To: General PulseAudio Discussion
	<pulseaudio-discuss@lists.freedesktop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <pulseaudio-discuss-bounces@lists.freedesktop.org>
In-Reply-To: <CAN8cciYnQZQzyRmz_=gLLF6w7p3CZbZPKwYZtJpTHEaN3UOt_Q@mail.gmail.com>
List-Unsubscribe: <http://lists.freedesktop.org/mailman/options/pulseaudio-discuss>,
	<mailto:pulseaudio-discuss-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <http://lists.freedesktop.org/archives/pulseaudio-discuss>
List-Post: <mailto:pulseaudio-discuss@lists.freedesktop.org>
List-Help: <mailto:pulseaudio-discuss-request@lists.freedesktop.org?subject=help>
List-Subscribe: <http://lists.freedesktop.org/mailman/listinfo/pulseaudio-discuss>,
	<mailto:pulseaudio-discuss-request@lists.freedesktop.org?subject=subscribe>
Sender: pulseaudio-discuss-bounces@lists.freedesktop.org
Errors-To: pulseaudio-discuss-bounces@lists.freedesktop.org
To: General PulseAudio Discussion <pulseaudio-discuss@lists.freedesktop.org>
Cc: Takashi Iwai <tiwai@suse.de>, ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

2013/12/1 Raymond Yau <superquad.vortex2@gmail.com>:
> :
>>
>>
>> > can post the output of alsa-info.sh after jack retasking ?
>>
>> Before retasking:
>>
>> http://www.alsa-project.org/db/?f=fd97b8194e205b4f91127bca74ad7c9b2cd93ab9
>>
>> After retasking blue line in, pin ID 0x1a as Line out (Side):
>>
>> http://www.alsa-project.org/db/?f=d56f9a6d0692c9a8d5c88f43100a6cb78407c163
>>
>> Note that retasking did not work: attempting to play a 8-channel wav
>> file through hw:1,0 resulted in an "Invalid argument" error.
>>
>> FWIW, here is what hdajackretask printed to the console:
>>
>> 0x11 0x99430130
>> 0x12 0x4037c540
>> 0x14 0x01014010
>> 0x15 0x01011012
>> 0x16 0x01016011
>> 0x17 0x411111f0
>> 0x18 0x01a19050
>> 0x19 0x02a19060
>> 0x1a 0x01014413
>> 0x1b 0x02214020
>> 0x1c 0x411111f0
>> 0x1d 0x4045e601
>> 0x1e 0x01452140
>> 0x1f 0x411111f0
>> 1
>>
>
> you need root privilege for hdajackretask to write the firmware file to
> /lib/firmware and modify /etc/modprobe.d/alsa-lbase.conf to use the firmware
> file
>
> can you try the patch which add "channel mode" control which allow you to
> switch from 6ch to 8ch

I have tested the patch. In 8ch mode, it works without any overrides
in the sense that the side channels go to the blue jack if I choose
8ch mode. In the 6ch mode, the line input also works (tested by using
headphones as a very bad microphone-like source).

Here is alsa-info in the 6ch mode:

http://www.alsa-project.org/db/?f=d152698d4b2d9589d4c5f14e0c8e6d4978c8fbd0

And in 8ch mode:

http://www.alsa-project.org/db/?f=4d5d14fbb559819fd82e7731e656be7efcfab439

Pulseaudio is not smart enough to decide by itself that it can toggle
the control and add 7.1 profiles. If I toggle the control manually and
restart pulseaudio, they appear.

If the role of the "Line jack" control is still unclear, just say so
and tell me what to do to figure it out.

-- 
Alexander E. Patrakov
