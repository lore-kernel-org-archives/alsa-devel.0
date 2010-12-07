From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: Re: [RFC v2 0/3] ASoC: Option to reorder widget power
	sequence
Date: Tue, 7 Dec 2010 11:29:15 +0200
Message-ID: <201012071129.15475.peter.ujfalusi@nokia.com>
References: <1291383073-16048-1-git-send-email-peter.ujfalusi@nokia.com>
	<20101206224008.GA2862@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-sa01.nokia.com (smtp.nokia.com [147.243.1.47])
	by alsa0.perex.cz (Postfix) with ESMTP id 9F019103842
	for <alsa-devel@alsa-project.org>; Tue,  7 Dec 2010 10:29:16 +0100 (CET)
In-Reply-To: <20101206224008.GA2862@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ext Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Tuesday 07 December 2010 00:40:08 ext Mark Brown wrote:
> On Fri, Dec 03, 2010 at 03:31:10PM +0200, Peter Ujfalusi wrote:
> > Quite some time ago I have faced similar issue with the sequence of the
> > DAPM register writes [1]
> > For that issue, I used a workaround within the twl4030 codec driver.
> > Now I have again issue with the register write sequence.
> =

> Sorry I've not got back to you yet - I want to implement the thing I was
> talking about with inserting the register update into the DAPM sequence.
> I think that is going to be easier and more generally useful, and it
> doesn't rely on drivers knowing what's going on with the DAPM sequncing
> code which is much cleaner from an abstraction point of view.

Fair enough.
I did taken a look at the possibility to do the register update between DAP=
M =

power down and up, but I thought it is a bit big change (the place, where t=
he =

DAPM power down and up happens is quite deep, and I was not sure how to inj=
ect =

things between those).

I'm no longer sure, when the register update should happen.
It might be worth doing the update at around the power enable for the widge=
t.
IN that way at least we are going to filter the power updates before the =

switch:
DAC -> PGA1 -> widget -> switch -> PGA2 -> out

If we update the register for the switch before the DAPM power up, than we =
can =

expose the switching from DAC, PGA1, widget.
If we do the update at the same time (or around), when the power for the =

switch would have been enabled, than we are filtering the switching for the =

DAPM widgets before the switch.

-- =

P=E9ter
