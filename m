From: Stefan Richter <stefanr@s5r6.in-berlin.de>
Subject: Re: [PATCH 0/5] ALSA: firewire-tascam: add MIDI
 functionality
Date: Mon, 12 Oct 2015 14:48:16 +0200
Message-ID: <20151012144816.130ac379@kant>
References: <1444644625-30189-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from einhorn.in-berlin.de (einhorn.in-berlin.de [192.109.42.8])
 by alsa0.perex.cz (Postfix) with ESMTP id 7F3BC2614C5
 for <alsa-devel@alsa-project.org>; Mon, 12 Oct 2015 14:48:18 +0200 (CEST)
In-Reply-To: <1444644625-30189-1-git-send-email-o-takashi@sakamocchi.jp>
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
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, Jonathan Woithe <jwoithe@just42.net>, clemens@ladisch.de, ffado-devel@lists.sf.net
List-Id: alsa-devel@alsa-project.org

On Oct 12 Takashi Sakamoto wrote:
> Although TASCAM FireWire series has physical controls, this patchset
> doesn't support them. I think some facilities are required to enable this
> functionality:
>  * handling MIDI messages on virtual MIDI ports by this driver
>  * handling status and control messages in isochronous packet by this
>    driver

As a side note, AFAIR, RME devices encapsulate status in their isochronous
stream too... or was it MOTU?

>  * parsing the status and control messages by userspace application
>  * supporting assignment of physical controls to MIDI ports by userspace
>    application
>  * turn on/off LEDs on device by userspace application
> 
> These work are apparently beyond my current effort.
-- 
Stefan Richter
-=====-===== =-=- -==--
http://arcgraph.de/sr/
