From: Keyon <yang.jie@linux.intel.com>
Subject: Re: linux-next: Tree for Oct 20 (sound/soc/intel)
Date: Wed, 21 Oct 2015 20:27:00 +0800
Message-ID: <56278494.4080401@linux.intel.com>
References: <20151020162604.4b5b6381@canb.auug.org.au>
 <56266FE5.6090304@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-next-owner@vger.kernel.org>
In-Reply-To: <56266FE5.6090304@infradead.org>
Sender: linux-next-owner@vger.kernel.org
To: Randy Dunlap <rdunlap@infradead.org>, Stephen Rothwell <sfr@canb.auug.org.au>, linux-next@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, moderated for non-subscribers <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org


On 2015=E5=B9=B410=E6=9C=8821=E6=97=A5 00:46, Randy Dunlap wrote:
> On 10/19/15 22:26, Stephen Rothwell wrote:
>> Hi all,
>>
>> Changes since 20151019:
>>
> on x86_64:
>
> when CONFIG_DW_DMAC is not enabled.
>
>
> sound/built-in.o: In function `sst_dma_new':
> (.text+0xd7b38): undefined reference to `dw_dma_probe'
> sound/built-in.o: In function `sst_dma_free':
> (.text+0xd7c0a): undefined reference to `dw_dma_remove'
>
>
> Full randconfig file is attached.
>

thanks for reporting it, will submit patch to fix it soon.

~Keyon
