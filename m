From: Hsin-yu Chao <hychao@chromium.org>
Subject: Re: [PATCH] ucm: add cset-tlv command
Date: Wed, 23 Mar 2016 17:44:31 +0800
Message-ID: <CANyK0Snvs-oJz+God7GBry-DGibW-3Fhyyj3juR73UBkGBAhbg@mail.gmail.com>
References: <1458637834-15947-1-git-send-email-hychao@chromium.org>
 <s5hpoumzqaz.wl-tiwai@suse.de>
 <CANyK0SkCBWQNi1_NX+wvehx9h3M+ZtdCkV4tDp_8zxkpwgQYzQ@mail.gmail.com>
 <s5hlh59eei5.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-oi0-f46.google.com (mail-oi0-f46.google.com
 [209.85.218.46])
 by alsa0.perex.cz (Postfix) with ESMTP id 916D4265832
 for <alsa-devel@alsa-project.org>; Wed, 23 Mar 2016 10:44:32 +0100 (CET)
Received: by mail-oi0-f46.google.com with SMTP id w20so12073034oia.2
 for <alsa-devel@alsa-project.org>; Wed, 23 Mar 2016 02:44:32 -0700 (PDT)
In-Reply-To: <s5hlh59eei5.wl-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: "Koul, Vinod" <vinod.koul@intel.com>, alsa-devel@alsa-project.org, Dylan Reid <dgreid@chromium.org>
List-Id: alsa-devel@alsa-project.org

On Wed, Mar 23, 2016 at 5:21 PM, Takashi Iwai <tiwai@suse.de> wrote:
> On Wed, 23 Mar 2016 10:15:21 +0100,
> Hsin-yu Chao wrote:
>>
>> On Tue, Mar 22, 2016 at 7:48 PM, Takashi Iwai <tiwai@suse.de> wrote:
>> > On Tue, 22 Mar 2016 10:10:34 +0100,
>> > Hsin-Yu Chao wrote:
>> >>
>> >> This patch enables UCM to set a file in TLV format to kcontrol by:
>> >> cset-tlv "name='<kcontrol-name>' <path-to-file>"
>> >> This new 'cset-tlv' command will be used to write audio DSP to
>> >> specific alsa control, where the driver expectes a file in TLV
>> >> format.
>> >>
>> >> Signed-off-by: Hsin-Yu Chao <hychao@chromium.org>
>> >
>> > One problem in this approach is that the provided TLV data file isn't
>> > portable.  Since we deal TLV as int arrays, it's endian-sensitive.
>> > At least, some endian check would be needed.
>> Thanks for the review. I think by extracting the length attribute (i.e
>> tlv[1]) and compare it with the file size is sufficient here, since
>> there is no way to figure out the endianness of the binary file passed
>> in.
>
> Yeah, that should be good enough.
>
>
>> Also I agree that additional check for crazy large or small file is
>> necessary. According to the dsp files I test with, I'll set the tlv
>> file size limit to between 8 bytes and 1MB.
>
> I guess the size will grow quickly in near future, so it'd be safer to
> take a bit bigger.
>
How about using 16MB as upper limit?
DSP file larger than that would take 1 second or more to load through USB 2.0.

Hsin-yu
>
> thanks,
>
> Takashi
