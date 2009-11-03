From: Manuel Lauss <manuel.lauss@googlemail.com>
Subject: Re: [RFC PATCH 2/3] MIPS: Alchemy: DB1200 AC97+I2S
	audio support.
Date: Tue, 3 Nov 2009 16:30:26 +0100
Message-ID: <f861ec6f0911030730k53b2b921kddc8c67266846af2@mail.gmail.com>
References: <1257193305-29996-1-git-send-email-manuel.lauss@gmail.com>
	<1257193305-29996-2-git-send-email-manuel.lauss@gmail.com>
	<20091103153040.GC1742@linux-mips.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bw0-f217.google.com (mail-bw0-f217.google.com
	[209.85.218.217])
	by alsa0.perex.cz (Postfix) with ESMTP id 7D964103902
	for <alsa-devel@alsa-project.org>; Tue,  3 Nov 2009 16:30:29 +0100 (CET)
Received: by bwz9 with SMTP id 9so24202906bwz.32
	for <alsa-devel@alsa-project.org>; Tue, 03 Nov 2009 07:30:27 -0800 (PST)
In-Reply-To: <20091103153040.GC1742@linux-mips.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Ralf Baechle <ralf@linux-mips.org>
Cc: Linux-MIPS <linux-mips@linux-mips.org>, alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Manuel Lauss <manuel.lauss@gmail.com>
List-Id: alsa-devel@alsa-project.org

On Tue, Nov 3, 2009 at 4:30 PM, Ralf Baechle <ralf@linux-mips.org> wrote:
> On Mon, Nov 02, 2009 at 09:21:44PM +0100, Manuel Lauss wrote:
>
>> Machine driver for DB1200 AC97 and I2S audio systems, intended as a
>> proper reference asoc machine for Alchemy-based systems.
>> AC97/I2S can be selected at boot time by setting switch S6.7
>>
>> Cc: alsa-devel@alsa-project.org
>> Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>
>> Signed-off-by: Manuel Lauss <manuel.lauss@gmail.com>
>> ---
>> Depends on patch "ASoC: au1x: convert to platform drivers" in
>> Mark Brown's asoc tree to actually work.
>
> Queued for 2.6.33. =A0I've not seen the dependency but I hope there is no
> harm in getting things merged out of order?

You just won't get any sound if the other patch isnt applied first,
no build failures of oopses.

Manuel
