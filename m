From: Martin Cracauer <cracauer@cons.org>
Subject: Guide to USB debugging in Windows?
Date: Fri, 29 Mar 2013 11:36:39 -0400
Message-ID: <20130329153639.GA72429@cons.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from koef.zs64.net (koef.zs64.net [212.12.50.230])
 by alsa0.perex.cz (Postfix) with ESMTP id 3B26026534C
 for <alsa-devel@alsa-project.org>; Fri, 29 Mar 2013 16:36:42 +0100 (CET)
Received: from koef.zs64.net (koef.zs64.net [IPv6:2a00:14b0:4200:32e0::1e6])
 by koef.zs64.net (8.14.6/8.14.5) with ESMTP id r2TFadSN076456
 for <alsa-devel@alsa-project.org>; Fri, 29 Mar 2013 15:36:39 GMT
 (envelope-from cracauer@koef.zs64.net)
Received: (from cracauer@localhost)
 by koef.zs64.net (8.14.6/8.14.5/Submit) id r2TFad3S076455
 for alsa-devel@alsa-project.org; Fri, 29 Mar 2013 11:36:39 -0400 (EDT)
 (envelope-from cracauer)
Content-Disposition: inline
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

Does anyone have instructions on how to use a USB traffic monitor on
windows to extract some bits needed to control a sound device under
ALSA? As in, for people not normally developing in windows?

I have here a Sound Devices USBPre v1.  It is mostly USB 1.1 sound
interface compatible and it accepts a stream played from ALSA under
Linux just fine.  The problem is that the manufacturer has decided to,
in addition to the standard usb sound interface, have all the
different inputs on the device behind on/off switches, all of them
controlled by secret bits in the windows and mac drivers, all of them
default to off.  So thingie is a brick as-is.  I don't blame them too
hard, they now make a v2 of this devices and fixed it.

Just so that I don't appear more insane than usual, let me say why I
want to bother.

The windows drivers for this are only available in 32 bit, and the mac
drivers are 32 bit only as well, in addition the mac drivers never
went > 16bit/48KHz.  The inability to use this on modern macs and
windows machines has pushed the price of these things very low on
Ebay, considering it is a fully professional device with the best mic
preamps you can get.  If would be really cool if this could work under
ALSA, and as you see I figured it needs just a couple of bits that you
need to flip with some magic to at least get it to run up to 16bit/48KHz.

Martin
-- 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Martin Cracauer <cracauer@cons.org>   http://www.cons.org/cracauer/
