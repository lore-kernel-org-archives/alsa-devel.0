From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [RFC PATCH 2/3] MIPS: Alchemy: DB1200 AC97+I2S
	audio support.
Date: Tue, 3 Nov 2009 10:43:37 +0000
Message-ID: <20091103104337.GA26068@opensource.wolfsonmicro.com>
References: <1257193305-29996-1-git-send-email-manuel.lauss@gmail.com>
	<1257193305-29996-2-git-send-email-manuel.lauss@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 59A8E2440A
	for <alsa-devel@alsa-project.org>; Tue,  3 Nov 2009 11:43:40 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1257193305-29996-2-git-send-email-manuel.lauss@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Manuel Lauss <manuel.lauss@googlemail.com>
Cc: Linux-MIPS <linux-mips@linux-mips.org>, alsa-devel@alsa-project.org, Manuel Lauss <manuel.lauss@gmail.com>
List-Id: alsa-devel@alsa-project.org

On Mon, Nov 02, 2009 at 09:21:44PM +0100, Manuel Lauss wrote:
> Machine driver for DB1200 AC97 and I2S audio systems, intended as a
> proper reference asoc machine for Alchemy-based systems.
> AC97/I2S can be selected at boot time by setting switch S6.7
> 
> Cc: alsa-devel@alsa-project.org
> Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>
> Signed-off-by: Manuel Lauss <manuel.lauss@gmail.com>

This looks good for me.  The patch touches both ASoC and MIPS trees -
I'm happy with it being merged though either.
