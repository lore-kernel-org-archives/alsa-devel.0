From: Peti Pap <roachkiller44@gmail.com>
Subject: Re: M-audio Audiophile Firewire
Date: Sun, 23 Oct 2016 20:22:32 +0200
Message-ID: <CAPzTivEPwnerkvH-Y5j9bvGzsM5GhLKvF69zFAkVHpDt-8g1Lw@mail.gmail.com>
References: <CAPzTivG=yDAbFZo+u5qauE_LdpqhUM5fT9MT9+hrmi3gTsTGqw@mail.gmail.com>
 <1f6dd683-f550-651b-93d2-87560dd298ff@sakamocchi.jp>
 <fd56b817-96b3-1784-725c-21a5bef7497a@sakamocchi.jp>
 <CAPzTivEubUhef5LR_p3y0_4TZtbwoLimvzU-tx=xmUhBnT+T0g@mail.gmail.com>
 <CAPzTivHypNMZvBVBks=wpx1XakELyeWsBVD9mpq-risb_DtH=Q@mail.gmail.com>
 <7f5bc2fc-7e45-2577-9286-be0e2ff74228@sakamocchi.jp>
 <CAPzTivHqY1aBH2hqHetmd7-hdZsPbPsC8e1iMjgL=2myH91fbg@mail.gmail.com>
 <a2d308f4-1982-8418-40ec-e783065f7a96@sakamocchi.jp>
 <CAPzTivFtjdmpEOYJo=a=B12_Zf9UVV+SjRUKA9hNWLop3w5nbg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-yw0-f179.google.com (mail-yw0-f179.google.com
 [209.85.161.179])
 by alsa0.perex.cz (Postfix) with ESMTP id 3C9E6265350
 for <alsa-devel@alsa-project.org>; Sun, 23 Oct 2016 20:22:33 +0200 (CEST)
Received: by mail-yw0-f179.google.com with SMTP id w3so140050654ywg.1
 for <alsa-devel@alsa-project.org>; Sun, 23 Oct 2016 11:22:33 -0700 (PDT)
In-Reply-To: <CAPzTivFtjdmpEOYJo=a=B12_Zf9UVV+SjRUKA9hNWLop3w5nbg@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, ffado-devel@lists.sf.net
List-Id: alsa-devel@alsa-project.org

Hi again,


I installed now an Ubuntu 16.10 (because this distro can handle ffado 2.3
well), and now almost work the playback (but sometimes a bit noisy, and I
dont know the reason).
When I start the FFADO Mixer from terminal, I get the following messages:

Cannot create RT messagebuffer thread: Operation not permitted (1)
Retrying messagebuffer thread without RT scheduling
Messagebuffer not realtime; consider enabling RT scheduling for user
-----------------------------------------------
FFADO Control DBUS service
Part of the FFADO project -- www.ffado.org
Version: 2.3.0-
(C) 2008, Pieter Palmers
This program comes with ABSOLUTELY NO WARRANTY.
-----------------------------------------------

1477244892717343:  (ffado-dbus-server.cpp)[ 270] main:  Discovering
devices...
03966254548:  (ffado-dbus-server.cpp)[ 329] main: DBUS service running
03966254588:  (ffado-dbus-server.cpp)[ 330] main: press ctrl-c to stop it &
exit
03966254597: Debug (ffado-dbus-server.cpp)[ 333] main: dispatching...
03970152237: Error (avc_avdevice.cpp)[ 300] supportsSamplingFrequency:
sample rate not supported by input plug
03970268300: Error (avc_avdevice.cpp)[ 300] supportsSamplingFrequency:
sample rate not supported by input plug
03970396280: Error (avc_avdevice.cpp)[ 300] supportsSamplingFrequency:
sample rate not supported by input plug
03971004282: Error (avc_avdevice.cpp)[ 300] supportsSamplingFrequency:
sample rate not supported by input plug
03971128298: Error (avc_avdevice.cpp)[ 300] supportsSamplingFrequency:
sample rate not supported by input plug

(And if I close the mixer GUI, I cant re-open again without killing the
ffado-dbus-server)

Maybe should I - somehow - force the ALSA driver to keep always the 24bit
48000Hz?
Anyway on the mixer I use under the "Mix" tab; Stream 1/2 In.

Regards,

Peter


2016-10-23 12:48 GMT+02:00 Peti Pap <roachkiller44@gmail.com>:

> Now I restart the system, and the FFADO-Mixer working, there have a lot of
> settings, I tried some, but I noticed when I try to play a youtube video or
> mp3 the sound is "creak". And when I try to set 48khz, after an m3 playing
> always 'recoil' to 44.1
> I want use this unit as a simple stereo 48khz sound device, to playing mp3
> wav and videos, and recording/make music in Tracktion.
>
>
> 2016-10-23 11:23 GMT+02:00 Takashi Sakamoto <o-takashi@sakamocchi.jp>:
>
>> On Oct 23 2016 18:03, Peti Pap wrote:
>> > Excuse me;
>> >
>> > "When the power LED turns at green color instead blinking, ALSA bebob
>> > driver successfully makes the unit to load firmware"
>> >
>> > The unit already stopped blinking after a basic linux installation (from
>> > the first boot). But no any "green" LED, only(!) the power LED lighting,
>> > but the power LED color is blue.
>> > So, I reinstalled - again - my system, and now I dont know what can I do
>> > :|
>>
>> Ah, sorry. It shoud be turns at blue color... When you can see any ALSA
>> PCM nodes for your unit, the unit loads firmware correctly.
>>
>>
>> Regards
>>
>> Takashi Sakamoto
>>
>
>
