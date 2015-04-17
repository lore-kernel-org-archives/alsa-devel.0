From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Support for Synchronous Audio
Date: Fri, 17 Apr 2015 11:07:58 +0200
Message-ID: <5530CD6E.4080408@ladisch.de>
References: <1429258074046.61439@librewireless.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from dehamd003.servertools24.de (dehamd003.servertools24.de
 [31.47.254.18]) by alsa0.perex.cz (Postfix) with ESMTP id 0F2EE260537
 for <alsa-devel@alsa-project.org>; Fri, 17 Apr 2015 11:07:59 +0200 (CEST)
In-Reply-To: <1429258074046.61439@librewireless.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Anoop Rajan <anoop@librewireless.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Anoop Rajan wrote:
> We have requirements to play synchronous multi-room audio with very
> minimal node to node latency(<100 us). [...] Though I make sure that
> I start the PCM  from user layer synchronously

How?  With snd_pcm_link()?

What hardware are you using?


Regards,
Clemens
