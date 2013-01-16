From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: No dmix/dsnoop on Intel ICH4/5 by default?
Date: Wed, 16 Jan 2013 21:52:34 +0100
Message-ID: <50F71312.1000009@ladisch.de>
References: <50F6FF00.7020706@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com
 [66.111.4.29]) by alsa0.perex.cz (Postfix) with ESMTP id 7BB6C264FBA
 for <alsa-devel@alsa-project.org>; Wed, 16 Jan 2013 21:53:29 +0100 (CET)
In-Reply-To: <50F6FF00.7020706@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Rene Herman <rene.herman@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Rene Herman wrote:
> I'm out of touch of with alsa -- but should dmix/dsnoop still be enabled by default on hardware that doesn't do hardware mixing?

Yes.

> I believe that it should be from /usr/share/alsa/cards/ICH4.conf, but I don't get mixing on this setup when using the "default" pcm...

What's the output of "aplay -v something.wav"?


Regards,
Clemens
