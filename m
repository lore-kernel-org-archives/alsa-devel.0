From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH] ASoC: SOF: use __u32 instead of uint32_t
 in uapi headers
Date: Mon, 22 Jul 2019 10:19:53 -0500
Message-ID: <fdd24e93-efad-0132-e1ff-b7f5f87e8efc@linux.intel.com>
References: <20190721142308.30306-1-yamada.masahiro@socionext.com>
 <CAK8P3a01MzCTJnk_fuMgWsRBa3u_CEZegZqH37G7qLiquHWncA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 84278F800F5
 for <alsa-devel@alsa-project.org>; Mon, 22 Jul 2019 17:19:55 +0200 (CEST)
In-Reply-To: <CAK8P3a01MzCTJnk_fuMgWsRBa3u_CEZegZqH37G7qLiquHWncA@mail.gmail.com>
Content-Language: en-US
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Arnd Bergmann <arnd@arndb.de>, Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: ALSA Development Mailing List <alsa-devel@alsa-project.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Takashi Iwai <tiwai@suse.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Liam Girdwood <liam.r.girdwood@linux.intel.com>, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org



On 7/22/19 8:39 AM, Arnd Bergmann wrote:
> On Sun, Jul 21, 2019 at 4:25 PM Masahiro Yamada
> <yamada.masahiro@socionext.com> wrote:
>>
>>   struct snd_sof_blk_hdr {
>>          enum snd_sof_fw_blk_type type;
>> -       uint32_t size;          /* bytes minus this header */
>> -       uint32_t offset;        /* offset from base */
>> +       __u32 size;             /* bytes minus this header */
>> +       __u32 offset;           /* offset from base */
>>   } __packed;
>>
> 
> On a related note: Using an 'enum' in an ABI structure is not portable
> across architectures. This is probably fine in a UAPI as long as user
> and kernel space agree on the size of an enum, but if the same
> structure is used to talk to the firmware, it won't work on architectures
> that have a different size for the first field.

yes, we've removed all enums in SOF and missed this one. This should be 
changed, thanks for the note.
