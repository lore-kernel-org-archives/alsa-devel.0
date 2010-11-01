From: Eliot Blennerhassett <eblennerhassett@audioscience.com>
Subject: Re: [PATCH] AudioScience HPI driver: Unsafe memory
 management when allocating control cache
Date: Tue, 02 Nov 2010 11:19:36 +1300
Message-ID: <4CCF3CF8.7060300@audioscience.com>
References: <alpine.LNX.2.00.1010292124180.24561@swampdragon.chaosbits.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp3.clear.net.nz (smtp3.clear.net.nz [203.97.33.64])
	by alsa0.perex.cz (Postfix) with ESMTP id 42187103814
	for <alsa-devel@alsa-project.org>; Mon,  1 Nov 2010 23:19:42 +0100 (CET)
Received: from [192.168.36.2]
	(121-72-250-62.cable.telstraclear.net [121.72.250.62])
	by smtp3.clear.net.nz (CLEAR Net Mail)
	with ESMTP id <0LB8009F48OPQV20@smtp3.clear.net.nz> for
	alsa-devel@alsa-project.org; Tue, 02 Nov 2010 11:19:38 +1300 (NZDT)
In-reply-to: <alpine.LNX.2.00.1010292124180.24561@swampdragon.chaosbits.net>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Jesper Juhl <jj@chaosbits.net>
List-Id: alsa-devel@alsa-project.org

On 30/10/10 08:35, Jesper Juhl wrote:
> I noticed that sound/pci/asihpi/hpicmn.c::hpi_alloc_control_cache() does 
> not check the return value from kmalloc(), which may fail.
> If kmalloc() fails we'll dereference a null pointer and things will go bad 
> fast.
> There are two memory allocations in that function and there's also the 
> problem that the first may succeed and the second may fail and nothing is 
> done about that either which will also go wrong down the line.

Thanks Jesper,

your changes look fine.

Acked-by: Eliot Blennerhassett <linux@audioscience.com>
