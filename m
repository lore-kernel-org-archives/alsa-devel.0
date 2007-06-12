From: "Nobin Mathew" <nobin.mathew@gmail.com>
Subject: Shutdown() vector in ALSA
Date: Tue, 12 Jun 2007 14:26:08 +0530
Message-ID: <8d6898730706120156v6e8e95c6xb2d3878078465f08@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from nz-out-0506.google.com (nz-out-0506.google.com [64.233.162.229])
	by alsa0.perex.cz (Postfix) with ESMTP id B2F2424537
	for <alsa-devel@alsa-project.org>;
	Tue, 12 Jun 2007 10:56:09 +0200 (CEST)
Received: by nz-out-0506.google.com with SMTP id j2so1422251nzf
	for <alsa-devel@alsa-project.org>; Tue, 12 Jun 2007 01:56:08 -0700 (PDT)
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
To: perex@suse.cz
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

why no ALSA driver has shutdown() vector implemented?

Is this vector needed to ensure the proper shutdown of the system?

What all needs to be taken care if i want to implement shutdown(),
except hardware shutdown.


struct snd_shutdown_f_ops {
	struct file_operations f_ops;
	struct snd_shutdown_f_ops *next;
};

what this operations means? defined in sound/core/init.c

Is there any need to call these functions?
snd_power_change_state(card, SNDRV_CTL_POWER_D3hot);
for (i = 0; i < chip->pcm_devs; i++)
	snd_pcm_suspend_all(chip->pcm[i]);
