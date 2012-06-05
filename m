From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Clipping in Analog Mono Output
Date: Tue, 5 Jun 2012 11:05:22 +0800
Message-ID: <CAN8cciZ6XqatXQ6wW3pMS9bjCvnoGhtxu1W9y+ymCam1_yjrDA@mail.gmail.com>
Reply-To: General PulseAudio Discussion
	<pulseaudio-discuss@lists.freedesktop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <pulseaudio-discuss-bounces+gcapd-polypaudio-discuss=m.gmane.org@lists.freedesktop.org>
List-Unsubscribe: <http://lists.freedesktop.org/mailman/options/pulseaudio-discuss>,
	<mailto:pulseaudio-discuss-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <http://lists.freedesktop.org/archives/pulseaudio-discuss>
List-Post: <mailto:pulseaudio-discuss@lists.freedesktop.org>
List-Help: <mailto:pulseaudio-discuss-request@lists.freedesktop.org?subject=help>
List-Subscribe: <http://lists.freedesktop.org/mailman/listinfo/pulseaudio-discuss>,
	<mailto:pulseaudio-discuss-request@lists.freedesktop.org?subject=subscribe>
Sender: pulseaudio-discuss-bounces+gcapd-polypaudio-discuss=m.gmane.org@lists.freedesktop.org
Errors-To: pulseaudio-discuss-bounces+gcapd-polypaudio-discuss=m.gmane.org@lists.freedesktop.org
To: David Henningsson <david.henningsson@canonical.com>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, General PulseAudio Discussion <pulseaudio-discuss@lists.freedesktop.org>
List-Id: alsa-devel@alsa-project.org

2012/6/1 David Henningsson <david.henningsson@canonical.com>:
> On 06/01/2012 04:54 AM, Raymond Yau wrote:
>
>> what is the definition of "Mono Output" in pulseaudio ?
>>
>> My three other sound cards does support mono playback and mono capture
>>
>> The system setting/sound in gnome session allow me to select "mono
>> duplex" but when it does not allow me to select "mono output + mono
>> input" in unity session.
>
>
> That sounds like the known bug I was working on yesterday.
>

The major problem of Analog Mono output is clipping

it seem pulseaudio just add the left and right channels instead of
half of the left and right channels and the sound is distorted

why database contrain invalid format since it is a clean install of
ubuntu 12.04l

D: [pulseaudio] module-device-restore.c: Database contains invalid
data for key: sink:alsa_output.pci-0000_04_02.0.analog-mono:null
D: [pulseaudio] module-suspend-on-idle.c: Sink
alsa_output.pci-0000_04_02.0.analog-mono becomes idle, timeout in 5
seconds.
I: [pulseaudio] resampler.c: Forcing resampler 'copy', because of
fixed, identical sample rates.
D: [pulseaudio] resampler.c: Channel matrix:
D: [pulseaudio] resampler.c:        I00   I01
D: [pulseaudio] resampler.c:     +------------
D: [pulseaudio] resampler.c: O00 | 1.000 1.000
I: [pulseaudio] remap.c: Using generic matrix remapping
