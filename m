From: Rolf Anderegg <rolf.anderegg@weiss.ch>
Subject: Re: firewire-kernel-streaming branch into main kernel
 tree?
Date: Mon, 10 Jun 2013 16:51:33 +0200
Message-ID: <51B5E7F5.7040800@weiss.ch>
References: <51485940.9070908@weiss.ch> <5148777B.3010006@ladisch.de>
Reply-To: rolf.anderegg@weiss.ch
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from zhbdzmsp-mail15.bluewin.ch (zhbdzmsp-mail15.bluewin.ch
 [195.186.99.122])
 by alsa0.perex.cz (Postfix) with ESMTP id 221C9261688
 for <alsa-devel@alsa-project.org>; Mon, 10 Jun 2013 16:52:59 +0200 (CEST)
In-Reply-To: <5148777B.3010006@ladisch.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Clemens Ladisch <clemens@ladisch.de>
Cc: Brian Karr <briank@tctechnologies.tc>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org


> For those devices, merging would make sense now.  So would you be happy
> if I merged the driver in its current form, except being restricted to
> all/some(?) Weiss devices?

Our findings have shown that snd-dice works with all our DICE based Weiss
devices, as far as playback (with sync-source restricted to CLOCK_SOURCE_ARX1)
is concerned. So yes, we would be very happy with a merge of the driver's
current form.

Regards,
Rolf
