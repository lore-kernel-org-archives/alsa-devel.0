From: Lennart Poettering <mznyfn@0pointer.de>
Subject: Re: Recording problem with pulse plugin
Date: Sat, 25 Oct 2008 17:22:56 +0200
Message-ID: <20081025152256.GA27570@tango.0pointer.de>
References: <s5hzll617yc.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from tango.0pointer.de (tango.0pointer.de [85.214.72.216])
	by alsa0.perex.cz (Postfix) with ESMTP id 24A3624418
	for <alsa-devel@alsa-project.org>;
	Sat, 25 Oct 2008 17:23:14 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <s5hzll617yc.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Wed, 15.10.08 12:14, Takashi Iwai (tiwai@suse.de) wrote:

> Hi Lennart,

Heya!

> I got a bug report about the recording with pulse alsa-plugin.
> It gets just -EIO error.
> 
> I checked it, and can reproduce it actually.  The problem appears to
> happen since 1.0.18rc1, and the affecting commit is:
> 
>   commit 90c32999189cf6f5c63f40dadb8076eca379713b
>   Author: Lennart Poettering <mznyfn@0pointer.de>
>   Date:   Fri Jul 18 21:45:47 2008 +0200
> 
>       send both an uncork and a trigger in _start()
> 
> The problem is that pa_stream_trigger() returns NULL for capture.
> I made a quick fix for this (the patch attached below), but not
> entirely sure whether it's the right thing.  Please check.

Looks good. Please apply!

Thanks for looking into this!

Lennart

-- 
Lennart Poettering                        Red Hat, Inc.
lennart [at] poettering [dot] net         ICQ# 11060553
http://0pointer.net/lennart/           GnuPG 0x1A015CC4
