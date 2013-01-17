From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: HD-audio regression after commit
	34588709af61be1550b4e2bcee5c85d0ac4f34d4
Date: Thu, 17 Jan 2013 23:29:44 +0800
Message-ID: <CAN8cciaEqbTi-kP7HFH5f2wOBTzFEVEryPo5TrFH8mQYqmVBjg@mail.gmail.com>
References: <CA+S_cwraM+wofw5Nz_d0ctOget5dY-0nr5pRHCzOJtLX+JM2TA@mail.gmail.com>
 <CAN8ccia1N-eseNR2dET=ghXuyK0E0gXaakehW3VAN8u1UxUQ8Q@mail.gmail.com>
 <20130114133122.52cadb99@gmail.com> <s5h7gngc4lt.wl%tiwai@suse.de>
 <20130114135947.1f0bbbf4@gmail.com> <s5h1udndihf.wl%tiwai@suse.de>
 <20130114172354.1f47f49b@gmail.com>
 <CAN8cciaoAt75sRUtLM6Ov4VGBQ1pFgPwO-EZT88q6d1gm-JggQ@mail.gmail.com>
 <20130115095325.7aa2dfdd@gmail.com>
 <CAN8cciYrMSBhpp-9QjHdE8aVMHh_JwHswwfPfjtGY6OB_E4NcQ@mail.gmail.com>
 <20130116094941.0e1170b2@gmail.com> <s5hwqvd33va.wl%tiwai@suse.de>
 <20130116133952.18449985@gmail.com> <s5hbocpp9tn.wl%tiwai@suse.de>
 <20130116140412.01c73523@gmail.com> <s5h8v7tp8s8.wl%tiwai@suse.de>
 <20130116145509.434c0bb9@gmail.com> <s5h1udlp5to.wl%tiwai@suse.de>
 <CAN8ccib5gpbsyLPmfoaC4edwYjird8ViZbKKiTbo-iP4DsjsOA@mail.gmail.com>
 <s5hehhk2uee.wl%tiwai@suse.de>
 <CAN8cciZEWPdKcX2J=16ry9UVoXZwasF7GfN9O4JGwJPx+0Y8zQ@mail.gmail.com>
 <s5h8v7s2tja.wl%tiwai@suse.de>
 <CA+S_cwowFrLAWSRiQvPX5AZwuyo9DdA4qS7Xn3bMYy=AzzpHdg@mail.gmail.com>
 <s5hvcaw18qf.wl%tiwai@suse.de>
 <CA+S_cwq7mDPkjPCVpRecO93UW2gpYo7BpMfFARu0PZCvNT-w4A@mail.gmail.com>
 <s5hsj6017km.wl%tiwai@suse.de>
 <CA+S_cwo2mZn+5P3JuNWXZ+3taQcSHmvRhm95vjupY1o+FA+cpw@mail.gmail.com>
 <s5hobgo16ct.wl%tiwai@suse.de>
 <CA+S_cwqeP90pFpFviKns-bxxBS6ahunPgRfCG0BQTa5ZLPtE-Q@mail.gmail.com>
 <s5hlibs154t.wl%tiwai@suse.de>
 <CA+S_cwoLe=2tUr=EyFM0TxvbBaB12DCE2yDPwf3OzoRcO8jQug@mail.gmail.com>
 <CAN8cciama4q0EOiUsjp-KyyzehcvjwmdPdBQ9vsitbnR8g1PgA@mail.gmail.com>
 <CA+S_cwrmHguxk6WBxjAJTOaV8xV-4PH0gkpibFKs1P8bRxAsAg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ie0-f182.google.com (mail-ie0-f182.google.com
 [209.85.223.182])
 by alsa0.perex.cz (Postfix) with ESMTP id 6BF832650D7
 for <alsa-devel@alsa-project.org>; Thu, 17 Jan 2013 16:29:45 +0100 (CET)
Received: by mail-ie0-f182.google.com with SMTP id s9so4885708iec.41
 for <alsa-devel@alsa-project.org>; Thu, 17 Jan 2013 07:29:44 -0800 (PST)
In-Reply-To: <CA+S_cwrmHguxk6WBxjAJTOaV8xV-4PH0gkpibFKs1P8bRxAsAg@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Miro Hodak <mhodak127@gmail.com>, david.henningsson@canonical.com
Cc: Takashi Iwai <tiwai@suse.de>, basinilya@gmail.com, =?UTF-8?B?TWFub2xvIETDrWF6?= <diaz.manolo@gmail.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

>> >
>> > OK, now as far as Auto-Mute goes, should it do what expected when
enabled - i.e. muting the speakers when headphones are connected to the
front panel? I have tried that, does not seem to work.
>> >
>>
>> Do your computer chassis have a hda front audio panel with Jack
detection ?
>>
>> The front headphone Jack should return true when headphone Jack is
plugged
>>
>> control.35 {
>> iface CARD
>> name 'Front Headphone Jack'
>>
>>
>> value false
>> comment {
>> access read
>> type BOOLEAN
>> count 1
>> }
>> }
>>
>> All ADI codecs support impedance measurement
>>
>> Try the modified hda-jack-sense-test which need hda-analyzer
>>
>> http://thread.gmane.org/gmane.linux.alsa.devel/90911/focus=91115
>
>
> Hmmm, ran into some python issues. Even hda-analyzer itself is not
working:
> ...
> File "/dev/shm/hda-analyzer/hda_proc.py", line 143, in wrongfile
>     raise ValueError, "wrong proc file format (%s)" % msg
> ValueError: wrong proc file format (integer decode 'State of AFG node
0x01:' ('Node '))
>
> Any ideas?

This patch add lines which make the parser of hda_proc.py fail

http://git.kernel.org/?p=linux/kernel/git/tiwai/sound.git;a=commitdiff;h=f4f0a8c4783a0258f2d0020a67fd619ce41a02a3;hp=e4cc6153401fc59d6d4ca0317be5774bdbd399ba
