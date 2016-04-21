From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: linux-4.6-rc4/sound/pci/ens1370.c:1551: possible
	bad	expression ?
Date: Thu, 21 Apr 2016 08:38:48 +0200
Message-ID: <57187578.2010609@ladisch.de>
References: <DUB128-W44E71E14CBE4AC54396DFA9C6B0@phx.gbl>
 <DUB128-W43C83AA6E3851834E8340F9C6B0@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from dehamd003.servertools24.de (dehamd003.servertools24.de
 [31.47.254.18]) by alsa0.perex.cz (Postfix) with ESMTP id 4E6722604DF
 for <alsa-devel@alsa-project.org>; Thu, 21 Apr 2016 08:38:49 +0200 (CEST)
In-Reply-To: <DUB128-W43C83AA6E3851834E8340F9C6B0@phx.gbl>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: David Binderman <dcb314@hotmail.com>, "perex@perex.cz" <perex@perex.cz>, "tiwai@suse.com" <tiwai@suse.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

David Binderman wrote:
> [linux-4.6-rc4/sound/pci/ens1370.c:1551]: (style) Expression '(X & 0xf0000)>= 0x4' is always false.

What tool generated this message?

> Source code is
>
>     if ((ensoniq->ctrl & ES_1371_GPIO_OUTM)>= 4)
>         val = 1;

This message is wrong; it is certainly possible for this to be true.

However, there is a different bug: 4 must be ES_1371_GPIO_OUT(4).


Regards,
Clemens
