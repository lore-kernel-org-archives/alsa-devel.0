From: Rajaram R <rajaram.officemail@gmail.com>
Subject: USB Audio/ALSA
Date: Thu, 12 Sep 2013 09:00:31 +0530
Message-ID: <CAOiXha+sn0okoKFN9Q-C0PLmP1EqServFfFLSHsJT-NCq1+z=w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-vc0-f180.google.com (mail-vc0-f180.google.com
 [209.85.220.180])
 by alsa0.perex.cz (Postfix) with ESMTP id E357D261AF8
 for <alsa-devel@alsa-project.org>; Thu, 12 Sep 2013 05:30:32 +0200 (CEST)
Received: by mail-vc0-f180.google.com with SMTP id gf11so6994539vcb.11
 for <alsa-devel@alsa-project.org>; Wed, 11 Sep 2013 20:30:32 -0700 (PDT)
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

Hi

I am trying to bring up Android Accessory Audio in my Samsung Grand
mobile.. I am using a Linux PC for the same. The mobile re-enumerates in
AOA mode with an Audio interface. But when I play song, I see nothing on
the bus.  I can see an AOA audio device entry in /proc/asound/cards. The
mobile runs Android JB

The error i see when I play is "Sorry this player does not support this
type of audio file android" . I also tried a Note 2  & tab 2 with JB, i
dont see the error , but still i dont see anything on the bus.. Nexus is
working fine in the same setup.

Also logcat shows information as below. When i search net i understand some
problem with ALSA/Android handshake

AudioTrack: obtainBuffer timed out (is the CPU pegged?).......some
address............
AudioTrack: obtainBuffer timed out (is the CPU pegged?).......some
address............
AudioTrack: obtainBuffer timed out (is the CPU pegged?).......some
address............
AudioTrack: obtainBuffer timed out (is the CPU pegged?).......some
address............

Looking forward for some support
