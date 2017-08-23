From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Attempting to understand odd snd-usb-audio code
 and behavior
Date: Wed, 23 Aug 2017 14:52:43 +0200
Message-ID: <f5769b3d-0bb1-cd15-90a6-3983cb28f8ff@ladisch.de>
References: <2006820.TBXnYHJvYE@kamdesktop>
 <ac221250-a87f-0875-1172-846530607635@ladisch.de>
 <1954362.aJMGcWAYHc@kamdesktop>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from webclient5.webclient5.de (webclient5.webclient5.de
 [136.243.32.179])
 by alsa0.perex.cz (Postfix) with ESMTP id C67692664EB
 for <alsa-devel@alsa-project.org>; Wed, 23 Aug 2017 14:52:46 +0200 (CEST)
Received: from [10.1.2.4] (unknown [94.101.37.79])
 by webclient5.webclient5.de (Postfix) with ESMTPSA id 9434355821B8
 for <alsa-devel@alsa-project.org>; Wed, 23 Aug 2017 14:52:43 +0200 (CEST)
In-Reply-To: <1954362.aJMGcWAYHc@kamdesktop>
Content-Language: en-US
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

Keith A. Milner wrote:
>>> kernel: [ 1987.452947] usb 1-1: Unable to change format on ep #8e: already in use
>
> So the error messages are due to a userspace app trying to open playback and
> capture at the same time?

For this device, playback requires a running capture stream to determine
the rate of packets.  This error happens when the application tries to
open the capture stream after the playback stream.  (If the format does
not actually need to change, the error message is misleading.)

Your actual problem is that the device does not send any capture packets.


Regards,
Clemens
