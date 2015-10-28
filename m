From: Arthur Borsboom <arthurborsboom@gmail.com>
Subject: Re: [PATCH v2- ALSA 1/3] HDA - Allow hda_jack_tbl to
 use another nid for pin sense
Date: Wed, 28 Oct 2015 22:24:54 +0100
Message-ID: <CALUcmUnQ+9NRSyzuj8DhM9svYiaznu7qb7HQv=csjOGuu_NhJQ@mail.gmail.com>
References: <CAN8cciYNotgS=1qis4ciOQqoYwjND4y=tpxJGmZt1HGahTV3+Q@mail.gmail.com>
 <s5hvbb16yup.wl-tiwai@suse.de>
 <CAN8cciZ0HKP+RNRRsbNXpo0azmqBKBjejXJRwx8PRuHiw3pZ9w@mail.gmail.com>
 <s5h4mik6xwi.wl-tiwai@suse.de>
 <CAN8cciZ1xbRQg3aYKjDSq5K1eL44fFKZJdq52WP2Uht_A8JFDA@mail.gmail.com>
 <CALUcmUno7vKTU-45=+6spkbBbp671NiDhu2Oj4RVbNWLQYGoLw@mail.gmail.com>
 <CAN8ccia0OSv8Nyx-jUF+LneVaAcf80SwxvfA3Btdx5cqxEg2CQ@mail.gmail.com>
 <CALUcmU=DRvSEmvGNCfDc0dVHRQ9TmnK0U=094E64Sc5wxsAV5g@mail.gmail.com>
 <CALUcmUkCaBvobO85Amw5VTLTU490UsB+yg20eNdP_AAyO_e4kg@mail.gmail.com>
 <CAN8ccia8sgSfZxDtFTy1Qf3zCq=eov_8Fm8AfvAwJ1v1f4rqAw@mail.gmail.com>
 <CALUcmUmSdno39sDEfEuetqCiWXKwXQivGUF0_4Zj8Nkn5hZJoA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ob0-f176.google.com (mail-ob0-f176.google.com
 [209.85.214.176])
 by alsa0.perex.cz (Postfix) with ESMTP id B782D264F28
 for <alsa-devel@alsa-project.org>; Wed, 28 Oct 2015 22:25:14 +0100 (CET)
Received: by obbwb3 with SMTP id wb3so18132608obb.0
 for <alsa-devel@alsa-project.org>; Wed, 28 Oct 2015 14:25:14 -0700 (PDT)
In-Reply-To: <CALUcmUmSdno39sDEfEuetqCiWXKwXQivGUF0_4Zj8Nkn5hZJoA@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Raymond Yau <superquad.vortex2@gmail.com>
Cc: Takashi Iwai <tiwai@suse.de>, jason.braddock.69@gmail.com, ALSA Development Mailing List <alsa-devel@alsa-project.org>, Fabio Pellegrin <pellegrin.fabio@gmail.com>
List-Id: alsa-devel@alsa-project.org

Hi Raymond,

Just to refresh, for the Asus N751JK (ALC668) I currently make everything
work with the following workarounds (mainline kernel 4.2.4)

To enable the base speaker, I use hdajackretask and I assign unconnected
pin 0x1a to Internal Speaker (LFE).
To switch to the microphone of my headset after plugin, I open pavucontrol
and change from Internal Microphone to Headset Microphone (due to missing
jack detection).
To switch to the microphone of my laptop after unplug, I do the opposite. :)

If dealing with the microphone issue is too time consuming, would you mind
to at least offer the patch for the sub woofer to the Alsa mailinglist?

If necessary, I still have the patchset of 7 patches which worked on my
system.

On 14 October 2015 at 08:50, Arthur Borsboom <arthurborsboom@gmail.com>
wrote:

> I don't understand what you mean by quad speak array. Please keep in mind
> that I am not a driver developer / sound guru.
> The Asus N751JK laptop has two built-in speakers, 1 external base speaker
> (with a yellow jack) and 1 combo jack for headset, headphones or microphone.
>
> The headset I am using is a headset which I received with my LG phone.
> The only thing written on it is: "LG" and "Made in Indonesia" :)
>
> But let me rephrase what I currently do to make everything work
> (workarounds) with the mainline kernel (4.2.2)
>
> To enable the base speaker, I use hdajackretask and I assign unconnected
> pin 0x1a to Internal Speaker (LFE).
> To switch to the microphone of my headset after plugin, I open pavucontrol
> and change from Internal Microphone to Headset Microphone (due to missing
> jack detection).
> To switch to the microphone of my laptop after unplug, I do the opposite.
> :)
>
> Does this help?
>
> On 14 October 2015 at 01:35, Raymond Yau <superquad.vortex2@gmail.com>
> wrote:
>
>> >
>> > Do you need more testing on the Asus N751JK by me?
>> > Do you need help from other developers?
>>
>> Do all speakers of quad speaker array work as expected ?
>>
>> If ASUS N550LF can use headset by default, it is strange that your N750JK
>> need any modification for the headset mic pin since they are using same
>> codec ALC668 with similar BIOS pin default, quad speaker array and Sonic
>> Master Subwoofer
>>
>> If you only test CTIA headset, it is better to name the model according
>> to what you have tested
>>
>
>
>
> --
> Arthur Borsboom
> Mob: +31629089953
> Email: arthurborsboom@gmail.com
> Skype: Arthur Borsboom, The Hague, The Netherlands
>
> [image: View Arthur's LinkedIn profile]
> <http://uk.linkedin.com/in/arthurborsboom>
>



-- 
Arthur Borsboom
Mob: +31629089953
Email: arthurborsboom@gmail.com
Skype: Arthur Borsboom, The Hague, The Netherlands

[image: View Arthur's LinkedIn profile]
<http://uk.linkedin.com/in/arthurborsboom>
