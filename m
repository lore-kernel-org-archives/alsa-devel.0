From: Code Kipper <codekipper@gmail.com>
Subject: Re: [linux-sunxi][alsa-devel][PATCH 0/3]Add SPDIF support for
 Allwinner SoCs
Date: Thu, 24 Sep 2015 16:31:36 +0200
Message-ID: <CAEKpxBkU0ss=4j6i=gLRqodHukEHmsF1m_cJmu696jsCtTyDRQ@mail.gmail.com>
References: <1443031494-32469-1-git-send-email-codekipper@gmail.com>
	<CAEKpxB=9nX6W7xpuQN5naqkkyEG-tkttfmFfs1JNgvpz=_UpEw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAEKpxB=9nX6W7xpuQN5naqkkyEG-tkttfmFfs1JNgvpz=_UpEw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Liam Girdwood <lgirdwood@gmail.com>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Cc: broonie@kernel.org, linux-sunxi <linux-sunxi@googlegroups.com>, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, Maxime Ripard <maxime.ripard@free-electrons.com>, "Andrea Venturi (pers)" <be17068@iperbole.bo.it>, Marcus Cooper <codekipper@gmail.com>
List-Id: alsa-devel@alsa-project.org

On 23 September 2015 at 20:41, Code Kipper <codekipper@gmail.com> wrote:
> Hi All,
> I'm getting a "fatal: 'send-email'" response with the last patch(even
> though the dry run of the patch series worked) and I've not been able
> to work around it. I'll post it as soon as I can work out what the
> issue is,
DONE
> BR,
> CK
>
> On 23 September 2015 at 20:04,  <codekipper@gmail.com> wrote:
>> From: Marcus Cooper <codekipper@gmail.com>
>>
>> This patch set adds support for the Allwinner SPDIF transceiver as present
>> on the A10, A20 and A31 SoC boards.
>>
>> For now just the SPDIF transmitter has been tested on a Mele A2000.
>>
>> In order for this patch set to be functional we require audio clock patches
>> which will be delivered separately. For those that are interested I've pushed
>> the patches here with all the required changes to get SPDIF audio out of the
>> device.
>>
>> https://github.com/codekipper/linux-sunxi/commits/spdif_delivery
>>
>> Thanks in advance,
>> CK
>>
>> Marcus Cooper (3):
>>   dt-bindings: add sunxi SPDIF transceiver bindings
>>   dt-binding: Add sunxi SPDIF machine driver
>>   ASOC: sunxi: Add support for the spdif block
>>
>>  .../devicetree/bindings/sound/sunxi,spdif.txt      |  49 ++
>>  .../bindings/sound/sunxi-audio-spdif.txt           |  36 +
>>  sound/soc/sunxi/Kconfig                            |  10 +
>>  sound/soc/sunxi/Makefile                           |   4 +
>>  sound/soc/sunxi/sunxi-machine-spdif.c              | 110 +++
>>  sound/soc/sunxi/sunxi-spdif.c                      | 801 +++++++++++++++++++++
>>  6 files changed, 1010 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/sound/sunxi,spdif.txt
>>  create mode 100644 Documentation/devicetree/bindings/sound/sunxi-audio-spdif.txt
>>  create mode 100644 sound/soc/sunxi/sunxi-machine-spdif.c
>>  create mode 100644 sound/soc/sunxi/sunxi-spdif.c
>>
>> --
>> 2.5.3
>>
