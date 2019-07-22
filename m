From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [alsa-devel] [PATCH] ASoC: SOF: use __u32 instead of uint32_t in
 uapi headers
Date: Mon, 22 Jul 2019 17:21:30 +0200
Message-ID: <CAK8P3a29JcyMOfGGSpRCyeS913BSGn5bJT_pZ9e-K3Ds1E0UHw@mail.gmail.com>
References: <20190721142308.30306-1-yamada.masahiro@socionext.com>
 <de9e94ee-9c01-1c0c-4359-b637319a298f@linux.intel.com> <s5hftmy8byl.wl-tiwai@suse.de>
 <ec306745-052d-f52c-2cce-d8915822d4ff@linux.intel.com> <CAK8P3a2tLuqu+upt0nW8dUzXc+t_kEJwVhLcqY8TXydHLb_nCw@mail.gmail.com>
 <9a56ccdb-397b-3046-4043-49bc20aaa804@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <9a56ccdb-397b-3046-4043-49bc20aaa804@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: Takashi Iwai <tiwai@suse.de>, ALSA Development Mailing List <alsa-devel@alsa-project.org>, Mark Brown <broonie@kernel.org>, Masahiro Yamada <yamada.masahiro@socionext.com>, Liam Girdwood <liam.r.girdwood@linux.intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

On Mon, Jul 22, 2019 at 5:18 PM Pierre-Louis Bossart
<pierre-louis.bossart@linux.intel.com> wrote:
> On 7/22/19 8:34 AM, Arnd Bergmann wrote:
> > On Mon, Jul 22, 2019 at 3:16 PM Pierre-Louis Bossart
> > <pierre-louis.bossart@linux.intel.com> wrote:
> >> On 7/22/19 7:56 AM, Takashi Iwai wrote:
> >>> On Mon, 22 Jul 2019 14:49:34 +0200,
> >> Our goal is to minimize the differences and allow deltas e.g. for
> >> license or comments. We could add a definition for __u32 when linux is
> >> not used, I am just not sure if these two files really fall in the UAPI
> >> category and if the checks make sense.
> >
> > If you can build all the SOF user space without these headers being
> > installed to /usr/include/sound/sof/, you can move them from
> > include/uapi/sound/sof to include/sounds/sof and leave the types
> > unchanged.
>
> yes we don't need those files to build userspace stuff. The idea was
> that these format definitions establish a contract between userspace
> (more specifically the files stored in /lib/firmware) and the kernel.
> IIRC we wanted to make sure that any changes would be tracked as
> breaking userspace. If the consensus is that the uapi directory is
> strictly used for builds then we should indeed move those files

I don't see a problem with keeping the files in uapi for practical
purposes, but then I think it makes sense to apply the same rules as
for other uapi headers and use user-space clean type names.

       Arnd
