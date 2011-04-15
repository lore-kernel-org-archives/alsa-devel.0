From: Shreshtha <shreshthakumar@gmail.com>
Subject: Accessing already probed snd_card in kernel space
Date: Fri, 15 Apr 2011 11:16:41 +0530
Message-ID: <BANLkTi=6LHNZMeKisa57FYqsoYzQ_38vqQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-iw0-f179.google.com (mail-iw0-f179.google.com
	[209.85.214.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 5A7242440E
	for <Alsa-devel@alsa-project.org>;
	Fri, 15 Apr 2011 07:46:43 +0200 (CEST)
Received: by iwc10 with SMTP id 10so2444503iwc.38
	for <Alsa-devel@alsa-project.org>; Thu, 14 Apr 2011 22:46:41 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi, I am completely new to ALSA and ASoC so my question formation may seems
vague but I will try to be clear in objective.
How can I access already detected/populated sound card from inside the
kernel using standard ALSA kernel APIs?
Any mapping of kernel api for the following steps -

1) Find the right ALSA-card. (using snd_card_create)

2) Find the wanted ALSA-control for this card with snd_ctl_find_numid(...).

3) Modify the control

I want to configure the vibrator from kernel using the ALSA kernel APIs.

>From user space alsa_amixer -Dhw set/sset "vibra command" "..."
I want to do it from kernel space using ALSA apis.

BR
Mickey
