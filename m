From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: USB Audio initialization race
Date: Sat, 14 Sep 2013 21:33:14 +0200
Message-ID: <5234B9FA.2020806@ladisch.de>
References: <Pine.LNX.4.44L0.1309140939540.30219-100000@netrider.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com
 [66.111.4.27]) by alsa0.perex.cz (Postfix) with ESMTP id E13CC2619DE
 for <alsa-devel@alsa-project.org>; Sat, 14 Sep 2013 21:33:59 +0200 (CEST)
In-Reply-To: <Pine.LNX.4.44L0.1309140939540.30219-100000@netrider.rowland.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: alsa-devel@alsa-project.org, David Henningsson <david.henningsson@canonical.com>, zonque@gmail.com
List-Id: alsa-devel@alsa-project.org

Alan Stern wrote:
> So here's my question: If the sound driver recognizes that interface B
> is connected with interface A when B is probed, why can't it recognize
> this fact when A is probed?  It could claim B while A's probe is
> running.  Then the sound card would be registered with the PCM
> component already in place.

The sound driver already does this.


Regards,
Clemens
