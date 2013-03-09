From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: How to send non-SysEx system messages via ALSA?
Date: Sat, 09 Mar 2013 22:01:24 +0100
Message-ID: <513BA324.8090109@ladisch.de>
References: <8E4C156DA5797D418DBFADFD8CE655A422BA54AFBB@HE113481.emea1.cds.t-internal.com>
 <513B90A9.7070309@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com
 [66.111.4.25]) by alsa0.perex.cz (Postfix) with ESMTP id 99486265068
 for <alsa-devel@alsa-project.org>; Sat,  9 Mar 2013 22:02:37 +0100 (CET)
In-Reply-To: <513B90A9.7070309@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "Gabriel M. Beddingfield" <gabrbedd@gmail.com>
Cc: alsa-devel@alsa-project.org, Joerg-Cyril.Hoehle@t-systems.com
List-Id: alsa-devel@alsa-project.org

Gabriel M. Beddingfield wrote:
> Since Wine is sending/receiving midi data (without timing) that is to
> be sent/received _immediately_ -- you might find life easier by using
> the rawmidi api.

But this would work only with rawmidi devices; hardware synthesizers
(OPL3/4/Emu10k1) and any software applications would be excluded
(without contortions like snd-virmidi).


Regards,
Clemens
