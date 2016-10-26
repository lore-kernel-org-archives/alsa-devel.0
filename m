From: Pap Peti <roachkiller44@gmail.com>
Subject: Re: [FFADO-devel] M-audio Audiophile Firewire
Date: Wed, 26 Oct 2016 21:03:20 +0200
Message-ID: <a7eedc84-d29e-838a-64d3-cdf0db748826@gmail.com>
References: <CAPzTivG=yDAbFZo+u5qauE_LdpqhUM5fT9MT9+hrmi3gTsTGqw@mail.gmail.com>
 <1f6dd683-f550-651b-93d2-87560dd298ff@sakamocchi.jp>
 <fd56b817-96b3-1784-725c-21a5bef7497a@sakamocchi.jp>
 <CAPzTivEubUhef5LR_p3y0_4TZtbwoLimvzU-tx=xmUhBnT+T0g@mail.gmail.com>
 <CAPzTivHypNMZvBVBks=wpx1XakELyeWsBVD9mpq-risb_DtH=Q@mail.gmail.com>
 <7f5bc2fc-7e45-2577-9286-be0e2ff74228@sakamocchi.jp>
 <CAPzTivHqY1aBH2hqHetmd7-hdZsPbPsC8e1iMjgL=2myH91fbg@mail.gmail.com>
 <a2d308f4-1982-8418-40ec-e783065f7a96@sakamocchi.jp>
 <CAPzTivFtjdmpEOYJo=a=B12_Zf9UVV+SjRUKA9hNWLop3w5nbg@mail.gmail.com>
 <CAPzTivEPwnerkvH-Y5j9bvGzsM5GhLKvF69zFAkVHpDt-8g1Lw@mail.gmail.com>
 <20161023224350.GB12315@marvin.atrad.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wm0-f41.google.com (mail-wm0-f41.google.com [74.125.82.41])
 by alsa0.perex.cz (Postfix) with ESMTP id 8C8402671EC
 for <alsa-devel@alsa-project.org>; Wed, 26 Oct 2016 21:03:24 +0200 (CEST)
Received: by mail-wm0-f41.google.com with SMTP id 140so33414580wmv.0
 for <alsa-devel@alsa-project.org>; Wed, 26 Oct 2016 12:03:24 -0700 (PDT)
In-Reply-To: <20161023224350.GB12315@marvin.atrad.com.au>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jonathan Woithe <jwoithe@just42.net>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, ffado-devel@lists.sf.net
List-Id: alsa-devel@alsa-project.org



On 2016-10-24 00:43, Jonathan Woithe wrote:
> On Sun, Oct 23, 2016 at 08:22:32PM +0200, Peti Pap wrote:
>> I installed now an Ubuntu 16.10 (because this distro can handle ffado 2.3
>> well), and now almost work the playback (but sometimes a bit noisy, and I
>> dont know the reason).
>> When I start the FFADO Mixer from terminal, I get the following messages:
>>
>> Cannot create RT messagebuffer thread: Operation not permitted (1)
>> Retrying messagebuffer thread without RT scheduling
>> Messagebuffer not realtime; consider enabling RT scheduling for user
> This indicates that your user does not have access to the realtime
> scheduling features on the system.  While this should not affect the
> operation of ffado-mixer (and its related ffado-dbus-server), it will cause
> problems if you choose to use the FFADO audio streaming system via jackd's
> "firewire" backend.  From the above message I'm not sure if you're doing
> this though: the "noisy" playback might still be relating to your use of the
> ALSA streaming driver.
>
> On most distributions it is sufficient to add your user to the "audio".
>
> Not having access to the realtime scheduling shouldn't cause ffado-mixer any
> problem.  However, just to be sure it's probably worth adding your user to
> the audio group to see if that improves the ffado-mixer behaviour.
>
>> -----------------------------------------------
>> FFADO Control DBUS service
>> Part of the FFADO project -- www.ffado.org
>> Version: 2.3.0-
>> (C) 2008, Pieter Palmers
>> This program comes with ABSOLUTELY NO WARRANTY.
>> -----------------------------------------------
>>
>> 1477244892717343:  (ffado-dbus-server.cpp)[ 270] main:  Discovering
>> devices...
>> 03966254548:  (ffado-dbus-server.cpp)[ 329] main: DBUS service running
>> 03966254588:  (ffado-dbus-server.cpp)[ 330] main: press ctrl-c to stop it &
>> exit
>> 03966254597: Debug (ffado-dbus-server.cpp)[ 333] main: dispatching...
>> 03970152237: Error (avc_avdevice.cpp)[ 300] supportsSamplingFrequency:
>> sample rate not supported by input plug
> I'm not sure what would cause this.  Was the device actively streaming audio
> at the time you started ffado-dbus-server?  That still shouldn't cause any
> issues, but obviously something is amiss.
>
>> (And if I close the mixer GUI, I cant re-open again without killing the
>> ffado-dbus-server)
> That's strange.  Something seems to be getting hung up somewhere.
>
> Peti: to keep the original thread in alsa-devel on topic, you may like to
> subscribe to ffado-devel and start a fresh thread there about the
> above ffado-mixer / ffado-dbus-server issues you are seeing.
>
> Regards
>    jonathan
