From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: about ALC203 linux driver
Date: Sun, 9 May 2010 15:49:41 +0100
Message-ID: <20100509144940.GA7457@sirena.org.uk>
References: <AANLkTikvaFWOlapz9_HlHc1GBlky_FX1-5ml-iFNGGQW@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 0448B243AC
	for <alsa-devel@alsa-project.org>;
	Sun,  9 May 2010 16:49:42 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <AANLkTikvaFWOlapz9_HlHc1GBlky_FX1-5ml-iFNGGQW@mail.gmail.com>
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
Cc: alsa-devel@alsa-project.org, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
List-Id: alsa-devel@alsa-project.org

On Sun, May 09, 2010 at 10:40:07PM +0800, Wan ZongShun wrote:

> At present, there is a ALC203 AC97 codec in my Winbond ARM board, and
> I am programming
> the audio driver based on ALSA, Who can tell me whether the current
> ALSA is supporting
> the ALC203 driver?how to enable it?

You need a driver for the AC97 controller your system is using (for most
ARM systems this is part of the CPU).  Since AC97 provides a standard
register interface for CODECs Linux does not require specific support
for individual AC97 CODECs in order to get core functionality working.

You can check if there's any specific CODEC support in sound/pci/ac97.
