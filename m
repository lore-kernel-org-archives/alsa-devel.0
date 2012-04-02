From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: loading mixer control values from a different file
 when opening an device
Date: Mon, 02 Apr 2012 10:01:47 +0200
Message-ID: <4F795CEB.4090203@ladisch.de>
References: <loom.20120401T171938-797@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com
	[66.111.4.25]) by alsa0.perex.cz (Postfix) with ESMTP id 7F44D243BD
	for <alsa-devel@alsa-project.org>;
	Mon,  2 Apr 2012 09:58:20 +0200 (CEST)
Received: from compute5.internal (compute5.nyi.mail.srv.osa [10.202.2.45])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id 2385F21880
	for <alsa-devel@alsa-project.org>; Mon,  2 Apr 2012 03:58:24 -0400 (EDT)
In-Reply-To: <loom.20120401T171938-797@post.gmane.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Ziv Haziz <ziv.haziz@dspg.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Ziv Haziz wrote:
> i would have like to load setting
> from a different file only when accessing the a
> specific device - something like this:
>
> pcm.MyDevice {
>   type hooks
>   slave.pcm {
>     type hw
>     device 0
>   }
>
>   <i would like to place here something which
>  will "func load" from another file>
>
>   hooks.0 {
>     type ctl_elems
>     hook_args [
>
>       ]
>
> }

The "hooks" PCM plugin is something completely separate
from the global "@hooks" mechanism.

You can include configuration files directly:
http://www.alsa-project.org/alsa-doc/alsa-lib/conf.html#conf_include

What is the actual problem you're trying to solve?


Regards,
Clemens
