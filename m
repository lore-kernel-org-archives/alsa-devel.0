From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: Building the alsa library
Date: Sun, 16 Jun 2019 14:11:37 +0200
Message-ID: <f016bbb5-d3bb-06ae-d2de-6597aefc851f@perex.cz>
References: <20190615134103.6c61c97e98fe7bb02193b2d6dca4a85a.50a60f16a4.mailapi@email03.godaddy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (mail1.perex.cz [77.48.224.245])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 04898F896C7
 for <alsa-devel@alsa-project.org>; Sun, 16 Jun 2019 14:11:40 +0200 (CEST)
In-Reply-To: <20190615134103.6c61c97e98fe7bb02193b2d6dca4a85a.50a60f16a4.mailapi@email03.godaddy.com>
Content-Language: en-US
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: scott andrew franco <samiam@moorecad.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Dne 15. 06. 19 v 22:41 scott andrew franco napsal(a):
> Hi,
>  
> I have been trying to solve a difficult issue using the ALSA library. To solve it, I need to be able to
> debug into the ALSA library.
>  
> I tried to build it from the sources, from the alsa-lib-1.1.9 library source to be specific.
>  
> Problems:
>  
> Using the build procedure in the INSTALL file, it appeared to build but I could not find a libasound.so file
> anywhere.
>  
> I also tried the recommended procedure for static linking, also from the INSTALL file. That gives a 
> ./src/.libs/libasound.a file (indeed, this gets generated on a dynamic link as well, which I don't understand).
>  However, linking with that produces (after adding back a few missing libs):
>  samiam@samiam-linux-pc:~/scratch$ ./hello
> This is a test program
> ALSA lib conf.c:3558:(snd_config_hooks_call) Cannot open shared library libasound_module_conf_pulse.so (/usr/lib/alsa-lib/libasound_module_conf_pulse.so: libasound_module_conf_pulse.so: cannot open shared object file: No such file or directory)

Your config files (perhaps from the distribution?) refer to the ALSA pulse
plugin which is in the alsa-plugins package. Fix the configuration files or
compile alsa-plugins, too.

					Jaroslav

-- 
Jaroslav Kysela <perex@perex.cz>
Linux Sound Maintainer; ALSA Project; Red Hat, Inc.
