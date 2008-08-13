From: Colin Guthrie <gmane@colin.guthr.ie>
Subject: Re: developing audio with ALSA
Date: Wed, 13 Aug 2008 09:19:30 +0100
Message-ID: <g7u5ei$5h2$1@ger.gmane.org>
References: <000c01c8fd10$a09013c0$ba3ea8c0@Richwave.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ciao.gmane.org (main.gmane.org [80.91.229.2])
	by alsa0.perex.cz (Postfix) with ESMTP id C1A1510380E
	for <alsa-devel@alsa-project.org>;
	Wed, 13 Aug 2008 10:19:44 +0200 (CEST)
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1KTBa1-0005h3-9l
	for alsa-devel@alsa-project.org; Wed, 13 Aug 2008 08:19:41 +0000
Received: from brent.tribalogic.net ([78.86.109.144])
	by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Wed, 13 Aug 2008 08:19:41 +0000
Received: from gmane by brent.tribalogic.net with local (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Wed, 13 Aug 2008 08:19:41 +0000
In-Reply-To: <000c01c8fd10$a09013c0$ba3ea8c0@Richwave.net>
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

Henry Ho wrote:
> Hi
> 
> I'm developing audio application using ALSA library. My target platform is ARM 
> platform baseboard. I use GNU toolchain cross compiler as you can see from 
> the following message:
> 
> arm-none-linux-gnueabi-gcc -lasound -g -O2 -I./alsa-lib-1.0.17rc2/include -o pcm pcm.c
> /usr/bin/../lib/gcc/arm-none-linux-gnueabi/4.2.0/../../../../arm-none-linux-gnueabi/bin/ld: cannot find -lasound
> collect2: ld returned 1 exit status
> make: *** [versatile] Error 1
> 
> I know that is because the linker cannot find the asound library. Should I cross compiling 
> ALSA driver/lib/utils first?

The drivers will possibly already be in your kernel, and the utils will 
help you initialise your sound hardware properly (set volumes, switches 
etc.).

And the library, well, you defo need that  :)

Col
