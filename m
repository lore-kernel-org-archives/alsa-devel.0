From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: [RFC][PATCH 00/15 v4] OXFW driver,
	a succesor to	firewire-speakers
Date: Tue, 12 Aug 2014 09:09:54 +0200
Message-ID: <53E9BDC2.3000801@ladisch.de>
References: <1399991272-5807-1-git-send-email-o-takashi@sakamocchi.jp>
 <53E795BD.1070100@ladisch.de> <53E957EA.3030601@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from dehamd003.servertools24.de (dehamd003.servertools24.de
 [31.47.254.18]) by alsa0.perex.cz (Postfix) with ESMTP id 62CE4261AAF
 for <alsa-devel@alsa-project.org>; Tue, 12 Aug 2014 09:09:56 +0200 (CEST)
In-Reply-To: <53E957EA.3030601@sakamocchi.jp>
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
Cc: alsa-devel@alsa-project.org, stefanr@s5r6.in-berlin.de, fenlason@redhat.com, ffado-devel@lists.sf.net, linux1394-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Takashi Sakamoto wrote:
> On Aug 11 2014 00:54, Clemens Ladisch wrote:
>> The old driver configured nothing but the rate.  Is there any mechanism
>> to set the stream format?
>
> Yes. It's AV/C stream format information command.
> [...]
> But in this series of patches, I don't use this command. I expected the
> models to change stream format according to parameters in AMDTP packets
> such like the value of dbs field.

Apparently, the firmware doesn't support automatic format detection
completely, and requires this command for the 2ch 32/44.1 kHz modes.

(That 2ch at 96 kHz actually works is even more curious.  There already
is that bug regarding listing the seventh format; it's possible that
they completely forgot to report an eighth format.)


Regards,
Clemens
