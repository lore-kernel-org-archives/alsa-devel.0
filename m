From: =?ISO-8859-1?Q?Jo=EBl_Kr=E4hemann?= <weedlight@gmail.com>
Subject: Warning Big Yield
Date: Thu, 14 Aug 2014 14:33:46 +0200
Message-ID: <1408019626.6670.5.camel@debian>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wi0-f171.google.com (mail-wi0-f171.google.com
 [209.85.212.171])
 by alsa0.perex.cz (Postfix) with ESMTP id 4F07026592C
 for <alsa-devel@alsa-project.org>; Thu, 14 Aug 2014 14:33:53 +0200 (CEST)
Received: by mail-wi0-f171.google.com with SMTP id hi2so8842521wib.16
 for <alsa-devel@alsa-project.org>; Thu, 14 Aug 2014 05:33:52 -0700 (PDT)
Received: from [192.168.42.170] (130-225.197-178.cust.bluewin.ch.
 [178.197.225.130])
 by mx.google.com with ESMTPSA id h3sm11200622wjz.48.2014.08.14.05.33.50
 for <alsa-devel@alsa-project.org>
 (version=SSLv3 cipher=RC4-SHA bits=128/128);
 Thu, 14 Aug 2014 05:33:51 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel mailing list <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

I'd really like to know if there's a common way to do syncing
applications. What frequencies are required to run a GUI?  How does Xorg
work and how can I prevent interfering with ALSA output? And what base
frequency is recommended to threads?

Warning you may experience big yield.

please take a look at ags_thread_loop() in:
http://sourceforge.net/p/ags/code/HEAD/tree/src/ags/thread/ags_thread-posix.c
