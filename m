From: Pavel Hofman <pavel.hofman@insite.cz>
Subject: Re: Juli@ ICE1724 and 24 bit audio
Date: Mon, 09 Feb 2009 21:26:46 +0100
Message-ID: <49909186.4050902@insite.cz>
References: <366C228A7F9A4AAF9EE7190DC4C0EE68@PDSDesktop>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailserver.bobrnet.net (bobrnet.cust.inethome.cz [88.146.180.6])
	by alsa0.perex.cz (Postfix) with ESMTP id 7EA0C103840
	for <alsa-devel@alsa-project.org>; Mon,  9 Feb 2009 21:26:51 +0100 (CET)
In-Reply-To: <366C228A7F9A4AAF9EE7190DC4C0EE68@PDSDesktop>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Demian Martin <demianm_1@yahoo.com>
Cc: alsa-devel@alsa-project.org, pavel.hofman@insite.cz
List-Id: alsa-devel@alsa-project.org

Demian Martin napsal(a):
> I have the driver working fine for sample rates from 44.1K to 196K however
> it seems to be truncating the data to 16 bits. I wasn't sure until I started
> testing with the HRx 176.4K 24 bit files that have an embedded HDCD flag in
> the LSB. The files work OK on Windoze systems (with a lot of low level
> settings tweaked) and they play fine but the flag isn't detected by a system
> that can detect them. Further looking at the data stream with a scope it
> seems the last 8 bits aren't changing. Is there anything I can do to control
> the driver to confirm this problem or change the playback settings to make
> it work?
> 
>  

How do you play the files? Do you use the hw or plug:hw device? IIRC, 
the standard-setup dmix resampler is 16-bit only.

I did tests with SPDIF OUT/IN and found it bit-perfect, for 24bit too.

Regular ICE1724 cards do not output 176.4kHz SPDIF, only 88.2kHz. But 
Juli is not affected by that bug.

Regards,


Pavel.
