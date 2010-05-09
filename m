From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: about ALC203 linux driver
Date: Sun, 9 May 2010 18:52:03 +0100
Message-ID: <20100509175202.GA5826@sirena.org.uk>
References: <AANLkTikvaFWOlapz9_HlHc1GBlky_FX1-5ml-iFNGGQW@mail.gmail.com>
	<20100509144940.GA7457@sirena.org.uk>
	<AANLkTik0GudetGLF9hF56_VV_tNci8wX0S67gAWDIayq@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 01F2B244A2
	for <alsa-devel@alsa-project.org>;
	Sun,  9 May 2010 19:52:06 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <AANLkTik0GudetGLF9hF56_VV_tNci8wX0S67gAWDIayq@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Wan ZongShun <mcuos.com@gmail.com>
Cc: alsa-devel@alsa-project.org, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, zswan@marvell.com
List-Id: alsa-devel@alsa-project.org

On Sun, May 09, 2010 at 11:34:28PM +0800, Wan ZongShun wrote:

> here, I used the file named ac97.c which is located in
> linux-2.6\sound\soc\codecs.
> I am sure that it can call the '\sound\pci\ac97ac97_codec.c' file and
> identify the
> ALC203 (like the log file shows 'nuc900 AC'97 codec is  ALC203',but sometimes
> the return value by reading one AC97 register, which is not same as
> the writing value to the
> AC97 register, that is not my expected result, but sometimes they are same.

> any suggestions?

Not all AC97 registers are writable so check that you're writing to
registers that the CODEC supports writing to but in general you're going
to need to debug your controller driver here.  Make sure you're
interacting well with any cache the controller has and that you are
properly synchronising with the controller during reads (which are
fairly slow operations on AC97).

Also make sure that the CODEC is properly clocked.
