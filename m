From: "Johannes Lorenz" <johannes89@mailueberfall.de>
Subject: Re: parallel, real time safe waiting?
Date: Wed, 15 Apr 2015 17:51:13 +0200
Message-ID: <trinity-693dbbc8-d0ec-49e1-98f9-4ddaa02f7127-1429113073279@3capp-gmx-bs14>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
 by alsa0.perex.cz (Postfix) with ESMTP id A0D31260640
 for <alsa-devel@alsa-project.org>; Wed, 15 Apr 2015 17:51:13 +0200 (CEST)
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

Ok, last question about this topic: Is blocked snd_pcm_reading/writing both

  a. real time safe and
  b. does not "consume 100 percent cpu power", i.e. waits silently?

Thanks for the help.
