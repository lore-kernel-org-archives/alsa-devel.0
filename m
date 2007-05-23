From: albox@free.fr
Subject: Re: support for Medion laptops
Date: Thu, 24 May 2007 01:58:29 +0200
Message-ID: <1179964709.4654d5255a716@imp.free.fr>
References: <1178247400.463aa0e822cbd@imp.free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp5-g19.free.fr (smtp5-g19.free.fr [212.27.42.35])
	by alsa0.perex.cz (Postfix) with ESMTP id CDAD524696
	for <alsa-devel@alsa-project.org>;
	Thu, 24 May 2007 00:58:29 +0200 (CEST)
Received: from imp3-g19.free.fr (imp3-g19.free.fr [212.27.42.3])
	by smtp5-g19.free.fr (Postfix) with ESMTP id 721204515C
	for <alsa-devel@alsa-project.org>;
	Thu, 24 May 2007 00:58:29 +0200 (CEST)
In-Reply-To: <1178247400.463aa0e822cbd@imp.free.fr>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

I haven't get any news since my last email 2 weeks ago. Can anybody help me to
find where the problem comes from ?

Quoting albox@free.fr:

> I have just installed 1.0.14rc4. Here are the logs :
>
> [   20.132000] ALSA
>
/home/alboot/Sources/alsa1.0.14rc4/alsa-driver-1.0.14rc4/pci/hda/../../alsa-kernel/pci/hda/hda_intel.c:698:
> codec_mask = 0x3
> [   20.308000] ALSA
>
/home/alboot/Sources/alsa1.0.14rc4/alsa-driver-1.0.14rc4/pci/hda/hda_codec.c:1820:
> hda_codec: model 'medion' is selected for config 161f:2054 (Medion laptop)
> [   21.032000] ALSA
>
/home/alboot/Sources/alsa1.0.14rc4/alsa-driver-1.0.14rc4/pci/hda/../../alsa-kernel/pci/hda/patch_si3054.c:245:
> si3054: cannot initialize. EXT MID = 0000
> [   21.040000] ALSA
>
/home/alboot/Sources/alsa1.0.14rc4/alsa-driver-1.0.14rc4/pci/hda/../../alsa-kernel/pci/hda/patch_si3054.c:257:
> Link Frame Detect(FDT) is not ready (line status: 0000)
> [   71.352000] ALSA
>
/home/alboot/Sources/alsa1.0.14rc4/alsa-driver-1.0.14rc4/pci/hda/../../alsa-kernel/pci/hda/hda_intel.c:1188:
> azx_pcm_prepare: bufsize=0x10000, fragsize=0x1000, format=0x11
> [   71.352000] ALSA
>
/home/alboot/Sources/alsa1.0.14rc4/alsa-driver-1.0.14rc4/pci/hda/hda_codec.c:630:
> hda_codec_setup_stream: NID=0x2, stream=0x5, channel=0, format=0x11
> [   71.360000] ALSA
>
/home/alboot/Sources/alsa1.0.14rc4/alsa-driver-1.0.14rc4/pci/hda/hda_codec.c:630:
> hda_codec_setup_stream: NID=0x4, stream=0x5, channel=0, format=0x11
> [   71.368000] ALSA
>
/home/alboot/Sources/alsa1.0.14rc4/alsa-driver-1.0.14rc4/pci/hda/hda_codec.c:630:
> hda_codec_setup_stream: NID=0x3, stream=0x5, channel=0, format=0x11
> [   71.380000] ALSA
>
/home/alboot/Sources/alsa1.0.14rc4/alsa-driver-1.0.14rc4/pci/hda/hda_codec.c:630:
> hda_codec_setup_stream: NID=0x5, stream=0x5, channel=0, format=0x11
> [   71.480000] ALSA
>
/home/alboot/Sources/alsa1.0.14rc4/alsa-driver-1.0.14rc4/pci/hda/hda_codec.c:630:
> hda_codec_setup_stream: NID=0x2, stream=0x0, channel=0, format=0x0
> [   71.488000] ALSA
>
/home/alboot/Sources/alsa1.0.14rc4/alsa-driver-1.0.14rc4/pci/hda/hda_codec.c:630:
> hda_codec_setup_stream: NID=0x4, stream=0x0, channel=0, format=0x0
> [   71.496000] ALSA
>
/home/alboot/Sources/alsa1.0.14rc4/alsa-driver-1.0.14rc4/pci/hda/hda_codec.c:630:
> hda_codec_setup_stream: NID=0x3, stream=0x0, channel=0, format=0x0
> [   71.504000] ALSA
>
/home/alboot/Sources/alsa1.0.14rc4/alsa-driver-1.0.14rc4/pci/hda/hda_codec.c:630:
> hda_codec_setup_stream: NID=0x5, stream=0x0, channel=0, format=0x0
> [   71.524000] ALSA
>
/home/alboot/Sources/alsa1.0.14rc4/alsa-driver-1.0.14rc4/pci/hda/../../alsa-kernel/pci/hda/hda_intel.c:1188:
> azx_pcm_prepare: bufsize=0x10000, fragsize=0x1000, format=0x11
> [   71.524000] ALSA
>
/home/alboot/Sources/alsa1.0.14rc4/alsa-driver-1.0.14rc4/pci/hda/hda_codec.c:630:
> hda_codec_setup_stream: NID=0x2, stream=0x5, channel=0, format=0x11
> [   71.532000] ALSA
>
/home/alboot/Sources/alsa1.0.14rc4/alsa-driver-1.0.14rc4/pci/hda/hda_codec.c:630:
> hda_codec_setup_stream: NID=0x4, stream=0x5, channel=0, format=0x11
> [   71.540000] ALSA
>
/home/alboot/Sources/alsa1.0.14rc4/alsa-driver-1.0.14rc4/pci/hda/hda_codec.c:630:
> hda_codec_setup_stream: NID=0x3, stream=0x5, channel=0, format=0x11
> [   71.548000] ALSA
>
/home/alboot/Sources/alsa1.0.14rc4/alsa-driver-1.0.14rc4/pci/hda/hda_codec.c:630:
> hda_codec_setup_stream: NID=0x5, stream=0x5, channel=0, format=0x11
> [   71.560000] ALSA
>
/home/alboot/Sources/alsa1.0.14rc4/alsa-driver-1.0.14rc4/pci/hda/hda_codec.c:630:
> hda_codec_setup_stream: NID=0x2, stream=0x0, channel=0, format=0x0
> [   71.568000] ALSA
>
/home/alboot/Sources/alsa1.0.14rc4/alsa-driver-1.0.14rc4/pci/hda/hda_codec.c:630:
> hda_codec_setup_stream: NID=0x4, stream=0x0, channel=0, format=0x0
> [   71.576000] ALSA
>
/home/alboot/Sources/alsa1.0.14rc4/alsa-driver-1.0.14rc4/pci/hda/hda_codec.c:630:
> hda_codec_setup_stream: NID=0x3, stream=0x0, channel=0, format=0x0
> [   71.584000] ALSA
>
/home/alboot/Sources/alsa1.0.14rc4/alsa-driver-1.0.14rc4/pci/hda/hda_codec.c:630:
> hda_codec_setup_stream: NID=0x5, stream=0x0, channel=0, format=0x0
> [   71.752000] ALSA
>
/home/alboot/Sources/alsa1.0.14rc4/alsa-driver-1.0.14rc4/pci/hda/../../alsa-kernel/pci/hda/hda_intel.c:1188:
> azx_pcm_prepare: bufsize=0x10000, fragsize=0x1000, format=0x11
> [   71.752000] ALSA
>
/home/alboot/Sources/alsa1.0.14rc4/alsa-driver-1.0.14rc4/pci/hda/hda_codec.c:630:
> hda_codec_setup_stream: NID=0x2, stream=0x5, channel=0, format=0x11
> [   71.760000] ALSA
>
/home/alboot/Sources/alsa1.0.14rc4/alsa-driver-1.0.14rc4/pci/hda/hda_codec.c:630:
> hda_codec_setup_stream: NID=0x4, stream=0x5, channel=0, format=0x11
> [   71.768000] ALSA
>
/home/alboot/Sources/alsa1.0.14rc4/alsa-driver-1.0.14rc4/pci/hda/hda_codec.c:630:
> hda_codec_setup_stream: NID=0x3, stream=0x5, channel=0, format=0x11
> [   71.776000] ALSA
>
/home/alboot/Sources/alsa1.0.14rc4/alsa-driver-1.0.14rc4/pci/hda/hda_codec.c:630:
> hda_codec_setup_stream: NID=0x5, stream=0x5, channel=0, format=0x11
>
> If you want more information, let me know...
