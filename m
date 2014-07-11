From: Himangi Saraogi <himangi774@gmail.com>
Subject: question about sound/soc/ux500/ux500_msp_dai.c
Date: Sat, 12 Jul 2014 01:29:32 +0530
Message-ID: <CAB78YHyi3LSfK-Mc6FvW14RNkCt-8VDuTsd4qJGtAYFde8S+fA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-we0-f178.google.com (mail-we0-f178.google.com
 [74.125.82.178])
 by alsa0.perex.cz (Postfix) with ESMTP id 66B1A2650A0
 for <alsa-devel@alsa-project.org>; Fri, 11 Jul 2014 21:59:33 +0200 (CEST)
Received: by mail-we0-f178.google.com with SMTP id w61so698642wes.9
 for <alsa-devel@alsa-project.org>; Fri, 11 Jul 2014 12:59:33 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Cc: Julia Lawall <julia.lawall@lip6.fr>
List-Id: alsa-devel@alsa-project.org

Hi,

The probe function calls prcmu_qos_add_requirement but on failure it does
not call
prcmu_qos_remove_requirement even though that is done in the remove
function.
The in-kernel definition of both functions just returns 0.  There is a
prototype that is
in a header file, but it is controlled by an #ifdef for an option
CONFIG_DBX500_PRCMU_QOS_POWER that does not seem to be supported by
the kernel.  I am not sure what the prcmu_qos_remove_requirement does.
Should
it be added in the probe function?

Thanks
Himangi
