From: "Gabriel M. Beddingfield" <gabrbedd@gmail.com>
Subject: Re: M-Audio Delta 1010LT: S/PDIF clock source not
	working
Date: Sun, 07 Apr 2013 10:03:15 -0700
Message-ID: <5161A6D3.3060602@gmail.com>
References: <515EEF10.1020007@gmail.com> <5160C35A.8020403@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pd0-f173.google.com (mail-pd0-f173.google.com
 [209.85.192.173])
 by alsa0.perex.cz (Postfix) with ESMTP id 84AC526512F
 for <alsa-devel@alsa-project.org>; Sun,  7 Apr 2013 19:03:26 +0200 (CEST)
Received: by mail-pd0-f173.google.com with SMTP id v14so2588802pde.32
 for <alsa-devel@alsa-project.org>; Sun, 07 Apr 2013 10:03:25 -0700 (PDT)
In-Reply-To: <5160C35A.8020403@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jonas Petersen <jnsptrsn1@gmail.com>
Cc: Pavel Hofman <pavel.hofman@ivitera.com>, alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On 04/06/2013 05:52 PM, Jonas Petersen wrote:
>
> It seems it's related to the ICE1712... I now tried the Audiophile 2496.
> Same behaviour! There is no way to clock from external (S/PDIF). The
> 'Multi Track Internal Clock Default' setting will always override the
> external clock rate and mess up the capturing.

Well, it /should/ work -- according to the 1010's manual.  I'll bet it's 
some register setting that's missing on the ice1712 -- but I have no 
access to the specs/datasheets/schematics on these things.

I wonder -- did this ever work on Linux?

-gabriel
