From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: [PATCH] test/pcm-multi-thread:
	Remove	pthread_cancel, add snd_pcm_close
Date: Thu, 1 Sep 2016 08:37:57 +0200
Message-ID: <d5479b42-e776-b40b-d27f-8beec63cca14@ladisch.de>
References: <1472696606-15309-1-git-send-email-diwic@ubuntu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from dehamd003.servertools24.de (dehamd003.servertools24.de
 [31.47.254.18]) by alsa0.perex.cz (Postfix) with ESMTP id 2E35C2666DA
 for <alsa-devel@alsa-project.org>; Thu,  1 Sep 2016 08:37:58 +0200 (CEST)
In-Reply-To: <1472696606-15309-1-git-send-email-diwic@ubuntu.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: David Henningsson <diwic@ubuntu.com>, Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

David Henningsson wrote:
>  2) It is good practice to close pcm after usage

> [...]
>  	for (i = 0; i < num_threads; i++) {
>  		if (pthread_create(&peeper_threads[i], NULL, peeper, (void *)(long)i)) {
>  			fprintf(stderr, "pthread_create error\n");
> +			snd_pcm_close(pcm);
>  			return 1;
>  		}
>  	}

Any previously created threads are already running.  Calling some snd_*
function on an already-closed device is worse than letting the OS clean
up after the program exits.

If we'd wanted to be strictly correct, we would have to send a message
to the threads and wait for them to exit (as the cleanup code below
already does).

>  	running = 0;

This variable should be volatile.

> -	for (i = 0; i < num_threads; i++)
> -		pthread_cancel(peeper_threads[i]);
>  	for (i = 0; i < num_threads; i++)
>  		pthread_join(peeper_threads[i], NULL);


Regards,
Clemens
