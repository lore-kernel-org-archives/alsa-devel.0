From: "Patrick Shirkey" <pshirkey@boosthardware.com>
Subject: headset vs speaker
Date: Thu, 14 Aug 2014 01:39:00 +1000 (EST)
Message-ID: <62311.86.107.254.57.1407944340.squirrel@boosthardware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from boosthardware.localdomain (boosthardware.com [88.198.122.139])
 by alsa0.perex.cz (Postfix) with ESMTP id AF648261A2F
 for <alsa-devel@alsa-project.org>; Wed, 13 Aug 2014 17:39:01 +0200 (CEST)
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

Hi,

How does headset detection work in general with alsa?

I need to understand the Allwinner A20 SoC audio driver logic for the
headset and speaker outputs.

My goal is to enable standard audio playback through the headset but to
allow another audio stream to playback through the speaker while the
headset is connected.

I have seen that it is possible with other chips like the hda_intel.

Is it a hardware limitation or driver/software regulated?




--
Patrick Shirkey
Boost Hardware Ltd
