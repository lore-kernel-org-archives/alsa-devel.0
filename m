From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: [PATCH v4 09/15] ALSA: usb-audio: conditional
	interface altsetting
Date: Mon, 07 Oct 2013 20:23:38 +0200
Message-ID: <5252FC2A.306@ladisch.de>
References: <1381091480-23636-1-git-send-email-eldad@fogrefinery.com>
 <1381091480-23636-10-git-send-email-eldad@fogrefinery.com>
 <s5h7gdps72z.wl%tiwai@suse.de> <alpine.LNX.2.00.1310071920480.1353@anubis>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com
 [66.111.4.25]) by alsa0.perex.cz (Postfix) with ESMTP id 509B4265176
 for <alsa-devel@alsa-project.org>; Mon,  7 Oct 2013 20:23:56 +0200 (CEST)
In-Reply-To: <alpine.LNX.2.00.1310071920480.1353@anubis>
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
Cc: Takashi Iwai <tiwai@suse.de>, Nikolay Martynov <mar.kolya@gmail.com>, alsa-devel@alsa-project.org, Daniel Mack <zonque@gmail.com>
List-Id: alsa-devel@alsa-project.org

Eldad Zack wrote:
> On Mon, 7 Oct 2013, Takashi Iwai wrote:
>> Eldad Zack wrote:
>>> On some devices, if the endpoint for the other direction is in use,
>>> setting one interface will shutdown the other (in use) endpoint.
>>> This patch moves all of the alternate setting operations for pcm
>>> ops to one function which checks if we can do so.
>>>
>>> If current alternate is 0, it is safe to set.
>>
>> Is this check needed for all devices?
>
> I'm not sure, I only have this one device to test with.

In theory, interfaces are independent, but in practice, the firmware
does whatever it does.  For implicit feedback devices, it's likely that
they were expected to be used in full duplex mode only.


Regards,
Clemens
