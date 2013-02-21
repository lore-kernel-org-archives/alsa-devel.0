From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Discovery of device characteristics
Date: Thu, 21 Feb 2013 08:43:43 +0100
Message-ID: <5125D02F.9000203@ladisch.de>
References: <B053C7AF-BC91-4B13-B3AE-963AB6CC988C@onetel.com>
 <512531DC.6010701@ladisch.de>
 <0AAD2327-63B2-41DE-B351-59A1378BCFE4@onetel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com
 [66.111.4.25]) by alsa0.perex.cz (Postfix) with ESMTP id 697472602C7
 for <alsa-devel@alsa-project.org>; Thu, 21 Feb 2013 08:43:52 +0100 (CET)
In-Reply-To: <0AAD2327-63B2-41DE-B351-59A1378BCFE4@onetel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Tim Hewett <tghewett2@onetel.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Tim Hewett wrote:
> I'm trying to find an API for being notified when devices are added/removed.

Use the libudev monitoring interface:
http://www.signal11.us/oss/udev/
http://www.freedesktop.org/software/systemd/libudev/libudev-udev-monitor.html


Regards,
Clemens
