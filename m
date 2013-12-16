From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Noise is coming from speaker when I do aplay
Date: Mon, 16 Dec 2013 15:31:00 +0100
Message-ID: <52AF0EA4.1050607@ladisch.de>
References: <1750043993.107445.1385097675393.JavaMail.zimbra@iwavesystems.com>
 <832916567.155727.1387184088233.JavaMail.zimbra@iwavesystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com
 [66.111.4.28]) by alsa0.perex.cz (Postfix) with ESMTP id C8E3E26157F
 for <alsa-devel@alsa-project.org>; Mon, 16 Dec 2013 15:31:05 +0100 (CET)
Received: from compute6.internal (compute6.nyi.mail.srv.osa [10.202.2.46])
 by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id 36F1B20F7D
 for <alsa-devel@alsa-project.org>; Mon, 16 Dec 2013 09:31:01 -0500 (EST)
Received: from [10.1.2.65] (unknown [94.101.37.4])
 by mail.messagingengine.com (Postfix) with ESMTPA id 3873F6800B1
 for <alsa-devel@alsa-project.org>; Mon, 16 Dec 2013 09:31:01 -0500 (EST)
In-Reply-To: <832916567.155727.1387184088233.JavaMail.zimbra@iwavesystems.com>
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

ranjith vs wrote:
> While doing arecord and aplay I'm able to hear the sound. But some little bit noise is there. How can I reduce the noise.

That depends on where the noise comes from.

Try disabling playback of any analog inputs.

If that does not help, use a better power supply, or use better-designed hardware.


Regards,
Clemens
