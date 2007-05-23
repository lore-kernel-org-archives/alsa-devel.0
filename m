From: "Prabhu Sivaraja" <prabhu.sivaraja@gmail.com>
Subject: Default Sample rate Conversion
Date: Tue, 22 May 2007 21:40:43 -0700
Message-ID: <49f264960705222140n56b7b561r70102cf17d6991cf@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from nz-out-0506.google.com (nz-out-0506.google.com [64.233.162.230])
	by alsa0.perex.cz (Postfix) with ESMTP id 7682A245B2
	for <alsa-devel@alsa-project.org>;
	Wed, 23 May 2007 06:40:45 +0200 (CEST)
Received: by nz-out-0506.google.com with SMTP id i11so186527nzi
	for <alsa-devel@alsa-project.org>; Tue, 22 May 2007 21:40:44 -0700 (PDT)
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
To: ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Does ALSA automatically convert to my devices sample rate?
My alsa.conf file is below

 pcm.mix {
        type dmix
        ipc_key 1024
        slave {
         pcm "hw:0,0"
         rate 48000
        }
    }
    pcm.!default {
        type plug
        slave.pcm "mix"
    }

When I play a 32KHz file with aplay does it get up sampled to my device's
48KHz sample rate? I am assuming it does as it plays just fine but I am not
sure where the upsampling happens?

Thanks.
