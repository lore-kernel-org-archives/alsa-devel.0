From: Rask Ingemann Lambertsen <rask@sygehus.dk>
Subject: Re: Can someone verify support for "AzTech
	Sound	Galaxy Nova 16 Extra II-3D - using AZT-2316/R Chipset
	-	FCC-ID:I38-MMSN846" ?
Date: Tue, 15 May 2007 12:12:59 +0200
Message-ID: <20070515101259.GS5690@sygehus.dk>
References: <20070513101757.8C8191BF23B@ws1-1.us4.outblaze.com>
	<4648DA4E.8050107@gmail.com> <4648E10B.4010403@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from pfepa.post.tele.dk (pfepa.post.tele.dk [195.41.46.235])
	by alsa0.perex.cz (Postfix) with ESMTP id DA69324803
	for <alsa-devel@alsa-project.org>;
	Tue, 15 May 2007 12:13:02 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <4648E10B.4010403@gmail.com>
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

On Tue, May 15, 2007 at 12:22:03AM +0200, Rene Herman wrote:
 
> As said. If you execute this as root it should enable the card. You can 
> pick the base address (the one JMPB0 is set to) with "-p 0x220|0x240". 
> Default is 0x200 if you don't specify one.
             ^^^^^
   0x220 or 0x240?

   Do you think there is any point in trying any of this configuration stuff
on an NXPro?

> 		return EXIT_FAILURE;
> 	}
> 
> 	return EXIT_SUCCESS;

   It is not often that I see other people use standards compliant return
values from main().

-- 
Rask Ingemann Lambertsen
