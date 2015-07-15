From: David Henningsson <david.henningsson@canonical.com>
Subject: HDMI hotplug on Skylake when power well is off
Date: Wed, 15 Jul 2015 11:05:22 +0200
Message-ID: <55A62252.1050506@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id 517BD26172C
 for <alsa-devel@alsa-project.org>; Wed, 15 Jul 2015 11:05:20 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "Lin, Mengdong" <mengdong.lin@intel.com>, libin.yang@intel.com
List-Id: alsa-devel@alsa-project.org

Hi,

I'm trying to debug an issue here where the HDMI hotplug events are not 
delivered to the audio side when the power well is off. This is on a 
Skylake machine (running in HDA mode).

I'm not sure whether the problem is upstream or due to my own patches 
while testing, so I was wondering how this is supposed to be working, so 
I can troubleshoot further?

Should there be an IRQ on the HDA controller even if the power well is 
off, and if not, how should the audio driver be notified that an HDMI 
hotplug event has happened?

-- 
David Henningsson, Canonical Ltd.
https://launchpad.net/~diwic
