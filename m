From: "Alexander E. Patrakov" <patrakov@gmail.com>
Subject: Re: coverity fix in alsa-libs
Date: Mon, 15 Sep 2014 17:36:02 +0600
Message-ID: <5416CF22.1080200@gmail.com>
References: <50.84.05230.480B6145@epcpsbgx3.samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-la0-f41.google.com (mail-la0-f41.google.com
 [209.85.215.41])
 by alsa0.perex.cz (Postfix) with ESMTP id E643026525F
 for <alsa-devel@alsa-project.org>; Mon, 15 Sep 2014 13:34:21 +0200 (CEST)
Received: by mail-la0-f41.google.com with SMTP id s18so4464037lam.28
 for <alsa-devel@alsa-project.org>; Mon, 15 Sep 2014 04:34:21 -0700 (PDT)
In-Reply-To: <50.84.05230.480B6145@epcpsbgx3.samsung.com>
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
Cc: Takashi Iwai <tiwai@suse.de>, renu.tyagi@samsung.com
List-Id: alsa-devel@alsa-project.org

15.09.2014 15:25, Renu Tyagi wrote:
> Hi,
>
> I ran Coverity analysis tool on alsa and found some bugs.

May I suggest that we remove aserver and the shm plugin instead of 
applying the patch? Three days ago I tried to use it for testing my fix 
to the share plugin, but failed. In other words: if even speaker-test 
cannot be made to work on it without crashing and/or hanging or valgrind 
errors, then I'd rather be aggressive here.

And next time please CC: Takashi Iwai on all alsa-lib patches :)

> Bug and Patch description
>
> 1. Changed file  :  aserver.c
> Socket not closed before returning when bind fails
> Community Code:
>
> if (bind(sock, (struct sockaddr *) addr, size) < 0) {
> int result = -errno;
> SYSERROR("bind failed");
> return result;
> }
> return sock;
> }
>
> Recommended Code :
>
> if (bind(sock, (struct sockaddr *) addr, size) < 0) {
> 	int result = -errno;
> 	SYSERROR("bind failed");
> 	close(sock);
> 	return result;
> }
> return sock;
> }
>
> 2.Changed file : control_shm.c
> Socket not closed before returning when connect fails
>
> Community Code:
> if (connect(sock, (struct sockaddr *) addr, size) < 0)
>      return -errno;
> 	return sock;
> }
>
> Recommended Code :
> if (connect(sock, (struct sockaddr *) addr, size) < 0){
>      SYSERR("connect failed");
>      close(sock);
>      return -errno;
> 	}
> return sock;
> }
>
> 3.Changed file : pcm_shm.c
> Socket not closed before returning when connect fails
>
> Community Code:
> if (connect(sock, (struct sockaddr *) addr, size) < 0) {
>     SYSERR("connect failed");
> 	return -errno;
>     }
>   return sock;
> }
> Recommended Code :
> if (connect(sock, (struct sockaddr *) addr, size) < 0) {
>   SYSERR("connect failed");
>   close(sock);
>   return -errno;
>   }
> return sock;
> }
>
> PFA patch.
>
>
>
>
>
> Thanks & Regards,
>
> Renu Tyagi
>
>
>
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
>


-- 
Alexander E. Patrakov
