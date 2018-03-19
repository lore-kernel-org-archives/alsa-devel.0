From: Ruslan Bilovol <ruslan.bilovol@gmail.com>
Subject: Re: [PATCH v2 2/2] ALSA: usb: initial USB Audio Device Class 3.0 support
Date: Tue, 20 Mar 2018 01:57:46 +0200
Message-ID: <CAB=otbQ-5_G3Y8i5AmRcWE6KuLb_aEYEO1-ZDcNLH73ojCEE-g@mail.gmail.com>
References: <1521423963-24677-1-git-send-email-ruslan.bilovol@gmail.com>
 <1521423963-24677-3-git-send-email-ruslan.bilovol@gmail.com> <s5h1sggvxkn.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <s5h1sggvxkn.wl-tiwai@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Jorge <jorge.sanjuan@codethink.co.uk>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Mon, Mar 19, 2018 at 6:28 PM, Takashi Iwai <tiwai@suse.de> wrote:
> On Mon, 19 Mar 2018 02:46:03 +0100,
> Ruslan Bilovol wrote:
>>
>> Recently released USB Audio Class 3.0 specification
>> introduces many significant changes comparing to
>> previous versions, like
>>  - new Power Domains, support for LPM/L1
>>  - new Cluster descriptor
>>  - changed layout of all class-specific descriptors
>>  - new High Capability descriptors
>>  - New class-specific String descriptors
>>  - new and removed units
>>  - additional sources for interrupts
>>  - removed Type II Audio Data Formats
>>  - ... and many other things (check spec)
>>
>> It also provides backward compatibility through
>> multiple configurations, as well as requires
>> mandatory support for BADD (Basic Audio Device
>> Definition) on each ADC3.0 compliant device
>>
>> This patch adds initial support of UAC3 specification
>> that is enough for Generic I/O Profile (BAOF, BAIF)
>> device support from BADD document.
>>
>> Signed-off-by: Ruslan Bilovol <ruslan.bilovol@gmail.com>
>
> Most code changes look fairly straightforward, and not breaking the
> UAC1/UAC2 stuff.  So the stuff is good enough through a quick glance.
>
> I suppose it's better to merge via sound git tree.
> Greg, could you check include/linux/usb/* (and uapi) stuff and give an
> ack if it's OK?
>
> In anyway, I'll check the specs and compare with the definitions in
> this patch.

Please note that I took "A.12 CHANNEL RELATIONSHIP
DEFINITIONS" values from previous Pierre's email (they were
in a draft UAC3 spec but disappeared in the final version).
I've sent an email with my quiestions to audio-chair@usb.org but
didn't get any reply from them yet.

>
>
> And, just minor nitpicking regarding the code change:
>
> it's better to drop the parentheses in a line like below
>
>> +             if ((protocol == UAC_VERSION_1) || (protocol == UAC_VERSION_2)) {
>
> that is,
>                 if (protocol == UAC_VERSION_1 || protocol == UAC_VERSION_2) {
>
> The indentation became so deep in some functions, and it's better to
> refactor, but this can be done later once after all implementations
> are finished.

Sure, I fixed these and also kbuild test robot's complaint; if there
will no any more comments, I'm going to send v3 tomorrow.

Thanks,
Ruslan
