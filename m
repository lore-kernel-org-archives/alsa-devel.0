From: Rene Herman <rene.herman@gmail.com>
Subject: Re: Can someone verify support for "AzTech
 Sound	Galaxy Nova 16 Extra II-3D - using AZT-2316/R Chipset
 -	FCC-ID:I38-MMSN846" ?
Date: Thu, 17 May 2007 01:47:24 +0200
Message-ID: <464B980C.1050604@gmail.com>
References: <20070513101757.8C8191BF23B@ws1-1.us4.outblaze.com>
	<4648DA4E.8050107@gmail.com> <20070515101607.GT5690@sygehus.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtpq2.groni1.gr.home.nl (smtpq2.groni1.gr.home.nl
	[213.51.130.201])
	by alsa0.perex.cz (Postfix) with ESMTP id 1EE9C243E2
	for <alsa-devel@alsa-project.org>;
	Thu, 17 May 2007 01:50:03 +0200 (CEST)
In-Reply-To: <20070515101607.GT5690@sygehus.dk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Rask Ingemann Lambertsen <rask@sygehus.dk>
Cc: alsa-devel@alsa-project.org, ramkromberg@mail.com
List-Id: alsa-devel@alsa-project.org

On 05/15/2007 12:16 PM, Rask Ingemann Lambertsen wrote:

> Like you said yourself, there are a lot of different Sound Galaxy cards,
> not all of which are CS42xx compatible. Perhaps be a bit more specific as to
> which ones are expected to work (or not work) with the driver.

It's starting to look like I'll be able to support all sound galaxies with 
this one driver (pnp provides for a different set of entry points so merging 
azt2320 is also not going to be a problem) where only the very, very first 
(including your NX pro) would only allow SBB mode. Yes, it then makes more 
sense to just use snd-sb8, but hey...

My I38-MMSN803 already includes an AD1848 (AZT-NXPMIX0592 and AZTSSPT0592 as 
the other chips) and I know it drives AZT1605, AZT2316A and AZT2316R...

If it's "all Sound Galaxies except maybe some of the very first 8-bit cards" 
then I feel snd-galaxy is an okay name (snd-aztech isn't, since aztech has 
since then also made PCI cards) but yes, I need to do some further testing 
and probing on different cards before it's final.

Rene
