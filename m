From: Jason Mancine <jason@mancine.net>
Subject: Re: Zoom R16
Date: Fri, 6 Dec 2013 16:10:01 +0000 (UTC)
Message-ID: <loom.20131206T170648-556@post.gmane.org>
References: <CAPrbH=vnQ-xXsRDoj30nra7hB_hDEaF6u3ov0XuDG_ZpFzb3bA@mail.gmail.com>
 <20131124130335.GA23126@tamtam.fritz.box>
 <CAPrbH=tGph7__rgx-5BsBSi9-E95FpsTL9Yy0zbum0TccTPbyQ@mail.gmail.com>
 <20131124141803.GC23126@tamtam.fritz.box>
 <CAPrbH=sA5ppp8z3bqdaDnk4U+DZ093ukXpDgiT6DEixGi1tdZA@mail.gmail.com>
 <CAPrbH=tu0jTctOAegkT7tnq1VSGOui4cESA2rYJFfgCa3=tQDg@mail.gmail.com>
 <CAPrbH=v+fVMibUGC8FqBbW-Gd6NW7uZFCgq7fxw9hiaPGR_04g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from plane.gmane.org (plane.gmane.org [80.91.229.3])
 by alsa0.perex.cz (Postfix) with ESMTP id 4A5DB2655C8
 for <alsa-devel@alsa-project.org>; Fri,  6 Dec 2013 17:10:25 +0100 (CET)
Received: from list by plane.gmane.org with local (Exim 4.69)
 (envelope-from <glad-alsa-devel-2@m.gmane.org>) id 1Voxyw-0004uS-82
 for alsa-devel@alsa-project.org; Fri, 06 Dec 2013 17:10:22 +0100
Received: from bb-205-209-90-54.gwi.net ([205.209.90.54])
 by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
 id 1AlnuQ-0007hv-00
 for <alsa-devel@alsa-project.org>; Fri, 06 Dec 2013 17:10:22 +0100
Received: from jason by bb-205-209-90-54.gwi.net with local (Gmexim 0.1
 (Debian)) id 1AlnuQ-0007hv-00
 for <alsa-devel@alsa-project.org>; Fri, 06 Dec 2013 17:10:22 +0100
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

It seems that ALSA is trying to initialize the device at 32-bit integer
little endian despite having the .formats set to SNDRV_PCM_FMTBIT_S24_LE in
the quirk. The device is 24-bit integer only.  Other devices I have
initialize properly at 24 bits.

Perhaps capture works because the device is running at 24 bits and sending
info into the 32 bit driver... and playback fails because the driver is
trying to force the device to operate at 32 bits, which it is incapable of???

Is there another/better way to force the bitrate to 24 bits?
