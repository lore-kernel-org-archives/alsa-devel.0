From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: [PATCH RFC 7/9] ALSA: usb-audio: conditional
 interface altsetting
Date: Mon, 19 Aug 2013 12:08:38 +0200
Message-ID: <5211EEA6.6080809@ladisch.de>
References: <1376857363-1116-1-git-send-email-eldad@fogrefinery.com>
 <1376857363-1116-8-git-send-email-eldad@fogrefinery.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com
 [66.111.4.25]) by alsa0.perex.cz (Postfix) with ESMTP id 32A442617B8
 for <alsa-devel@alsa-project.org>; Mon, 19 Aug 2013 12:08:43 +0200 (CEST)
In-Reply-To: <1376857363-1116-8-git-send-email-eldad@fogrefinery.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Eldad Zack <eldad@fogrefinery.com>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, Daniel Mack <zonque@gmail.com>
List-Id: alsa-devel@alsa-project.org

Eldad Zack wrote:
> On some devices, if the endpoint for the other direction is in use,
> setting one interface will shutdown the other (in use) endpoint.

There are (non-UAC) devices where both endpoints are in the same
interface.

> This patch needs revising. It adds a get_interface function, which
> should not be neccesary (possibly unreliable on some devices?).

struct usb_interface has cur_altsetting.


Regards,
Clemens
