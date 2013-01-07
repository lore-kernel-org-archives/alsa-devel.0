From: David Henningsson <david.henningsson@canonical.com>
Subject: Alsa snapshot directory layout changed
Date: Mon, 07 Jan 2013 11:58:10 +0100
Message-ID: <50EAAA42.9020701@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id D4F3D2650D1
 for <alsa-devel@alsa-project.org>; Mon,  7 Jan 2013 11:58:09 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

I have a script that picks daily snapshots from 
ftp://ftp.suse.com/pub/people/tiwai/snapshot/alsa-driver-snapshot.tar.gz
...and I just noticed that the directory layout has changed, so what was 
"alsa-driver" is now "alsa-driver/alsa".

Is this expected, i e, should I update my script to follow this new 
layout, or was it a mistake?

-- 
David Henningsson, Canonical Ltd.
https://launchpad.net/~diwic
