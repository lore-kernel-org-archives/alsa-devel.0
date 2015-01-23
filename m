From: "a.renault@kaptalia.com" <a.renault@kaptalia.com>
Subject: [alsa] Crackling after 6.45 hours
Date: Fri, 23 Jan 2015 15:34:52 +0100
Message-ID: <3427562.sVz54J9OhN@linux-le0l.site>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.13])
 by alsa0.perex.cz (Postfix) with ESMTP id 3430F2654E5
 for <alsa-devel@alsa-project.org>; Fri, 23 Jan 2015 18:24:10 +0100 (CET)
Received: from linux-le0l.site ([46.18.96.158]) by mrelayeu.kundenserver.de
 (mreue103) with ESMTPA (Nemesis) id 0MBr6d-1YOK6b3FSx-00Aj2F for
 <alsa-devel@alsa-project.org>; Fri, 23 Jan 2015 15:34:54 +0100
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi everyone, 
 
I currently facing the following issue : 
 
My sound crackling after 6.45 hours of music without reinitialization.
 
I am using sdl-mixer, sdl and alsa.
 
I deployed a bug on libsdl at the address : 
https://bugzilla.libsdl.org/show_bug.cgi?id=2794
And after some works we discover that the snd_pcm_writei answer "-1073741824".
 
The error code "-1073741824" is not one of -EINTR, -EPIPE, -ESTRPIPE, -EAGAIN.
So "snd_pcm_recover" does not handle anything.
 
If you are brave enought please take a look at the link,
 
Any idea would be greatly appreciated.
 
Best regards,
-- 
Adrien
