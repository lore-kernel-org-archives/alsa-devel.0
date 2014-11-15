From: Anssi Hannula <anssi.hannula@iki.fi>
Subject: Re: DTS-HD over HDMI
Date: Sat, 15 Nov 2014 18:51:49 +0200
Message-ID: <546784A5.4000200@iki.fi>
References: <1415908278.3076.63.camel@kip-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail3.ippnet.fi (mail3.ippnet.fi [62.197.168.3])
 by alsa0.perex.cz (Postfix) with ESMTP id A576D2605EF
 for <alsa-devel@alsa-project.org>; Sat, 15 Nov 2014 17:51:52 +0100 (CET)
In-Reply-To: <1415908278.3076.63.camel@kip-laptop>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Kip Warner <kip@thevertigo.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

13.11.2014, 21:51, Kip Warner kirjoitti:
> Hey list,

Hi,

> I apologize if this ought to have gone to alsa-user. I wasn't sure as a
> developer using API, but not developing ALSA itself, if it have been
> better there than here.

This is the correct list - "If you would like to work on the driver,
library or an ALSA application".

> I'd like to be able to stream DTS-HD Master Audio bits out the HDMI port
> in their compressed form, and not decompressed as LPCM. From what I can
> gather, this may be possible with the ALSA API, provided the HDMI port
> is >= 1.3 and the audio card supports high bit-rate (HBR).
> 
> Is my thinking correct?

Yes, it is possible with cards that support HBR. Support is in for
Intel, NVIDIA and AMD/ATI cards.

-- 
Anssi Hannula
