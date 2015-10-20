From: Ricard Wanderlof <ricard.wanderlof@axis.com>
Subject: Re: Getting ICS43432 MEMS mic working with TMS320DM365
 processor
Date: Tue, 20 Oct 2015 17:05:12 +0200
Message-ID: <alpine.DEB.2.02.1510201701000.4740@lnxricardw1.se.axis.com>
References: <CACaQK7C8V9G5EFoxpTaDcF38zbU=OqErsd8YksbH=0OThCbydg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bes.se.axis.com (bes.se.axis.com [195.60.68.10])
 by alsa0.perex.cz (Postfix) with ESMTP id 82C95266925
 for <alsa-devel@alsa-project.org>; Tue, 20 Oct 2015 17:05:15 +0200 (CEST)
In-Reply-To: <CACaQK7C8V9G5EFoxpTaDcF38zbU=OqErsd8YksbH=0OThCbydg@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Ankhit Vivekananda <ankhit.vivekananda@biscotti.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org


On Tue, 20 Oct 2015, Ankhit Vivekananda wrote:

> Hello,
> =

> I have configured the TM320DM365 McBSP with clock and frame synchronizati=
on
> signals. Also see the ICS43432 MIC serial data on the oscilloscope, but do
> not get the right output in my application.
> =

> I have mapped the DaVinci McBSP with the CQ0093VC audio codec driver.
> Is this mapping correct or is it necessary to map the McBSP with ICS-43432
> codec driver?
> Since, I have not applied the patch, I have used CQ0093VC codec driver.
> =

> Please do let me know if the ICS-43432 patch really necessary for the MIC
> to work.

Are you using the CQ0093VC driver to communicate with the ICS-43432, but =

no actual CQ0093VC codec then?

That won't work. The ICS-43432 basically uses 64 bits per frame, with 24 =

valid bits per channel, i.e. S24_LE or S32, whereas the CQ0093VC seems to =

only support the U8 or S16_LE formats.

There might be another codec driver which is more suitable, but it makes =

the most sense to use the ICS-43432 driver as it is intended for the =

hardware in question.

/Ricard
-- =

Ricard Wolf Wanderl=F6f                           ricardw(at)axis.com
Axis Communications AB, Lund, Sweden            www.axis.com
Phone +46 46 272 2016                           Fax +46 46 13 61 30
