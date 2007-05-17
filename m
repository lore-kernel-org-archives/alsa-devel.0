From: Rask Ingemann Lambertsen <rask@sygehus.dk>
Subject: Re: Can someone verify support for "AzTech
	Sound	Galaxy Nova 16 Extra II-3D - using AZT-2316/R Chipset
	-	FCC-ID:I38-MMSN846" ?
Date: Thu, 17 May 2007 15:08:11 +0200
Message-ID: <20070517130811.GY5690@sygehus.dk>
References: <20070513101757.8C8191BF23B@ws1-1.us4.outblaze.com>
	<4648DA4E.8050107@gmail.com> <4648E10B.4010403@gmail.com>
	<20070515101259.GS5690@sygehus.dk> <464B955F.3030508@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from pfepa.post.tele.dk (pfepa.post.tele.dk [195.41.46.235])
	by alsa0.perex.cz (Postfix) with ESMTP id ABA932446C
	for <alsa-devel@alsa-project.org>;
	Thu, 17 May 2007 15:08:16 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <464B955F.3030508@gmail.com>
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
Cc: alsa-devel@alsa-project.org, ramkromberg@mail.com
List-Id: alsa-devel@alsa-project.org

On Thu, May 17, 2007 at 01:35:59AM +0200, Rene Herman wrote:

> Does your NX Pro have an EEPROM? It should be a small 8-pin chip marked 
> with something close to "X24C00", near a clock chip and probably near an 
> Intel 8051 microcontroller. And does it have a jumper that sounds like it 
> has anything to do with things?

   I've found the X24C00 chip, a 12 MHz crystal or oscilator (I'm not sure
which) and an Intel S-80C51FANM chip. The uncommented jumpers J1 and J2 are
my best bet, although they are connected to the AZTSSPT0592 chip.

-- 
Rask Ingemann Lambertsen
