From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Softvol only after device has opened
Date: Tue, 09 Jun 2015 14:21:13 +0200
Message-ID: <5576DA39.7090105@ladisch.de>
References: <alpine.DEB.2.02.1506091304020.15001@lnxricardw1.se.axis.com>
 <5576D38C.4030907@ladisch.de>
 <alpine.DEB.2.02.1506091416530.15001@lnxricardw1.se.axis.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from dehamd003.servertools24.de (dehamd003.servertools24.de
 [31.47.254.18]) by alsa0.perex.cz (Postfix) with ESMTP id 108AB26528B
 for <alsa-devel@alsa-project.org>; Tue,  9 Jun 2015 14:21:15 +0200 (CEST)
In-Reply-To: <alpine.DEB.2.02.1506091416530.15001@lnxricardw1.se.axis.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Ricard Wanderlof <ricard.wanderlof@axis.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Ricard Wanderlof wrote:
> Can "alsactl restore" be run before the device is opened then?

Many distributions run "alsactl restore" in some startup script.
You can execute it yourself whenever you want.


Regards,
Clemens
