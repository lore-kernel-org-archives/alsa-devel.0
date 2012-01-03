From: Sangsu Park <sangsu@gmail.com>
Subject: Re: [PATCH v2] ASoC: soc-pcm: Allocate PCM operations
 dynamically to support multiple DAIs
Date: Tue, 3 Jan 2012 09:09:20 +0900
Message-ID: <CANh+=Y9F=YxL3QBCWgObYV90HvW63R1pquVOrixNmOPt15tCDQ@mail.gmail.com>
References: <1325492110-12743-1-git-send-email-sangsu4u.park@samsung.com>
	<20120102131949.GL4300@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-gy0-f179.google.com (mail-gy0-f179.google.com
	[209.85.160.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 2291210396B
	for <alsa-devel@alsa-project.org>; Tue,  3 Jan 2012 01:09:22 +0100 (CET)
Received: by ghbz2 with SMTP id z2so4144745ghb.38
	for <alsa-devel@alsa-project.org>; Mon, 02 Jan 2012 16:09:20 -0800 (PST)
In-Reply-To: <20120102131949.GL4300@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: sbkim73@samsung.com, Sangsu Park <sangsu4u.park@samsung.com>, alsa-devel@alsa-project.org, lrg@ti.com
List-Id: alsa-devel@alsa-project.org

On Mon, Jan 2, 2012 at 10:19 PM, Mark Brown
<broonie@opensource.wolfsonmicro.com> wrote:
> On Mon, Jan 02, 2012 at 05:15:10PM +0900, Sangsu Park wrote:
>> The original code does not cover the case that two DAIs(CPU) have differ=
ent
>> ASoC core PCM operations(like mmap, pointer...). Currently we have only =
one
>> global soc_pcm_ops for ASoC core PCM operation. When two DAIs have diffe=
rent
>> pointer functions, second DAI's pointer function is set for both first D=
AI
>> and second DAI in case of original code.
>
>> This patch uses runtime's pcm_ops instead of global pcm_ops for each DAI=
s. So
>> each DAIs can have different ASoC core PCM operations. This is needed to
>> support multiple DAIs.
>
> Applied, thanks.
>
> Actually it's not even allocating them dynamically as we already had the
> allocation happening. =A0:/

You're right. but I don't want to happen any confusion :)
