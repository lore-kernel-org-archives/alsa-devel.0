From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: snd_dice: category ID
Date: Mon, 13 Feb 2012 22:24:31 +0100
Message-ID: <4F397F8F.5020108@ladisch.de>
References: <4F394C7C.1090007@weiss.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com
	[66.111.4.29]) by alsa0.perex.cz (Postfix) with ESMTP id 5271A103899
	for <alsa-devel@alsa-project.org>; Mon, 13 Feb 2012 22:25:10 +0100 (CET)
Received: from compute2.internal (compute2.nyi.mail.srv.osa [10.202.2.42])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id 4B94A20D9C
	for <alsa-devel@alsa-project.org>; Mon, 13 Feb 2012 16:25:07 -0500 (EST)
In-Reply-To: <4F394C7C.1090007@weiss.ch>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: rolf.anderegg@weiss.ch
Cc: Uli Franke <uli.franke@weiss.ch>, alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Rolf Anderegg wrote:
> I'd like to request the following patch to be applied on the
> firewire-kernel-streaming branch (current commit head
> 526795d69f5be6d058bdf89a65a303a1ee136aba).
> It involves handling Weiss DICE devices which use a dedicated category ID (other
> than TCAT's default Cat ID (0x04), which is not necessarily binding).
>
> Presumably, few of the other vendors have changed TCATs default Cat. ID. We have
> decided to change it to 0x00 since the beginning of our DICE product-line, alas
> this should be considered in snd-dice's dice_interface_check.

Kernel patches require a Signed-off-by tag (see Documentation/SubmittingPatches).
But I rewrote it anyway ...  :)


Regards,
Clemens
