From: Donglin Peng <dolinux.peng@gmail.com>
Subject: Re: [PATCH v2] ASoC: use DEFINE_SHOW_ATTRIBUTE() to decrease code duplication
Date: Fri, 9 Feb 2018 23:00:05 +0800
Message-ID: <CAErzpmssOG_BH5ex6U1Puh7q6Sd1RMg=gun5g4F7romUE08GTg@mail.gmail.com>
References: <CAErzpmuKgMyxascCdq3KuF1F1K4e2ciZq7FKsOha6WSBgg-WYw@mail.gmail.com>
 <CAHp75Vdm3O5xiemr-H_nF__g43pe_f-Gp6QsOoRW-DXAXrm+YQ@mail.gmail.com>
 <CAErzpmuLvx-61EtXJ=p8dqZ3r-wLSEvmsLOcUz9jzzLzAAsxUA@mail.gmail.com>
 <CAErzpmuX+cTFseghapGdMy84Eg0SVe0niVrGdZhhpLP0uR_phQ@mail.gmail.com> <CAHp75VfK=0-tzkHJj9i8Ne8WboD76xWFmn7AxUMqsaHXaf-bxw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAHp75VfK=0-tzkHJj9i8Ne8WboD76xWFmn7AxUMqsaHXaf-bxw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, ALSA Development Mailing List <alsa-devel@alsa-project.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

On Fri, Feb 9, 2018 at 10:52 PM, Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
> On Fri, Feb 9, 2018 at 4:43 PM, Donglin Peng <dolinux.peng@gmail.com> wrote:
>> There is some duplicate code in soc-core.c, and the kernel provides
>> DEFINE_SHOW_ATTRIBUTE() helper macro to decrease it in seq_file.h.
>>
>
> You missed my tag.
>
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Like this:

There is some duplicate code in soc-core.c, and the kernel provides
DEFINE_SHOW_ATTRIBUTE() helper macro to decrease it in seq_file.h.

Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Signed-off-by: Peng Donglin <dolinux.peng@gmail.com>
