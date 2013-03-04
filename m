From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: [PATCH] ALSA: usb: Work around CM6631 sample rate
 change bug
Date: Mon, 04 Mar 2013 11:31:59 +0100
Message-ID: <5134781F.4050607@ladisch.de>
References: <20130302130403.GD4452@pvv.ntnu.no> <5131FAC1.30007@gmail.com>
 <20130303192922.GE4452@pvv.ntnu.no> <s5hlia3ilzx.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com
 [66.111.4.25]) by alsa0.perex.cz (Postfix) with ESMTP id 2CAAC264FF3
 for <alsa-devel@alsa-project.org>; Mon,  4 Mar 2013 11:32:03 +0100 (CET)
In-Reply-To: <s5hlia3ilzx.wl%tiwai@suse.de>
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
Cc: Torstein Hegge <hegge@resisty.net>, alsa-devel@alsa-project.org, Daniel Mack <zonque@gmail.com>
List-Id: alsa-devel@alsa-project.org

Takashi Iwai wrote:
> Torstein Hegge wrote:
>> On Sat, Mar 02, 2013 at 02:12:33PM +0100, Daniel Mack wrote:
>>> On 02.03.2013 14:04, Torstein Hegge wrote:
>>>> The C-Media CM6631 USB-to-S/PDIF receiver doesn't respond to changes in
>>>> sampling frequency while the interface is active.

>>>> +	case USB_ID(0x0d8c, 0x0304): /* C-Media - Schiit USB Interface */
>>>> +	case USB_ID(0x0d8c, 0x0309): /* C-Media CM6631 */

There are other CM6631-based devices.

> If the reset of interface is needed only when *changing* SRC, we can
> check the current rate against the previous rate and skip the reset?

Or, if we want to be more similar to what many Windows drivers do, reset
the interface to altsetting zero before setting it again.


Regards,
Clemens
