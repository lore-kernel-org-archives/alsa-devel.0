From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: [PATCH 3/3] Add handling CMP output connection
Date: Mon, 29 Apr 2013 08:30:27 +0200
Message-ID: <517E1383.3000603@ladisch.de>
References: <1367125189-377-1-git-send-email-o-takashi@sakamocchi.jp>
 <1367125189-377-4-git-send-email-o-takashi@sakamocchi.jp>
 <517D1B89.506@ladisch.de> <517DF48A.9000702@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com
 [66.111.4.27]) by alsa0.perex.cz (Postfix) with ESMTP id D9AA726171D
 for <alsa-devel@alsa-project.org>; Mon, 29 Apr 2013 08:30:28 +0200 (CEST)
In-Reply-To: <517DF48A.9000702@sakamocchi.jp>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Cc: alsa-devel@alsa-project.org, linux1394-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Takashi Sakamoto wrote:
> Then I have a question about handling payload field. In specification,
> "The payload field shall specify the maximum number of quadlets that
> may be transmitted in a single isochronous packet for this plug" but
> actually cheking this field seems to make no sense because there is no
> checking process in the procedure. I think I can do nothing for
> payload field.

The specification was written for the general case where the device that
creates the connection might be different from the transmitting and
receiving devices.  In that case, the payload size is needed for correct
bandwidth allocation.

In our case, the Linux PC does not have plugs that could be accessed by
anybody else.  (And I'm not sure if the value set by the Fireworks
firmware is correct enough so that we'd want to use it.)


Regards,
Clemens
