From: Hsin-yu Chao <hychao@chromium.org>
Subject: Re: [PATCH v3] ucm: add cset-tlv
Date: Wed, 13 Apr 2016 14:24:22 +0800
Message-ID: <CANyK0Smuaia9msS=zMrDjFzZH+mkZ-AymkU17RE1jcOMYuZnng@mail.gmail.com>
References: <1458786501-8914-1-git-send-email-hychao@chromium.org>
 <s5h60wcau8i.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ob0-f180.google.com (mail-ob0-f180.google.com
 [209.85.214.180])
 by alsa0.perex.cz (Postfix) with ESMTP id CBEEC2650DB
 for <alsa-devel@alsa-project.org>; Wed, 13 Apr 2016 08:24:23 +0200 (CEST)
Received: by mail-ob0-f180.google.com with SMTP id bg3so26900991obb.1
 for <alsa-devel@alsa-project.org>; Tue, 12 Apr 2016 23:24:23 -0700 (PDT)
In-Reply-To: <s5h60wcau8i.wl-tiwai@suse.de>
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

Hi Takashi,
Really sorry for missed your reply for so long due to a problem of my
inbox filter...
I will upload a new patch to address your comments.

Thanks,
Hsin-yu

On Thu, Mar 24, 2016 at 9:19 PM, Takashi Iwai <tiwai@suse.de> wrote:
> On Thu, 24 Mar 2016 03:28:21 +0100,
> Hsin-Yu Chao wrote:
>>
>> This patch enables UCM to set a file in TLV format to kcontrol by:
>> cset-tlv "name='<kcontrol-name>' <path-to-file>"
>> This new 'cset-tlv' command will be used to write audio DSP to
>> specific alsa control, where the driver expectes a file in TLV
>> format.
>> The TLV file to set to kcontrol will be checked first by file size
>> not larger than 16 MB, and then examine if the length field reports
>> correct number of bytes in the TLV file.
>>
>> Signed-off-by: Hsin-Yu Chao <hychao@chromium.org>
>> ---
>>  src/ucm/main.c      | 91 +++++++++++++++++++++++++++++++++++++++++++++--------
>>  src/ucm/parser.c    | 10 ++++++
>>  src/ucm/ucm_local.h |  1 +
>>  3 files changed, 89 insertions(+), 13 deletions(-)
>>
>> diff --git a/src/ucm/main.c b/src/ucm/main.c
>> index 7e44603..d0929a2 100644
>> --- a/src/ucm/main.c
>> +++ b/src/ucm/main.c
>> @@ -161,6 +161,54 @@ static int open_ctl(snd_use_case_mgr_t *uc_mgr,
>>       return 0;
>>  }
>>
>> +static int read_tlv_file(char **res,
>> +                      const char *filepath)
>> +{
>> +     int err = 0;
>> +     int fd;
>> +     struct stat st;
>> +     size_t sz;
>> +     ssize_t sz_read;
>> +     unsigned int *tlv;
>> +
>> +     fd = open(filepath, O_RDONLY);
>> +     if (fd < 0) {
>> +             err = -errno;
>> +             return err;
>> +     }
>> +     if (stat(filepath, &st) == -1) {
>
> Better to use fstat() with the opened fd.
>
>
>> +             err = -errno;
>> +             goto __fail;
>> +     }
>> +     sz = st.st_size;
>> +     if (sz > 16 * 1024 * 1024 || sz < 8) {
>> +             uc_error("File size should be less than 16 MB");
>> +             goto __fail;
>
> The error code is missing.
>
>
>> +     }
>> +     *res = malloc(sz);
>> +     if (res == NULL) {
>> +             err = -ENOMEM;
>> +             goto __fail;
>> +     }
>> +     sz_read = read(fd, *res, sz);
>> +     if (sz_read < 0 || (size_t)sz_read != sz) {
>> +             err = -errno;
>
> The size shortage won't set the errno.  You'd need to give the error
> code explicitly, or repeat the read.
>
>
>> +             free(*res);
>> +             *res = NULL;
>> +     }
>> +     /* Check if the tlv file specifies valid size. */
>> +     tlv = (unsigned int *)(*res);
>> +     if (tlv[1] + 2 * sizeof(unsigned int) != sz) {
>> +             uc_error("Invalid tlv size");
>> +             free(*res);
>> +             *res = NULL;
>
> The missing error code.
>
>
> thanks,
>
> Takashi
