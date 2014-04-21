From: Santhosh N M <santo4ul@gmail.com>
Subject: Disabling DAPM from ASoC framework
Date: Mon, 21 Apr 2014 13:10:42 +0530
Message-ID: <CAGziFAC5k3faFMGtWov5jWf14aRXn7K1-Y_f=WfZ0t6jzSGsOA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qa0-f51.google.com (mail-qa0-f51.google.com
 [209.85.216.51])
 by alsa0.perex.cz (Postfix) with ESMTP id 02F212610B7
 for <alsa-devel@alsa-project.org>; Mon, 21 Apr 2014 09:41:23 +0200 (CEST)
Received: by mail-qa0-f51.google.com with SMTP id j7so3582120qaq.10
 for <alsa-devel@alsa-project.org>; Mon, 21 Apr 2014 00:41:23 -0700 (PDT)
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

   I'm a newbie to ALSA/ASoC framework. Lets say there is a requirement,
where, the application (user space) takes the responsibility to switch
ON/OFF the power components of the codec components (using ALSA Mixer
Interface).

   In this case, is there a standard way to disable DAPM from ASoC? One way
I see (and found to be working) is setting num_dapm_widgets=0
and num_dapm_routes=0 before invoking snd_soc_register_codec()

Thanks in advance for your help.

Best Regards,
San
