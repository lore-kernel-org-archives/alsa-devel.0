From: Martin Schreiber <mse00000@gmail.com>
Subject: Re: [BUG] snd_pcm_drop() does not stop the PCM
 immediately
Date: Wed, 14 Mar 2018 17:57:04 +0100
Message-ID: <08489e55-7882-dd12-a3b7-e9b910197a60@gmail.com>
References: <32cead2b-d2fc-485f-70e9-e528bc2fe63e@gmail.com>
 <s5hvady8zbk.wl-tiwai@suse.de>
 <332672f7-eabb-73a2-9f76-d03e8c9c253c@gmail.com>
 <s5hk1ue8wft.wl-tiwai@suse.de>
 <bdf166af-553f-3f4e-187b-0e5120ffcf19@gmail.com>
 <s5hbmfq8uwe.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wm0-f49.google.com (mail-wm0-f49.google.com [74.125.82.49])
 by alsa0.perex.cz (Postfix) with ESMTP id 47D00266EBE
 for <alsa-devel@alsa-project.org>; Wed, 14 Mar 2018 17:57:07 +0100 (CET)
Received: by mail-wm0-f49.google.com with SMTP id i194so5365739wmg.1
 for <alsa-devel@alsa-project.org>; Wed, 14 Mar 2018 09:57:07 -0700 (PDT)
In-Reply-To: <s5hbmfq8uwe.wl-tiwai@suse.de>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 03/14/2018 05:49 PM, Takashi Iwai wrote:

>> It does better, see attached alsadrop2.c.
> 
> Hm, interesting.  Could you track down why it makes difference?

Difficult for me because I have no clue about Alsa internals. I hope
that Fred van Stappen helps out, he is a big Alsa fan. :-)

Martin
