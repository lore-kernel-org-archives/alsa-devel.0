From: Ricard Wanderlof <ricard.wanderlof@axis.com>
Subject: Re: [PATCH 1/2] amidi: ignore not only Active Sensing
 but all System Real-Time messages
Date: Mon, 11 Apr 2016 09:00:55 +0200
Message-ID: <alpine.DEB.2.02.1604110858100.9999@lnxricardw1.se.axis.com>
References: <570AA980.3070802@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bastet.se.axis.com (bastet.se.axis.com [195.60.68.11])
 by alsa0.perex.cz (Postfix) with ESMTP id D4BFC26070F
 for <alsa-devel@alsa-project.org>; Mon, 11 Apr 2016 09:01:01 +0200 (CEST)
In-Reply-To: <570AA980.3070802@ladisch.de>
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
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, Martin Tarenskeen <m.tarenskeen@zonnet.nl>
List-Id: alsa-devel@alsa-project.org


On Sun, 10 Apr 2016, Clemens Ladisch wrote:

> By default, amidi ignores Active Sensing messages because they are sent
> by many devices in the background and would only interfere with the
> actual messages that amidi is supposed to capture.  However, there are
> also devices that send Clock messages with the same problem, so it is
> a better idea to filter out all System Real-Time messages.

I would argue that it would be better to have both options, somehow. I.e. =

active sensing is mostly a nuisance, but I can imagine occasions =

(analyzing the output from a sequencer perhaps) where one would want to =

keep the rest of the real time messages.

/Ricard
-- =

Ricard Wolf Wanderl=F6f                           ricardw(at)axis.com
Axis Communications AB, Lund, Sweden            www.axis.com
Phone +46 46 272 2016                           Fax +46 46 13 61 30
