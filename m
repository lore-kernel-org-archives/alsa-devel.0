From: Vishal T <vt45101@gmail.com>
Subject: [ASoC] Free kcontrol memory while unregistering codec
Date: Wed, 25 Mar 2015 18:01:44 +0530
Message-ID: <20150325123144.GA30509@vishal>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pa0-f46.google.com (mail-pa0-f46.google.com
 [209.85.220.46])
 by alsa0.perex.cz (Postfix) with ESMTP id 08B7D26070C
 for <alsa-devel@alsa-project.org>; Wed, 25 Mar 2015 13:31:53 +0100 (CET)
Received: by pabxg6 with SMTP id xg6so27731807pab.0
 for <alsa-devel@alsa-project.org>; Wed, 25 Mar 2015 05:31:51 -0700 (PDT)
Received: from vishal ([202.131.115.146])
 by mx.google.com with ESMTPSA id km11sm2333672pbd.90.2015.03.25.05.31.49
 for <alsa-devel@alsa-project.org>
 (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
 Wed, 25 Mar 2015 05:31:50 -0700 (PDT)
Content-Disposition: inline
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

Hi,

While going through the codec cleanup code (snd_soc_unregister_codec()),
I could not find the code which frees memory allocated for snd_kcontrol
(while adding the kcontrols to card). Am I missing anything obvious?
Sorry if I have created noise.

Thanks,
V
