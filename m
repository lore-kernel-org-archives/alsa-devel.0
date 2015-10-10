From: Arthur Borsboom <arthurborsboom@gmail.com>
Subject: Re: [PATCH v2- ALSA 1/3] HDA - Allow hda_jack_tbl to
 use another nid for pin sense
Date: Sat, 10 Oct 2015 15:21:47 +0200
Message-ID: <CALUcmUkCaBvobO85Amw5VTLTU490UsB+yg20eNdP_AAyO_e4kg@mail.gmail.com>
References: <CAN8cciYNotgS=1qis4ciOQqoYwjND4y=tpxJGmZt1HGahTV3+Q@mail.gmail.com>
 <s5hvbb16yup.wl-tiwai@suse.de>
 <CAN8cciZ0HKP+RNRRsbNXpo0azmqBKBjejXJRwx8PRuHiw3pZ9w@mail.gmail.com>
 <s5h4mik6xwi.wl-tiwai@suse.de>
 <CAN8cciZ1xbRQg3aYKjDSq5K1eL44fFKZJdq52WP2Uht_A8JFDA@mail.gmail.com>
 <CALUcmUno7vKTU-45=+6spkbBbp671NiDhu2Oj4RVbNWLQYGoLw@mail.gmail.com>
 <CAN8ccia0OSv8Nyx-jUF+LneVaAcf80SwxvfA3Btdx5cqxEg2CQ@mail.gmail.com>
 <CALUcmU=DRvSEmvGNCfDc0dVHRQ9TmnK0U=094E64Sc5wxsAV5g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-oi0-f51.google.com (mail-oi0-f51.google.com
 [209.85.218.51])
 by alsa0.perex.cz (Postfix) with ESMTP id EA92226044B
 for <alsa-devel@alsa-project.org>; Sat, 10 Oct 2015 15:22:07 +0200 (CEST)
Received: by oiao187 with SMTP id o187so8273124oia.2
 for <alsa-devel@alsa-project.org>; Sat, 10 Oct 2015 06:22:06 -0700 (PDT)
In-Reply-To: <CALUcmU=DRvSEmvGNCfDc0dVHRQ9TmnK0U=094E64Sc5wxsAV5g@mail.gmail.com>
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
Cc: Takashi Iwai <tiwai@suse.de>, jason.braddock.69@gmail.com, ALSA Development Mailing List <alsa-devel@alsa-project.org>, 1451170@bugs.launchpad.net
List-Id: alsa-devel@alsa-project.org

Hi Raymond,

Do you need more testing on the Asus N751JK by me?
Do you need help from other developers?

On 6 October 2015 at 10:22, Arthur Borsboom <arthurborsboom@gmail.com>
wrote:

> Asus N751JK - ALC668 - hdajacksenseresults:
>
> -----
>
> Nothing plugged in:
>
> Pin 0x12 (Internal Mic): present = No
> Pin 0x14 (Internal Speaker): present = No
> Pin 0x15 (Black Headphone, Left side): present = No
> Pin 0x16 (Not connected): present = No
> Pin 0x18 (Not connected): present = No
> Pin 0x19 (Pink Mic, Left side): present = No
> Pin 0x1a (Internal Speaker): present = No
> Pin 0x1b (Black Mic, Left side): present = No
> Pin 0x1d (Not connected): present = No
> Pin 0x1e (Not connected): present = No
> Pin 0x1f (Not connected): present = No
>
> ---
>
> Only headset plugged in:
>
> Pin 0x12 (Internal Mic): present = No
> Pin 0x14 (Internal Speaker): present = No
> Pin 0x15 (Black Headphone, Left side): present = Yes
> Pin 0x16 (Not connected): present = No
> Pin 0x18 (Not connected): present = No
> Pin 0x19 (Pink Mic, Left side): present = No
> Pin 0x1a (Internal Speaker): present = No
> Pin 0x1b (Black Mic, Left side): present = No
> Pin 0x1d (Not connected): present = No
> Pin 0x1e (Not connected): present = No
> Pin 0x1f (Not connected): present = No
>
> ---
>
> Only headphones plugged in:
>
> Pin 0x12 (Internal Mic): present = No
> Pin 0x14 (Internal Speaker): present = No
> Pin 0x15 (Black Headphone, Left side): present = Yes
> Pin 0x16 (Not connected): present = No
> Pin 0x18 (Not connected): present = No
> Pin 0x19 (Pink Mic, Left side): present = No
> Pin 0x1a (Internal Speaker): present = No
> Pin 0x1b (Black Mic, Left side): present = No
> Pin 0x1d (Not connected): present = No
> Pin 0x1e (Not connected): present = No
> Pin 0x1f (Not connected): present = No
>
> ---
>
> Only microphone plugged in:
>
> Pin 0x12 (Internal Mic): present = No
> Pin 0x14 (Internal Speaker): present = No
> Pin 0x15 (Black Headphone, Left side): present = Yes
> Pin 0x16 (Not connected): present = No
> Pin 0x18 (Not connected): present = No
> Pin 0x19 (Pink Mic, Left side): present = No
> Pin 0x1a (Internal Speaker): present = No
> Pin 0x1b (Black Mic, Left side): present = No
> Pin 0x1d (Not connected): present = No
> Pin 0x1e (Not connected): present = No
> Pin 0x1f (Not connected): present = No
>
> ---
>
> Only subwoofer plugged in:
>
> Pin 0x12 (Internal Mic): present = No
> Pin 0x14 (Internal Speaker): present = No
> Pin 0x15 (Black Headphone, Left side): present = No
> Pin 0x16 (Not connected): present = No
> Pin 0x18 (Not connected): present = No
> Pin 0x19 (Pink Mic, Left side): present = No
> Pin 0x1a (Internal Speaker): present = Yes
> Pin 0x1b (Black Mic, Left side): present = No
> Pin 0x1d (Not connected): present = No
> Pin 0x1e (Not connected): present = No
> Pin 0x1f (Not connected): present = No
>
> Note that I have used hdajackretask to assing pin 0x1a -> LFE, apparently
> resulting in jack detection for the subwoofer.
>
> On 5 October 2015 at 06:51, Raymond Yau <superquad.vortex2@gmail.com>
> wrote:
>
>>
>> >
>> > Do you need any testing from my side to be able to finish the
>> developing?
>> >
>>
>>
>> https://bugs.launchpad.net/ubuntu/+source/alsa-driver/+bug/1451170/comments/22
>>
>> It seem that asus n550lf which also use alc668 codec but headset mic pin
>> node 0x1b is detectable
>>
>> Can you confirm that your headset mic node is not detectable by
>> hdajacksensetest ?
>>
>> This mean that the model "headset-sonicmaster" will be quite confusing
>> when asus notebooks have different ways of headset implementation
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
