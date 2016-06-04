From: lin-alsa@noblejury.com
Subject: CIP Discontinuity with snd-firewire-digi00x
Date: Sat, 4 Jun 2016 17:30:36 -0500 (EST)
Message-ID: <alpine.LNX.2.20.1606041726460.13950@anticlack.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from click1.anticlack.com (noblejury.com [45.33.77.79])
 by alsa0.perex.cz (Postfix) with ESMTP id C96502614A1
 for <alsa-devel@alsa-project.org>; Sun,  5 Jun 2016 00:30:37 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by click1.anticlack.com (Postfix) with ESMTP id F21E11E5F0
 for <alsa-devel@alsa-project.org>; Sat,  4 Jun 2016 17:30:36 -0500 (EST)
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

All,

I've been working to set up a Digi002 Rack mixer with Jack using the Alsa 
backend. Unfortunately, the mixer seems to desync or something after a few 
minutes - hours. dmesg gives me `snd-firewire-digi00x fw1.0: Detect 
discontinuity of CIP: XX XX` with XX XX replaced with various hex pairs. 
I'm not sure how to debug this, and any help would be much appreciated. 
Also, cat /proc/asound/card1/firewire/clock gives
`Optical mode: adat
Sampling Rate: 88200
Clock Source: internal` so I don't think it's an external clock issue.

Lin
