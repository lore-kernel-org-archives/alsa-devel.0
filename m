From: =?EUC-KR?B?udq/tbHi?= <ghostyak@gmail.com>
Subject: alsa-lib v1.0.16 error
Date: Tue, 24 Jul 2012 10:02:47 +0900
Message-ID: <500DF437.3030603@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-yx0-f179.google.com (mail-yx0-f179.google.com
 [209.85.213.179])
 by alsa0.perex.cz (Postfix) with ESMTP id BC319264FA9
 for <alsa-devel@alsa-project.org>; Tue, 24 Jul 2012 03:02:49 +0200 (CEST)
Received: by yenr13 with SMTP id r13so5871801yen.38
 for <alsa-devel@alsa-project.org>; Mon, 23 Jul 2012 18:02:51 -0700 (PDT)
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

Hi all,

I'm a beginner developer in ALSA.
I got an error in my application which uses alsa v1.0.16 and
Segmentation Fault too.

My system is :
- OS: embedded linux
- CPU: S3C-6410 CPU
- CODEC: WM9713

I want to resolve this problem. So what should I do?
is there an patch? Or do I have to migration to higher version? Or how
to debug?


ALSA lib confmisc.c:1286:(snd_func_refer) Unable to find definition
'defaults.ctl.card'
ALSA lib conf.c:3513:(_snd_config_evaluate) function snd_func_refer
returned error: No such file or directory
ALSA lib confmisc.c:251:(snd_func_getenv) error evaluating default
ALSA lib conf.c:3513:(_snd_config_evaluate) function snd_func_getenv
returned error: No such file or directory
ALSA lib conf.c:3985:(snd_config_expand) Evaluate error: No such file or
directory
ALSA lib control.c:909:(snd_ctl_open_noupdate) Invalid CTL default


Regards,
Young-Gi (YG) Park
