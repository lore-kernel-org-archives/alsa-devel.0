From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Can't connect to MIDI output of Edirol UA-1000
Date: Thu, 15 Nov 2012 15:14:16 +0100
Message-ID: <50A4F8B8.5060704@ladisch.de>
References: <50587F96.8080005@googlemail.com> <505883EA.6070808@ladisch.de>
 <5058898C.6020608@googlemail.com> <50588FE8.4070206@googlemail.com>
 <50A4EB06.1030404@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com
 [66.111.4.29]) by alsa0.perex.cz (Postfix) with ESMTP id A2BCB2615E1
 for <alsa-devel@alsa-project.org>; Thu, 15 Nov 2012 15:14:19 +0100 (CET)
In-Reply-To: <50A4EB06.1030404@googlemail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Colin Fletcher <colin.m.fletcher@googlemail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Colin Fletcher wrote:
> With kernel 2.6.38.8, aconnect can connect to the MIDI out of my
> UA-1000; with 2.6.39, it fails, so it seems likely that it is the same
> bug.

It's the same bug, caused by this patch: http://git.kernel.org/linus/88a8516a2128

Fix coming soon.


Regards,
Clemens
