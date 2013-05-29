From: =?ISO-8859-1?Q?Juho_H=E4m=E4l=E4inen?= <juho.hamalainen@tieto.com>
Subject: UCM {Supported,Conflicting}Device confusion
Date: Wed, 29 May 2013 13:55:38 +0300
Message-ID: <51A5DEAA.4020007@tieto.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ebb05.tieto.com (ebb05.tieto.com [131.207.168.36])
 by alsa0.perex.cz (Postfix) with ESMTP id 5451F2619F9
 for <alsa-devel@alsa-project.org>; Wed, 29 May 2013 12:55:40 +0200 (CEST)
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

Hello,

Firstly as a sidenote, Supported/Conflicting is checked only one-way, if 
say devices A and B are enabled and say B has ConflictingDevice "C", and 
device C doesn't list anything, enabling of C is possible (and after 
that disabling C is not possible before B is disabled first).

Now, looking at the way SupportedDevice and ConflictingDevice are 
implemented in ucm and I came to following conclusion:

If no SupportedDevice or ConflictingDevice: All devices and combinations 
are compatible, so implicit "SupportedDevice ALL".

If SupportedDevice is listed: Device can be enabled as long as at least 
one enabled device is in SupportedDevice list.

If ConflictingDevice is listed: Device can be enabled if none of active 
devices are in ConflictingDevice list (noting aforementioned limit in 
checking this)

This is at least how I figured all combinations of multiple devices can 
be defined with only zero or one either SupportedDevice or 
ConflictingDevice entry per device.

Did I understand this right?

-- 
juho
