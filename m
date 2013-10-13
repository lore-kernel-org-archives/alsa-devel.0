From: Michael Trimarchi <michael@amarulasolutions.com>
Subject: dsp after dmix
Date: Sun, 13 Oct 2013 14:34:23 +0200
Message-ID: <CAOf5uwmrS1AZrmKfbUYokU1Azdd2dZv2=Z=fGp+UQyy_mW1ijQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wg0-f46.google.com (mail-wg0-f46.google.com [74.125.82.46])
 by alsa0.perex.cz (Postfix) with ESMTP id F2727261AB1
 for <alsa-devel@alsa-project.org>; Sun, 13 Oct 2013 14:34:23 +0200 (CEST)
Received: by mail-wg0-f46.google.com with SMTP id k14so6367448wgh.25
 for <alsa-devel@alsa-project.org>; Sun, 13 Oct 2013 05:34:23 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hi all,

I have written a plugin to use the dsp of omapl138 and filtering the
audio stream.
My problem is to apply filtering after dmix plugin. Is there a way to have dsp
filtering after alsa mixing?

Michael
