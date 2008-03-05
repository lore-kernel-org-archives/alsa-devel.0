From: "Aggarwal, Anuj" <anuj.aggarwal@ti.com>
Subject: How to do pause/resume in ALSA application
Date: Wed, 5 Mar 2008 14:50:03 +0530
Message-ID: <010C7BAE6783F34D9AC336EE5A01A0880575F767@dbde01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from soda.ext.ti.com (soda.ext.ti.com [198.47.26.145])
	by alsa0.perex.cz (Postfix) with ESMTP id 7F7FE243B3
	for <alsa-devel@alsa-project.org>; Wed,  5 Mar 2008 10:20:22 +0100 (CET)
Content-class: urn:content-classes:message
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
Cc: suresh.raj@gmail.com
List-Id: alsa-devel@alsa-project.org

Hi, 

 

I am using the snd_pcm_pause API in my application but it is returning
error: Invalid argument. I am passing the PCM handle of the playback
stream which I opened earlier and using to play a WAV file. Although I
am able to hear the WAV file correctly, I am not able to pause. I
checked whether the pause functionality is supported, using
snd_pcm_hw_params_can_pause() and it returned me success.

 

Any help is welcome.

 

Thanks & Regards,

Anuj Aggarwal
