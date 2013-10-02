From: Daniel Mack <zonque@gmail.com>
Subject: Re: snd-usb-usx2y (Tascam US-122) sequence errors --
 PLEASE FIX
Date: Wed, 02 Oct 2013 15:38:20 +0200
Message-ID: <524C21CC.7070304@gmail.com>
References: <1879797.EMyhs7R6HO@arial> <3237224.7XQAgIOXUv@arial>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ee0-f44.google.com (mail-ee0-f44.google.com [74.125.83.44])
 by alsa0.perex.cz (Postfix) with ESMTP id 7DB05265139
 for <alsa-devel@alsa-project.org>; Wed,  2 Oct 2013 15:38:36 +0200 (CEST)
Received: by mail-ee0-f44.google.com with SMTP id b47so410404eek.3
 for <alsa-devel@alsa-project.org>; Wed, 02 Oct 2013 06:38:36 -0700 (PDT)
In-Reply-To: <3237224.7XQAgIOXUv@arial>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Dr Nicholas J Bailey <nicholas.bailey@glasgow.ac.uk>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 30.09.2013 19:07, Dr Nicholas J Bailey wrote:
> This was in fact reported in May, but the fix suggested by Guido Aulisi in 
> reply to Julien Claassen on Linux Audio User in May hasn't yet made it into 
> kernel 3.10.
> 
> Applying the patch suggested here:
> 
> 	http://linuxaudio.org/mailarchive/lau/2013/5/20/200177
> 
> resolved the problem for me.

Ok. I have no such device, but if you say the patch works for you, I can
cook a patch.

> It is only 4 characters to change. I would very much appreciate it if somebody 
> could do that officially because I don't like building custom kernels. Also, I 
> don't really understand what this patch is doing (except literally, of course) 
> so having somebody who does look at it and accept it would be just great.

I can take care for that.


Thanks,
Daniel
