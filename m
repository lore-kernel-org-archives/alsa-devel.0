From: Timur Tabi <timur@freescale.com>
Subject: Re: [PATCH] ALSA: soc - fsl_ssi.c fix audio capture
Date: Fri, 4 Jul 2008 07:02:17 -0400
Message-ID: <B615D57E-324C-4812-997C-9E5C90FDE967@freescale.com>
References: <20080703143714.GA7003@polina.dev.rtsoft.ru>
	<20080703144254.GB652@sirena.org.uk>
Mime-Version: 1.0 (Apple Message framework v924)
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	by alsa0.perex.cz (Postfix) with ESMTP id E8D8F1037F1
	for <alsa-devel@alsa-project.org>;
	Fri,  4 Jul 2008 12:58:30 +0200 (CEST)
In-Reply-To: <20080703144254.GB652@sirena.org.uk>
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
Cc: alsa-devel@alsa-project.org, Anton Vorontsov <avorontsov@ru.mvista.com>
List-Id: alsa-devel@alsa-project.org


On Jul 3, 2008, at 10:42 AM, Mark Brown wrote:

> On Thu, Jul 03, 2008 at 06:37:14PM +0400, Anton Vorontsov wrote:
>> Since we're using SSI in synchronous mode, the STCCR register  
>> controls
>> both the receive and transmit sections. So, when we're trying to  
>> record
>> anything, stccr register does not get initialized, thus the output  
>> file
>> filled with the white noise.
>
>> Fix this by initializing the STCCR for both playback and capture. If
>> TX/RX widths don't match, return that we're busy at the moment.
>
>> Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
>
> Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
>
> but Timur needs to ack it since I don't have any particular  
> knowledge of
> the hardware.

Anton has the right idea, but I'm not sure the fix is the best.  I was  
planning on posting my fix after I got back from vacation.

Part of the problem is that STCK and SRCK can be wired together, which  
means that even though you're not in synchronous mode, the sample  
rates have to match.  For the 8610 HPCD, this isn't a problem, but the  
SSI driver is supposed to support more than just that board.  We need  
device tree additions to cover all cases.

Anton, are you sure returning -EBUSY is the right fix?  Would this  
make applications like mplayer detect the problem and automatically  
pick a matching sample format that does work?
