From: Ricard Wanderlof <ricard.wanderlof@axis.com>
Subject: Re: Softvol only after device has opened
Date: Tue, 9 Jun 2015 14:19:18 +0200
Message-ID: <alpine.DEB.2.02.1506091416530.15001@lnxricardw1.se.axis.com>
References: <alpine.DEB.2.02.1506091304020.15001@lnxricardw1.se.axis.com>
 <5576D38C.4030907@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bastet.se.axis.com (bastet.se.axis.com [195.60.68.11])
 by alsa0.perex.cz (Postfix) with ESMTP id C94A126528B
 for <alsa-devel@alsa-project.org>; Tue,  9 Jun 2015 14:19:19 +0200 (CEST)
In-Reply-To: <5576D38C.4030907@ladisch.de>
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
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org


On Tue, 9 Jun 2015, Clemens Ladisch wrote:

> Ricard Wanderlof wrote:
> > One thing though, the 'softvol' plugin very correctly creates a mixer
> > control and it all works fine, but only after the device has been opene=
d.
> > Before that the mixer control doesn't seem to exist, which means that we
> > cannot adjust the gain until the device is opened by some application.
> =

> Before a device using a plugin is opened, no code from that plugin is
> run.
> =

> Anyway, softvol mixer controls can be saved and restored with the usual
> "alsactl store" and "alsactl restore" mechanism.  If you do not want to
> save all mixer controls, or if your system does not have nonvolatile
> storage, create a file containing only that control and tell alsactl to
> restore from it.

Can "alsactl restore" be run before the device is opened then?

/Ricard
-- =

Ricard Wolf Wanderl=F6f                           ricardw(at)axis.com
Axis Communications AB, Lund, Sweden            www.axis.com
Phone +46 46 272 2016                           Fax +46 46 13 61 30
