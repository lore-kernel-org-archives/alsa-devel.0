From: Daniel Mack <zonque@gmail.com>
Subject: Support for DSD streams (was: Re: [PATCH 0/3] ALSA:
 snd-usb: Some small fixes to make Playback Design products work)
Date: Sat, 23 Mar 2013 12:31:07 +0100
Message-ID: <514D927B.3080000@gmail.com>
References: <1363522047-7515-1-git-send-email-zonque@gmail.com>
 <s5hehfduld0.wl%tiwai@suse.de> <5146DB40.2060000@gmail.com>
 <s5h620pukb4.wl%tiwai@suse.de> <51471B51.4000006@gmail.com>
 <514B79DA.6030203@sonarnerd.net> <514C1215.9010708@gmail.com>
 <514CB2E2.9050003@sonarnerd.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bk0-f43.google.com (mail-bk0-f43.google.com
 [209.85.214.43])
 by alsa0.perex.cz (Postfix) with ESMTP id 8A1F0265264
 for <alsa-devel@alsa-project.org>; Sat, 23 Mar 2013 12:31:01 +0100 (CET)
Received: by mail-bk0-f43.google.com with SMTP id jm19so2193466bkc.16
 for <alsa-devel@alsa-project.org>; Sat, 23 Mar 2013 04:31:01 -0700 (PDT)
In-Reply-To: <514CB2E2.9050003@sonarnerd.net>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jussi Laako <jussi@sonarnerd.net>
Cc: alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>, clemens@ladisch.de, demian@auraliti.com, ray@auraliti.com, andreas@akdesigninc.com
List-Id: alsa-devel@alsa-project.org

Hi Jussi,

On 22.03.2013 20:37, Jussi Laako wrote:
> On 03/22/2013 10:11 AM, Daniel Mack wrote:
>> Ah, interesting. So what *are* you using right now for your transport in
>> userspace? Is your application abusing standard PCM interfaces that are
>> 'known' to be in fact DSD? How do other DACs expose their interfaces in
>> the Linux world, and which ones did you test your application with?
> 
> Yes, it's abuse of PCM (hw) interface, I'm using the DoP specification 
> as referred to in another post.

It's really new to me that there are active users for this sample
format, and we should clean up the mess by cleanly marking such streams
correctly in the drivers. But I'm still not sure about the current
situation in terms of hardware support. So let's shed some light ...

> All the DSD DACs that currently work 
> with Linux support this. Quite many at the moment in fact and more 
> coming all the time.

Ok, but how do you know about which interfaces are capable of handling
that? Are you maintaining a white list?

And does that mean these devices are also wrongly believed to have
additional PCM interfaces? IOW: do they only work as DSD, breaking all
applications that believe that they can use all devices that expose a
PCM interface?

Can you show the contents of /proc/asound/cardX/stream0 for such a card
maybe?

> There's at least devices from Mytek, Fostex, Benchmark and Sonore/exD 
> that work with this setup. And I believe also Chord, but I haven't got 
> chance to test it yet.

Can you provide the output of "lsusb -v" for any of these?

> Mytek has a vendor specific interface (RigiSystems USBPAL) that could 
> utilize a separate raw DSD sample format.
> 
> Plus I have some of my own experiments implementing DSD on an ARM based 
> SoC where there's no need use DoP, but now I need to use custom hack for 
> the raw data. Thus sooner there's some officially defined ALSA formats, 
> less likely it becomes fragmented set of different incompatible hacks. 
> That would be a headache and nightmare for application developers.

I'm afraid that adding a DSD format and teaching the driver quirks for
interfaces that are known to support DSD would break applications that
already expect to see a usual PCM interface.

To be precise: which SND_PCM_FORMAT_* does your application accept, and
what happens if it sees  SND_PCM_FORMAT_SPECIAL?

As for the driver, I would not go any further than marking the streams
as DSD, without touching the payload. The marker bytes as described in
the DoP document could be handled by some sort of libasound convenience
function maybe though.



Daniel
