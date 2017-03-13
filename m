From: Arnaud Mouiche <arnaud.mouiche@invoxia.com>
Subject: Re: Help debugging a sound problem
Date: Mon, 13 Mar 2017 09:37:05 +0100
Message-ID: <cd82e427-6618-cb75-a51d-44c423992a7c@invoxia.com>
References: <AM2PR07MB1027F3B5CB106FB3AACC1A78A1250@AM2PR07MB1027.eurprd07.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wm0-f43.google.com (mail-wm0-f43.google.com [74.125.82.43])
 by alsa0.perex.cz (Postfix) with ESMTP id DF5FD265823
 for <alsa-devel@alsa-project.org>; Mon, 13 Mar 2017 09:37:07 +0100 (CET)
Received: by mail-wm0-f43.google.com with SMTP id v186so34501585wmd.0
 for <alsa-devel@alsa-project.org>; Mon, 13 Mar 2017 01:37:07 -0700 (PDT)
Received: from [192.168.65.110] (AAnnecy-653-1-203-107.w86-209.abo.wanadoo.fr.
 [86.209.22.107])
 by smtp.gmail.com with ESMTPSA id c58sm24032098wrc.9.2017.03.13.01.37.06
 for <alsa-devel@alsa-project.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 13 Mar 2017 01:37:06 -0700 (PDT)
In-Reply-To: <AM2PR07MB1027F3B5CB106FB3AACC1A78A1250@AM2PR07MB1027.eurprd07.prod.outlook.com>
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

Hmm, doesn't look like an audio related issue at all.

If I have to bet, I would say something like "time required to load 
application/library pages from the filesystem"
How is mounted you root filesystem ?
What is the memory pressure ?
You should look at /proc/PID/smaps and compare the content BEFORE and AFTER.

good luck :)
Arnaud

On 13/03/2017 07:43, Jorge Fernandez Monteagudo wrote:
> Hi all,
>
>
> This is my first email to the list. I've joined to it because I don't know where to look for help.
>
>
> We have a iMX6 (ARM) board with a STA559BW audio codec connected by the I2S interface.
>
> We are using a 3.14.52 kernel with a custom sta559 codec driver based on the TAS5709 codec
>
> driver. Our system has the alsa library 1.0.28. Our application uses SDL 1.2.15 to handle the sound
>
> system.
>
>
> When we run the application the sound system works ok, but when we leave the application running
>
> without playing any sound for one night then next morning we found the sound is delayed more or less
>
> one second from when the sound is played until the sound it's heard. Traces in the SDL audiocallback
>
> are ok, the same as when the sound is played ok.
>
>
> Another clue. An 'aplay' executed in another console is played ok with no delay.
>
>
> Another one. If the application process is attached with gdb and then deattached then the sounds works
>
> ok again!
>
>
> Any help is welcome in order to begin to debug this situation.
>
>
> Thanks!
>
> Jorge
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
