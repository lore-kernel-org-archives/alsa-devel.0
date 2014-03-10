From: Jason Mancine <jason@mancine.net>
Subject: Re: Zoom R16
Date: Mon, 10 Mar 2014 10:36:33 -0400
Message-ID: <CAPrbH=tQ3H1wUnK2417ap5jHSSO=y7vkBcCXBJqWn2V9sqbGHQ@mail.gmail.com>
References: <CAPrbH=vnQ-xXsRDoj30nra7hB_hDEaF6u3ov0XuDG_ZpFzb3bA@mail.gmail.com>
 <20131124130335.GA23126@tamtam.fritz.box>
 <CAPrbH=tGph7__rgx-5BsBSi9-E95FpsTL9Yy0zbum0TccTPbyQ@mail.gmail.com>
 <20131124141803.GC23126@tamtam.fritz.box>
 <CAPrbH=sA5ppp8z3bqdaDnk4U+DZ093ukXpDgiT6DEixGi1tdZA@mail.gmail.com>
 <CAPrbH=tu0jTctOAegkT7tnq1VSGOui4cESA2rYJFfgCa3=tQDg@mail.gmail.com>
 <CAPrbH=v+fVMibUGC8FqBbW-Gd6NW7uZFCgq7fxw9hiaPGR_04g@mail.gmail.com>
 <loom.20131206T170648-556@post.gmane.org> <s5h4n6m6j5q.wl%tiwai@suse.de>
 <CAPrbH=uHUhWMYiGcHKLwFYiWwGhahNqAWjio1RKECM_dUnNN6A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-we0-f172.google.com (mail-we0-f172.google.com
 [74.125.82.172])
 by alsa0.perex.cz (Postfix) with ESMTP id 26C67265167
 for <alsa-devel@alsa-project.org>; Mon, 10 Mar 2014 15:36:54 +0100 (CET)
Received: by mail-we0-f172.google.com with SMTP id t61so8750748wes.3
 for <alsa-devel@alsa-project.org>; Mon, 10 Mar 2014 07:36:53 -0700 (PDT)
In-Reply-To: <CAPrbH=uHUhWMYiGcHKLwFYiWwGhahNqAWjio1RKECM_dUnNN6A@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

I am still working on trying to get the R16 to work for playback.   The
problem is that no matter what .formats setting I use, ALSA sets the R16 to
32 bit LE (the R16 operates at 24 bit integer only).   This is fine for
capture as the R16 is sending a 24 bit stream into a 24-in-32 ALSA
capture... but for playback, the 32 bit ALSA stream chokes when it hits the
24 bit integer R16 device.

So, the main question is how do I force ALSA to initialize this device at
24 bit integer?

For the record, here is the quirk that I am working with (working for
capture, recognized for playback but crashes on data).   Thanks for any
suggestions.


{
        /* ZOOM R16 in USB 2.0 mode */
        USB_DEVICE(0x1686, 0x00dd),
        .driver_info = (unsigned long) & (const struct snd_usb_audio_quirk)
{
                .ifnum = QUIRK_ANY_INTERFACE,
                .type = QUIRK_COMPOSITE,
                .data = (const struct snd_usb_audio_quirk[]) {

                        {
                                .ifnum = 0,
                                .type = QUIRK_IGNORE_INTERFACE
                        },

                       {
                                .ifnum = 1,  /*PLAYBACK*/
                                .type = QUIRK_AUDIO_FIXED_ENDPOINT,
                                .data = & (const struct audioformat) {
                                .formats = SNDRV_PCM_FMTBIT_S24_LE,
                                .channels = 2,
                                .iface = 0,
                                .altsetting = 1,
                                 altset_idx = 1,
                                .attributes = UAC_EP_CS_ATTR_SAMPLE_RATE,
                                .endpoint = 0x03,
                                .ep_attr = 9,
                                .rates = SNDRV_PCM_RATE_44100 |
                                      SNDRV_PCM_RATE_48000 |
                                      SNDRV_PCM_RATE_88200 |
                                      SNDRV_PCM_RATE_96000,
                               .rate_min = 44100,
                               .rate_max = 96000,
                               .nr_rates = 4,
                               .rate_table = (unsigned int[]) {
                                44100, 48000, 88200, 96000
                                 }
                              }
                           },

                        {
                               .ifnum = 2,  /*CAPTURE*/
                              .type = QUIRK_AUDIO_FIXED_ENDPOINT,
                              .data = & (const struct audioformat) {
                                 .formats = SNDRV_PCM_FMTBIT_S24_LE,
                                 .channels = 8,
                                 .iface = 0,
                                 .altsetting = 1,
                                 .altset_idx = 1,
                                 .attributes = UAC_EP_CS_ATTR_SAMPLE_RATE,
                                  .endpoint = 0x84,
                                  .ep_attr = 13,
                                  .rates = SNDRV_PCM_RATE_44100 |
                                          SNDRV_PCM_RATE_48000 |
                                        SNDRV_PCM_RATE_88200 |
                                             SNDRV_PCM_RATE_96000,
                                .rate_min = 44100,
                                 .rate_max = 96000,
                                 .nr_rates = 4,
                                 .rate_table = (unsigned int[]) {
                                       44100, 48000, 88200, 96000
                                 }
                              }
                           },

                        {
                                .ifnum = 3,
                                .type = QUIRK_MIDI_STANDARD_INTERFACE
                        },


                        {
                                .ifnum = .1
                        },


                        }

        }

},





On Fri, Dec 6, 2013 at 12:28 PM, Jason Mancine <jason@mancine.net> wrote:

> With it set to 3LE format it fails on both capture and playback, and is
> still trying to initialize at 32 bits for both.
>
> Any other formats I could try?
>  On Dec 6, 2013 11:25 AM, "Takashi Iwai" <tiwai@suse.de> wrote:
>
>> At Fri, 6 Dec 2013 16:10:01 +0000 (UTC),
>> Jason Mancine wrote:
>> >
>> > It seems that ALSA is trying to initialize the device at 32-bit integer
>> > little endian despite having the .formats set to
>> SNDRV_PCM_FMTBIT_S24_LE in
>> > the quirk. The device is 24-bit integer only.  Other devices I have
>> > initialize properly at 24 bits.
>>
>> Do you mean the 24bit physical size, i.e. each frame is packed in 3
>> bytes?  If so, you used a wrong format.  SNDRV_PCM_FMTBIT_S24_LE is
>> for 24bit format packed in 32bit frame.  If you need a 3-bytes frame,
>> use SNDRV_PCM_FMTBIT_S24_3LE instead.
>>
>>
>> Takashi
>>
>
