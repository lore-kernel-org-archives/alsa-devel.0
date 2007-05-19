From: Rene Herman <rene.herman@gmail.com>
Subject: Re: ICE1712/1724 HW mixing?
Date: Sat, 19 May 2007 04:28:38 +0200
Message-ID: <464E60D6.7080300@gmail.com>
References: <464A5D6A.9020104@gmail.com>
	<200705160927.40433.gineera@aspect135.co.uk>
	<464B8B84.60302@gmail.com>
	<200705181114.01667.gineera@aspect135.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtpq1.tilbu1.nb.home.nl (smtpq1.tilbu1.nb.home.nl
	[213.51.146.200])
	by alsa0.perex.cz (Postfix) with ESMTP id B6F6D2444D
	for <alsa-devel@alsa-project.org>;
	Sat, 19 May 2007 04:31:19 +0200 (CEST)
In-Reply-To: <200705181114.01667.gineera@aspect135.co.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Alan Horstmann <gineera@aspect135.co.uk>
Cc: ALSA devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On 05/18/2007 12:14 PM, Alan Horstmann wrote:

>> Could you "cat /proc/asound/card0/pcm0p/info" (replace the 0,0 with
>> where your 6Fire PCM is at) and confirm that "subdevices_count" is
>> larger than 1 to confirm it's HWMIXing in the ALSA sense?
> 
> subdevices_count: 1
> Lee has explained this confusion:- this card has a hardware mixer but
> does not do 'Hardware Mixing' in the Alsa sense! Thanks for that Lee!

Thanks. Will leave out "HWMIX" from the ICE1712/1724 card tags.

>>> The DMX6fire has both optical and phono SPDIF connectors
>> Both both input and output?
> 
> Yes. The two inputs can be switch selected; the outputs are in parallel.

Thanks again, just added "RCAio" to the 6Fire.

>> I've for example added "ANALOGio" to every single card on the TerraTec page
>> which felt a bit silly. 
> 
> Actually as I understand it, the EWS88D is essentially digital (ADAT etc) only 
> though it seems to have a secondary low-grade audio out for system sounds 
> etc.

You're right, just checked the manual. I see the driver creating a 8/16-bit 
8-48 kHz "ICE1712 consumer" PCM that I suppose will be the one that ends up 
at that backplate analog out. The "low-grade" will be fairly relative so 
I'll leave in the ANALOGio tag for the ES88D as well. If someone reading 
this knows better, please yell...

Rene.
