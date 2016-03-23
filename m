From: Hsin-yu Chao <hychao@chromium.org>
Subject: Re: [PATCH] ucm: add cset-tlv command
Date: Wed, 23 Mar 2016 17:15:21 +0800
Message-ID: <CANyK0SkCBWQNi1_NX+wvehx9h3M+ZtdCkV4tDp_8zxkpwgQYzQ@mail.gmail.com>
References: <1458637834-15947-1-git-send-email-hychao@chromium.org>
 <s5hpoumzqaz.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-oi0-f48.google.com (mail-oi0-f48.google.com
 [209.85.218.48])
 by alsa0.perex.cz (Postfix) with ESMTP id 949082619BF
 for <alsa-devel@alsa-project.org>; Wed, 23 Mar 2016 10:15:22 +0100 (CET)
Received: by mail-oi0-f48.google.com with SMTP id d205so11177016oia.0
 for <alsa-devel@alsa-project.org>; Wed, 23 Mar 2016 02:15:22 -0700 (PDT)
In-Reply-To: <s5hpoumzqaz.wl-tiwai@suse.de>
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

On Tue, Mar 22, 2016 at 7:48 PM, Takashi Iwai <tiwai@suse.de> wrote:
> On Tue, 22 Mar 2016 10:10:34 +0100,
> Hsin-Yu Chao wrote:
>>
>> This patch enables UCM to set a file in TLV format to kcontrol by:
>> cset-tlv "name='<kcontrol-name>' <path-to-file>"
>> This new 'cset-tlv' command will be used to write audio DSP to
>> specific alsa control, where the driver expectes a file in TLV
>> format.
>>
>> Signed-off-by: Hsin-Yu Chao <hychao@chromium.org>
>
> One problem in this approach is that the provided TLV data file isn't
> portable.  Since we deal TLV as int arrays, it's endian-sensitive.
> At least, some endian check would be needed.
Thanks for the review. I think by extracting the length attribute (i.e
tlv[1]) and compare it with the file size is sufficient here, since
there is no way to figure out the endianness of the binary file passed
in.
Also I agree that additional check for crazy large or small file is
necessary. According to the dsp files I test with, I'll set the tlv
file size limit to between 8 bytes and 1MB.
Will upload a v2 patch shortly, thanks!

Hsin-yu
>
> Some other nitpicks:
>
>> ---
>>  src/ucm/main.c      | 80 ++++++++++++++++++++++++++++++++++++++++++++---------
>>  src/ucm/parser.c    | 10 +++++++
>>  src/ucm/ucm_local.h |  1 +
>>  3 files changed, 78 insertions(+), 13 deletions(-)
>>
>> diff --git a/src/ucm/main.c b/src/ucm/main.c
>> index 7e44603..a4ccb65 100644
>> --- a/src/ucm/main.c
>> +++ b/src/ucm/main.c
>> @@ -161,6 +161,47 @@ static int open_ctl(snd_use_case_mgr_t *uc_mgr,
>>       return 0;
>>  }
>>
>> +static int tlv_parse(char **res,
>> +                  snd_ctl_elem_info_t *info,
>> +                  const char *filepath)
>
> The function name is somehow confusing.  It appears as if it parses
> TLV.  And what it actually does are two things:
> - check snd_ctl_elem_info_is_tlv_writable(),
> and
> - allocate the whole TLV file.
>
> IMO, snd_ctl_elem_info_is_tlv_writable() check can be in the caller
> side, and this function (rename whatever better) can just do allocate
> and read the TLV data into a buffer.
>
>
>> +{
>> +     int err = 0;
>> +     int fd;
>> +     struct stat st;
>> +     size_t sz;
>> +     ssize_t sz_read;
>> +
>> +     if (!snd_ctl_elem_info_is_tlv_writable(info)) {
>> +             err = -EINVAL;
>> +             return err;
>> +     }
>> +     fd = open(filepath, O_RDONLY);
>> +     if (fd < 0) {
>> +             err = -errno;
>> +             return err;
>> +     }
>> +     if (stat(filepath, &st) == -1) {
>> +             err = -errno;
>> +             goto __fail;
>> +     }
>> +     sz = st.st_size;
>> +     *res = malloc(sz);
>
> What if a crazy large file was passed?  A sanity check of the file
> size might be good.
>
>
> thanks,
>
> Takashi
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
