From: rohith R <rohith.ubuntu@gmail.com>
Subject: aic3104 confusion with input selection
Date: Thu, 29 Nov 2012 16:52:30 +1030
Message-ID: <CAJnYUCSrehBDFuXLeXSyjxNSSKSn8Vyuqdh=b6xKkPVVdtkLYw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-la0-f51.google.com (mail-la0-f51.google.com
 [209.85.215.51])
 by alsa0.perex.cz (Postfix) with ESMTP id EE144264F9B
 for <alsa-devel@alsa-project.org>; Thu, 29 Nov 2012 07:22:30 +0100 (CET)
Received: by mail-la0-f51.google.com with SMTP id e4so10344233lag.38
 for <alsa-devel@alsa-project.org>; Wed, 28 Nov 2012 22:22:30 -0800 (PST)
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

shouldn't there be a .get function for SOC_DAPM_SINGLE_AIC3X macro?
There is a hole in the list of allowable values for this registers which
the macro addresses (0-8 and 15 for bank 0 registers 17 and register 18 )
