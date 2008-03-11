From: "Chris Healy" <cphealy@gmail.com>
Subject: ALSA Version change
Date: Tue, 11 Mar 2008 11:30:11 -0700
Message-ID: <370c08350803111130i2d4147f2q9a7345d11ccbc6c7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from py-out-1112.google.com (py-out-1112.google.com [64.233.166.182])
	by alsa0.perex.cz (Postfix) with ESMTP id 6AAD41038A2
	for <alsa-devel@alsa-project.org>; Tue, 11 Mar 2008 19:30:16 +0100 (CET)
Received: by py-out-1112.google.com with SMTP id w49so4603866pyg.36
	for <alsa-devel@alsa-project.org>; Tue, 11 Mar 2008 11:30:12 -0700 (PDT)
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
To: alsa-devel@alsa-project.org
Cc: cphealy@rockwellcollins.com
List-Id: alsa-devel@alsa-project.org

Currently, I am using a 2.6.19.2 kernel with ALSA version 1.0.13.  This is
on an i.MX31 ARM11 platform.  (This is what it came with.)  We want to use a
codec that currently has and ASoC supported driver so it seems best that we
move forward to a newer version of ALSA.  (1.0.14 or later has ASoC.)

If we are going to the trouble of moving from 1.0.13 to a later version,
does it make sense to port to 1.0.14 or 1.0.16?  It makes sense that moving
to 1.0.14 would take the least effort, but obviously, 1.0.16 has bug fixes
and features.  Do you think there is a large delta porting wise between
moving to 1.0.16 instead of 1.0.14.  (The assumption is that we have to move
over to the later alsa-lib and alsa-utils, correct?)

The other question we have is in reference to the max number of cards we are
working with.  This is an embedded system and we want to control 16 audio
codecs, (cards).  We won't be using the PCM interfaces of these cards, but
we do need to control the codecs through the mixer interface.  I have seen
limitations previously alluding to a maximum of 8 cards but this was a few
years ago.  Is this true with the most recent versions, and if so, any ideas
on what is necessary to change this?

Thanks,

Chris
