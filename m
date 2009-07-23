From: Guilherme Longo <grlongo.ireland@gmail.com>
Subject: Is snd_pcm_hw_params_set_period_time_near the same as
 sampling period?
Date: Thu, 23 Jul 2009 12:24:32 -0300
Message-ID: <4A6880B0.3000903@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from wa-out-1112.google.com (wa-out-1112.google.com [209.85.146.181])
	by alsa0.perex.cz (Postfix) with ESMTP id 8B6F724536
	for <alsa-devel@alsa-project.org>;
	Thu, 23 Jul 2009 17:24:42 +0200 (CEST)
Received: by wa-out-1112.google.com with SMTP id m16so146550waf.16
	for <alsa-devel@alsa-project.org>; Thu, 23 Jul 2009 08:24:40 -0700 (PDT)
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

Hi mates.

I am trying to understand a piece of a code  I am  studing .
What does exactly the functions snd_pcm_hw_params_set_period_time_near  
sets?

In my understand period time should be the time between 2 consecutive 
samples, but the following code does not appears to be calculating that.

buffer_time = 500000  // What I believe that means 0.5s as US is the 
unit used.

if (period_time == 0 && period_frames == 0) {
       if (buffer_time > 0)
             period_time = buffer_time / 4;
       else
           period_frames = buffer_frames / 4;
}

Is this period time the same as period describled in here:

http://www.fon.hum.uva.nl/praat/manual/sampling_period.html

Thanks!
