From: Daniel Mack <zonque@gmail.com>
Subject: Re: virtual sound driver
Date: Sat, 21 Jul 2012 15:28:49 +0200
Message-ID: <500AAE91.2060605@gmail.com>
References: <164969DEADC6FB4E8F1494DA3D34E98B034641ADAB@EX-SEA19-A.ant.amazon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bk0-f51.google.com (mail-bk0-f51.google.com
 [209.85.214.51])
 by alsa0.perex.cz (Postfix) with ESMTP id 675F2265B7F
 for <alsa-devel@alsa-project.org>; Sat, 21 Jul 2012 15:28:50 +0200 (CEST)
Received: by bkcjk13 with SMTP id jk13so3264972bkc.38
 for <alsa-devel@alsa-project.org>; Sat, 21 Jul 2012 06:28:52 -0700 (PDT)
In-Reply-To: <164969DEADC6FB4E8F1494DA3D34E98B034641ADAB@EX-SEA19-A.ant.amazon.com>
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

On 21.07.2012 03:05, Liu, George wrote:
> I'm trying to write a virtual sound driver to capture PCM data.
> How do I modify dummy.c to capture PCM into buffer?
> 
> Does the PCM data ever sent to any of the pcm_op call backs? There's no read/write callbacks?

Did you consider using some higher layer like PulseAudio to achive that?


Daniel
