From: Ricard Wanderlof <ricard.wanderlof@axis.com>
Subject: Re: OPL3 on cmipci doesn't survive suspend/resume
Date: Wed, 27 May 2015 15:31:23 +0200
Message-ID: <alpine.DEB.2.02.1505271529450.22011@lnxricardw1.se.axis.com>
References: <CADN=WdrzMgQCSYA_vp0VVWm0guVWdRXyhVO7CFXXJpvQCgPfqw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bes.se.axis.com (bes.se.axis.com [195.60.68.10])
 by alsa0.perex.cz (Postfix) with ESMTP id DC966265AD5
 for <alsa-devel@alsa-project.org>; Wed, 27 May 2015 15:31:24 +0200 (CEST)
In-Reply-To: <CADN=WdrzMgQCSYA_vp0VVWm0guVWdRXyhVO7CFXXJpvQCgPfqw@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Adam Goode <adam@spicenitz.org>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org


On Wed, 27 May 2015, Adam Goode wrote:

> 05:00.0 Multimedia audio controller: C-Media Electronics Inc
> CMI8738/CMI8768 PCI Audio (rev 10)
> ...
> =

> When I suspend/resume, the sound from the OPL3 is permanently
> distorted. It sounds like not all of the operators are active. I can
> fix this by doing a full PCI remove/rescan cycle: the driver correctly
> initializes the card at this time.
> =

> Any ideas before I peek into the code?

Not really, except that it is a very old card by now. No real work has =

 been done in the driver for many years.

(I still have one around in an ancient Linux box, for its S/PDIF =

capability (for which it was very good value for money in its day).)

/Ricard
-- =

Ricard Wolf Wanderl=F6f                           ricardw(at)axis.com
Axis Communications AB, Lund, Sweden            www.axis.com
Phone +46 46 272 2016                           Fax +46 46 13 61 30
