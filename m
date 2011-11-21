From: Adrian Knoth <adi@drcomp.erfurt.thur.de>
Subject: Re: hdspm - Missing PCI ID for PCIe MADI
Date: Mon, 21 Nov 2011 15:02:21 +0100
Message-ID: <20111121140221.GY10381@ltw.loris.tv>
References: <20111120231258.312526d4@revell>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ltw.loris.tv (ltw.loris.tv [89.163.167.2])
	by alsa0.perex.cz (Postfix) with ESMTP id E6E3124361
	for <alsa-devel@alsa-project.org>; Mon, 21 Nov 2011 15:01:18 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20111120231258.312526d4@revell>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Andre Schramm <andre.schramm@iosono-sound.com>
Cc: Robert Steffens <robert.steffens@iosono-sound.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Sun, Nov 20, 2011 at 11:12:58PM +0100, Andre Schramm wrote:

> Hi Adrian,

Hi!

> thanks for the latest patches. While doing some testing, I noticed that
> one PCI ID (d2) was missing, so the module didn't load.

It's not really missing, I used the wrong one. :-/

c09403dcc was written way too late in the evening. As I always say: no
serious work past 6pm. ;)

Thanks for spotting, I'll come up with a patch in a second.

Yours could in theory also be applied, but technically, it still tries
to match the MADIface ID. My bad, cause MADIface is handled in a
separate case branch.


Cheers

-- 
mail: adi@thur.de  	http://adi.thur.de	PGP/GPG: key via keyserver
