From: David Henningsson <david.henningsson@canonical.com>
Subject: TLV question - ranges not in volume order
Date: Wed, 08 May 2013 13:21:41 +0200
Message-ID: <518A3545.8000809@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id 246322651C2
 for <alsa-devel@alsa-project.org>; Wed,  8 May 2013 13:21:41 +0200 (CEST)
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
Cc: rex.tsai@canonical.com
List-Id: alsa-devel@alsa-project.org

Hi,

I recently came across a strange ASoC volume control. In this case, the 
values are not in volume order, i e, the control is declared something 
like below. I believe the numbers correctly match the hardware.

However alsamixer seems not to handle this "reordering" correctly. My 
question is if this is something that should be fixed in alsamixer (or 
possibly alsa-lib?), or does one need to write some kind of mapping 
table in the kernel, just to make something come in volume order to 
userspace?

Any TLV documentation on what TLVs are valid and invalid is also welcome :-)

static const unsigned int tlv[] = {
         TLV_DB_RANGE_HEAD(8),
         0, 0, TLV_DB_SCALE_ITEM(-100, 0, 1),
         1, 1, TLV_DB_SCALE_ITEM(400, 0, 0),
         2, 2, TLV_DB_SCALE_ITEM(200, 0, 0),
         3, 3, TLV_DB_SCALE_ITEM(1000, 0, 0),
         4, 4, TLV_DB_SCALE_ITEM(0, 0, 0),
         5, 5, TLV_DB_SCALE_ITEM(800, 0, 0),
         6, 6, TLV_DB_SCALE_ITEM(600, 0, 0),
         7, 7, TLV_DB_SCALE_ITEM(1200, 0, 0),
};

-- 
David Henningsson, Canonical Ltd.
https://launchpad.net/~diwic
