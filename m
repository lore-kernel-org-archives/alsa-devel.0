From: louis@museresearch.com
Subject: UAC2 clock selector for AudioBox 1818VSL
Date: Thu, 6 Sep 2012 13:20:53 -0700
Message-ID: <76bd1b6473c857ddd3160280e278e4fb.squirrel@master.museresearch.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from master.museresearch.com (master.museresearch.com [69.59.28.231])
 by alsa0.perex.cz (Postfix) with ESMTP id 01128261646
 for <alsa-devel@alsa-project.org>; Thu,  6 Sep 2012 22:20:58 +0200 (CEST)
Received: from localhost ([127.0.0.1]:39994 helo=master.museresearch.com)
 by master.museresearch.com with esmtpa (Exim 4.77)
 (envelope-from <louis@museresearch.com>) id 1T9iZJ-0005Go-Va
 for alsa-devel@alsa-project.org; Thu, 06 Sep 2012 13:20:54 -0700
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

Hi!
  I'm attempting to get the "Clock Selector" mixer control to work with
the PreSonus AudioBox 1818VSL (a UAC2 device).

The control shows up in amixer as an enumerated value, but I don't seem to
be able to set it (I've tried amixer, alsactl, and setting it
programmatically). The possible values are correct (listing Internal
Clock, S/PDIF Clock, and ADAT Clock as possible options); It just doesn't
appear to take my setting, by which I mean amixer doesn't update the
settings, I still have the occasional click when the sampling rates match
over S/PDIF and I attempt to use external sync. No error is returned.

After digging around USB specs and ALSA's usb/mixer.c and being unfamiliar
with both the USB audio spec and the inner workings of ALSA, I thought
it'd be best to ask the list about this: How would I check to see if ALSA
is asking the device to change clock source at all?

-Louis
