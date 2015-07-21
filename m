From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: [RFC][PATCH 26/37] ALSA: firewire-tascam: add
	MMAP	support to show status and control message
Date: Tue, 21 Jul 2015 16:06:52 +0200
Message-ID: <55AE51FC.3020204@ladisch.de>
References: <1436623968-10780-1-git-send-email-o-takashi@sakamocchi.jp>
 <1436623968-10780-27-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from dehamd003.servertools24.de (dehamd003.servertools24.de
 [31.47.254.18]) by alsa0.perex.cz (Postfix) with ESMTP id EB6D2264EFA
 for <alsa-devel@alsa-project.org>; Tue, 21 Jul 2015 16:06:53 +0200 (CEST)
In-Reply-To: <1436623968-10780-27-git-send-email-o-takashi@sakamocchi.jp>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Cc: Yoshifuji Hideaki <yoshfuji@linux-ipv6.org>, alsa-devel@alsa-project.org, ffado-devel@lists.sf.net
List-Id: alsa-devel@alsa-project.org

Takashi Sakamoto wrote:
> Typically, such messages should be converted to MIDI control change
> messages for userspace applications.

It would be possible to have ALSA mixer controls for these, but this
would make sense only if these controls are suitable to be displayed in
a generic mixer application.  I guess this isn't the case for most of
them.

> Thus, this driver should have a converter with appropriate MIDI map.
> Currently I have no good idea for the map and it is not implemented
> yet.

I guess the Windows driver does not makes this information available in
any way?

If all the data is device-specific, the actual mapping chosen does not
really matter, because the mixer/control application needs to have
special code for parsing the data from this particular Linux driver
anyway.


Regards,
Clemens
