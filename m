From: Andre Schramm <andre.schramm@iosono-sound.com>
Subject: Re: hdspm - Missing PCI ID for PCIe MADI
Date: Mon, 21 Nov 2011 17:33:48 +0100
Message-ID: <20111121173348.7ded17a9@revell>
References: <20111120231258.312526d4@revell>
	<20111121140221.GY10381@ltw.loris.tv>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from moutng.kundenserver.de (moutng.kundenserver.de [212.227.17.8])
	by alsa0.perex.cz (Postfix) with ESMTP id 62BB624480
	for <alsa-devel@alsa-project.org>; Mon, 21 Nov 2011 17:33:55 +0100 (CET)
In-Reply-To: <20111121140221.GY10381@ltw.loris.tv>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Adrian Knoth <adi@drcomp.erfurt.thur.de>
Cc: Robert Steffens <robert.steffens@iosono-sound.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Mon, 21 Nov 2011 15:02:21 +0100
Adrian Knoth <adi@drcomp.erfurt.thur.de> wrote:

> 
> > thanks for the latest patches. While doing some testing, I noticed
> > that one PCI ID (d2) was missing, so the module didn't load.
> 
> It's not really missing, I used the wrong one. :-/
> 
> c09403dcc was written way too late in the evening. As I always say: no
> serious work past 6pm. ;)
> 
Hehe. And you meant _before_ 6pm, didn't you? ;)


> Thanks for spotting, I'll come up with a patch in a second.
> 
> Yours could in theory also be applied, but technically, it still tries
> to match the MADIface ID. My bad, cause MADIface is handled in a
> separate case branch.
> 
I see, didn't check that deep. I think there is a MADIface around
somewhere, will check that too.


Thanks so far. :)


Cheers,
  Andre
