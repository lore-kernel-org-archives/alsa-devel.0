From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: What is a name for the PC speaker input/output
 volume control?
Date: Wed, 11 Nov 2009 15:18:35 +0100 (CET)
Message-ID: <alpine.LNX.2.00.0911111516560.4806@eeebox2.perex-int.cz>
References: <20091111151258.61598339.krzysztof.h1@poczta.fm>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (unknown [212.20.107.53])
	by alsa0.perex.cz (Postfix) with ESMTP id C978010381D
	for <alsa-devel@alsa-project.org>; Wed, 11 Nov 2009 15:18:36 +0100 (CET)
In-Reply-To: <20091111151258.61598339.krzysztof.h1@poczta.fm>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Krzysztof Helt <krzysztof.h1@poczta.fm>
Cc: Takashi Iwai <tiwai@suse.de>, Alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Wed, 11 Nov 2009, Krzysztof Helt wrote:

> Hi Takashi,
>
> I have run into the issue that OSS emulation layer provides less controls
> than the alsa mixer. One specific problem is the OSS Speaker control
> is not properly mapped on all drivers (among others the wss/cs4236 family)
> due to the fact that the speaker input/output is called "Mono" in this driver.
>
> I have found that there are at least three names are used by drivers:
> "PC Speaker"
> "Speaker"
> "Mono"
> for the same input/output pair (At least on the ISA cards there is only single
> purpose mono channel - to route the PC speaker).
>
> Which name should be used? I will convert all ISA drivers to the selected
> name (and fix the OSS mixer to map this name to the "Speaker" control).

I proposed and changed all "Speaker" and "PC Speaker" names to "Beep" in 
recent ALSA code. The OSS emulation layer is updated as well.

 						Jaroslav

-----
Jaroslav Kysela <perex@perex.cz>
Linux Kernel Sound Maintainer
ALSA Project, Red Hat, Inc.
