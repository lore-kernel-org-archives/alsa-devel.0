From: Thorsten Knabe <linux@thorsten-knabe.de>
Subject: Re: [2.6 patch] schedule obsolete OSS drivers for removal
Date: Thu, 28 Jul 2005 17:04:20 +0200 (CEST)
Message-ID: <Pine.LNX.4.61.0507281636040.20815__35647.4114968025$1122563250$gmane$org@tek01.intern.thorsten-knabe.de>
References: <20050726150837.GT3160@stusta.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mail.thorsten-knabe.de (mail.thorsten-knabe.de [82.141.44.28])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id A757F18E
	for <alsa-devel@alsa-project.org>; Thu, 28 Jul 2005 17:04:22 +0200 (MEST)
In-Reply-To: <20050726150837.GT3160@stusta.de>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Adrian Bunk <bunk@stusta.de>
Cc: linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, linux-sound@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Tue, 26 Jul 2005, Adrian Bunk wrote:

> This patch schedules obsolete OSS drivers (with ALSA drivers that
> support the same hardware) for removal.

Hello Adrian.

I'm the maintainer of the OSS AD1816 sound driver. I'm aware of two 
problems of the ALSA AD1816 driver, that do not show up with the OSS 
driver:
- According to my own experience and user reports audio is choppy with 
some VoIP Softphones like gnophone at least when used with the ALSA OSS 
emulation layer, whereas the OSS driver is crystal clear.
- Users reported, that on some HP Kayak systems the on-board AD1816A 
was not properly detected by the ALSA driver or was detected, but 
there was no audio output. I'm not sure if the problem is still present in 
the current ALSA driver, as I do not own such a system.

Maybe the OSS driver should stay in the kernel, until those problems are 
fixed in the ALSA driver.

Regards
Thorsten

-- 
___
  |        | /                 E-Mail: linux@thorsten-knabe.de
  |horsten |/\nabe                WWW: http://linux.thorsten-knabe.de


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO September
19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
