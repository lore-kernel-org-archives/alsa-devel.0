From: Felipe Ferreri Tonello <eu@felipetonello.com>
Subject: Re: Unregister a card from userspace?
Date: Mon, 9 Nov 2015 11:24:09 +0000
Message-ID: <56408259.2030604@felipetonello.com>
References: <alpine.DEB.2.02.1511041032180.1465@lnxricardw1.se.axis.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wm0-f43.google.com (mail-wm0-f43.google.com [74.125.82.43])
 by alsa0.perex.cz (Postfix) with ESMTP id CE9F526153C
 for <alsa-devel@alsa-project.org>; Mon,  9 Nov 2015 12:24:12 +0100 (CET)
Received: by wmnn186 with SMTP id n186so97559562wmn.1
 for <alsa-devel@alsa-project.org>; Mon, 09 Nov 2015 03:24:11 -0800 (PST)
In-Reply-To: <alpine.DEB.2.02.1511041032180.1465@lnxricardw1.se.axis.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Ricard Wanderlof <ricard.wanderlof@axis.com>, alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hi Ricard,

On 04/11/15 09:36, Ricard Wanderlof wrote:
>
> A sound card driver would normally call snd_soc_register_card() to
> register its sound card with ALSA.
>
> Is there some way to unregister the card from userspace?

No. ALSA API to deal with cards are in kernel space only.

>
> My use case is that I have a card driver I'm working on as a module, and
> while insmodding it works fine, I can't rmmod it because once
> snd_soc_register_card() has been called, it has a usage count of 2 and
> thus cannot be rmmod:ed.

You have to unregister that card upon freeing your module.

-- 
Felipe
