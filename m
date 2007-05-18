From: Alan Horstmann <gineera@aspect135.co.uk>
Subject: Re: ICE1712/1724 HW mixing?
Date: Fri, 18 May 2007 11:14:01 +0100
Message-ID: <200705181114.01667.gineera@aspect135.co.uk>
References: <464A5D6A.9020104@gmail.com>
	<200705160927.40433.gineera@aspect135.co.uk>
	<464B8B84.60302@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp.talktalk.net (unknown [62.24.128.253])
	by alsa0.perex.cz (Postfix) with ESMTP id A8FAE24532
	for <alsa-devel@alsa-project.org>;
	Fri, 18 May 2007 12:08:24 +0200 (CEST)
In-Reply-To: <464B8B84.60302@gmail.com>
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Rene Herman <rene.herman@gmail.com>
Cc: ALSA devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Wednesday 16 May 2007 23:53, you wrote:
> On 05/16/2007 10:27 AM, Alan Horstmann wrote:

> > Hardware mixing of 10 inputs and 10 outputs is provided. In the notes, it
> > is probably worth mentioning Envy24control, a mixing/control tool
> > dedicated to this chipset?
>
> Could you "cat /proc/asound/card0/pcm0p/info" (replace the 0,0 with where
> your 6Fire PCM is at) and confirm that "subdevices_count" is larger than 1
> to confirm it's HWMIXing in the ALSA sense?

subdevices_count: 1
Lee has explained this confusion:- this card has a hardware mixer but does not 
do 'Hardware Mixing' in the Alsa sense!  Thanks for that Lee!

> > The DMX6fire has both optical and phono SPDIF connectors
>
> Both both input and output?

Yes. The two inputs can be switch selected; the outputs are in parallel.

> > and a wavetable connector in the front box (for use with DB50XG etc),
> > and works fine since 1.0.12.
>
> That connector might be worth a Tag-WaveBlaster or similar.

> I've for example added "ANALOGio" to every single card on the TerraTec page
> which felt a bit silly. 

Actually as I understand it, the EWS88D is essentially digital (ADAT etc) only 
though it seems to have a secondary low-grade audio out for system sounds 
etc.

http://productsen.terratec.net/
modules.php?op=modload&name=News&file=article&sid=7

Regards  Alan
