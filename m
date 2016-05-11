From: Ricard Wanderlof <ricard.wanderlof@axis.com>
Subject: Re: ADAU1761 default register value problem
Date: Wed, 11 May 2016 17:16:46 +0200
Message-ID: <alpine.DEB.2.02.1605111440510.31333@lnxricardw1.se.axis.com>
References: <alpine.DEB.2.02.1604211547540.31333@lnxricardw1.se.axis.com>
 <571F2513.1020005@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bastet.se.axis.com (bastet.se.axis.com [195.60.68.11])
 by alsa0.perex.cz (Postfix) with ESMTP id 80CDE2619FA
 for <alsa-devel@alsa-project.org>; Wed, 11 May 2016 17:16:53 +0200 (CEST)
In-Reply-To: <571F2513.1020005@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org


Hi Lars,

On Tue, 26 Apr 2016, Lars-Peter Clausen wrote:

> > A while ago I posted a question to the list regarding the default value=
s =

> > set up for the ADAU1761 (and similar CODECs), =

> > ...

Having researched this further, it appears that commit

27d6e7d1c96c9f51379e0feb972fec26029098bc

ASoC: adau17x1: Cache writes when core clock is disabled

actually fixes this problem, at least for the ADAU1361 and ADAU1761. I'm =

no expert at the regcache mechanism, but it looks as if when the regcache =

is synced when the bias level goes from OFF to STANDBY, it actually writes =

out all the values including the default ones (verified by adding trace =

printouts, and also by verifying that my original problem of the codec =

misbehaving after reconfiguration after reboot is no longer there).

Thus there is no apparent need to separately write out the default values, =

unless I have missed something (which is not unlikely...).

Sorry I missed this commit earlier, I was working with a kernel that was =

not the latest, and initially didn't think the commit would help, as I =

incorrectly assumed it wouldn't write out the default values as a result =

of a sync operation, just as it wouldn't write them out if the cache was =

enabled.

/Ricard
-- =

Ricard Wolf Wanderl=F6f                           ricardw(at)axis.com
Axis Communications AB, Lund, Sweden            www.axis.com
Phone +46 46 272 2016                           Fax +46 46 13 61 30
