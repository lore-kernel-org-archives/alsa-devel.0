From: Manuel Lauss <manuel.lauss@googlemail.com>
Subject: Re: [RFC PATCH 2/3] MIPS: Alchemy: DB1200 AC97+I2S
	audio support.
Date: Tue, 3 Nov 2009 12:00:19 +0100
Message-ID: <f861ec6f0911030300l130e58cl8d4915af5eec9238@mail.gmail.com>
References: <1257193305-29996-1-git-send-email-manuel.lauss@gmail.com>
	<1257193305-29996-2-git-send-email-manuel.lauss@gmail.com>
	<20091103104337.GA26068@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from fg-out-1718.google.com (fg-out-1718.google.com [72.14.220.157])
	by alsa0.perex.cz (Postfix) with ESMTP id 3B6A024437
	for <alsa-devel@alsa-project.org>; Tue,  3 Nov 2009 12:00:20 +0100 (CET)
Received: by fg-out-1718.google.com with SMTP id 19so310322fgg.2
	for <alsa-devel@alsa-project.org>; Tue, 03 Nov 2009 03:00:19 -0800 (PST)
In-Reply-To: <20091103104337.GA26068@opensource.wolfsonmicro.com>
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
Cc: Linux-MIPS <linux-mips@linux-mips.org>, alsa-devel@alsa-project.org, Manuel Lauss <manuel.lauss@gmail.com>
List-Id: alsa-devel@alsa-project.org

On Tue, Nov 3, 2009 at 11:43 AM, Mark Brown
<broonie@opensource.wolfsonmicro.com> wrote:
> On Mon, Nov 02, 2009 at 09:21:44PM +0100, Manuel Lauss wrote:
>> Machine driver for DB1200 AC97 and I2S audio systems, intended as a
>> proper reference asoc machine for Alchemy-based systems.
>> AC97/I2S can be selected at boot time by setting switch S6.7
>>
>> Cc: alsa-devel@alsa-project.org
>> Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>
>> Signed-off-by: Manuel Lauss <manuel.lauss@gmail.com>
>
> This looks good for me. =A0The patch touches both ASoC and MIPS trees -
> I'm happy with it being merged though either.

Thanks for having a look!  I'd rather have it go through the MIPS tree,
otherwise there's a higher chance of merge conflicts.

Manuel Lauss
