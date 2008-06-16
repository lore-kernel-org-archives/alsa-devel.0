From: "anuj aggarwal" <anuj.aggarwal@gmail.com>
Subject: Function to update the PCM status in alsa lib?
Date: Mon, 16 Jun 2008 17:14:55 +0530
Message-ID: <2ee9e08d0806160444v48a65788uacf175e70fbe820f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.248])
	by alsa0.perex.cz (Postfix) with ESMTP id D5CB924593
	for <alsa-devel@alsa-project.org>;
	Mon, 16 Jun 2008 13:44:56 +0200 (CEST)
Received: by an-out-0708.google.com with SMTP id d31so1078338and.80
	for <alsa-devel@alsa-project.org>; Mon, 16 Jun 2008 04:44:55 -0700 (PDT)
Content-Disposition: inline
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

Hi,

I am calling snd_pcm_period_elapsed() in my DMA callback routine.
After doing that, I check for more data in the 'runtime' struct and
pass a new request to xfer data to the codec driver.

snd_pcm_period_elapsed() is used to update the pcm status for the next
period, by the codec driver. I want to know which function is used by
the ALSA library to do the same when it receives a new request from
the user to transfer data (i.e. when user calls snd_pcm_writei()).

Thanks,
Anuj
