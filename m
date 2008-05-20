From: Timur Tabi <timur@freescale.com>
Subject: Re: Possible problem with snd_pcm_oss_sync()
Date: Tue, 20 May 2008 13:57:42 -0500
Message-ID: <48331F26.4030104@freescale.com>
References: <4832F65E.5070008@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	by alsa0.perex.cz (Postfix) with ESMTP id 01D952433E
	for <alsa-devel@alsa-project.org>;
	Tue, 20 May 2008 20:57:49 +0200 (CEST)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by de01egw02.freescale.net (8.12.11/de01egw02) with ESMTP id
	m4KIvkrj021815
	for <alsa-devel@alsa-project.org>; Tue, 20 May 2008 11:57:47 -0700 (MST)
Received: from [10.82.19.119] (ld0169-tx32.am.freescale.net [10.82.19.119])
	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id m4KIvkD5000193
	for <alsa-devel@alsa-project.org>; Tue, 20 May 2008 13:57:46 -0500 (CDT)
In-Reply-To: <4832F65E.5070008@freescale.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Timur Tabi wrote:

> I'm working with a customer that has discovered a possible problem with OSS
> emulation.  Unfortunately, I don't have a lot of experience with OSS, so I need
> help understanding whether the customer's observations point to a real problem
> or not.

Update:

snd_pcm_oss_sync() displays this message:

sync: buffer_used

What does this mean?  What does it mean to sync, and why would an OSS
application call sync?

-- 
Timur Tabi
Linux kernel developer at Freescale
