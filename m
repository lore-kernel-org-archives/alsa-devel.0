From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: Re: [PATCH 4/4] ASoC: TWL4030: Add pre-DAC digital mux
	controls
Date: Mon, 1 Dec 2008 14:09:40 +0200
Message-ID: <200812011409.40695.peter.ujfalusi@nokia.com>
References: <1228118628-22856-1-git-send-email-peter.ujfalusi@nokia.com>
	<1228118628-22856-5-git-send-email-peter.ujfalusi@nokia.com>
	<20081201114348.GD13758@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx09.nokia.com (smtp.nokia.com [192.100.105.134])
	by alsa0.perex.cz (Postfix) with ESMTP id 2BD5024460
	for <alsa-devel@alsa-project.org>; Mon,  1 Dec 2008 13:10:55 +0100 (CET)
In-Reply-To: <20081201114348.GD13758@sirena.org.uk>
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ext Mark Brown <broonie@sirena.org.uk>
Cc: sakoman@gmail.com, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hello Mark,

On Monday 01 December 2008 13:43:48 ext Mark Brown wrote:
> On Mon, Dec 01, 2008 at 10:03:48AM +0200, Peter Ujfalusi wrote:
> =

> > Controls for selecting the digital inputs for the four
> > DAC.
> =

> How often is this feature used at the minute?  While I've got no problem
> with the code per se there's currently no framework in ASoC for handling
> digital routing which means that having the flexibility creates problems
> with DAPM (which isn't implemented yet for this codec).  There's no real
> issue merging it, but it might make life easier to leave it for now.

Well, I'm not sure how often this can be used. I was reading the wm* codec
drivers as you suggested a while ago. Those also implement the digital rout=
ing
outside of DAPM. So I thought why not.
Most of the times these routings are static, so one can set these from the =
actual
board file, it is kind of hackish, but could do it:
codec->write(codec, TWL4030_REG_RX_PATH_SEL, _something_);
I don't see to much harm on having it as runtime configurable. As I said I =
think
it is good to have 'full control' over things.

About the DAPM things:
Now I'm in the process of adding the DAPM mappings for TWL (the Earpiece ou=
t now works with DAPM).
Altrough there are some obstacles on the road, but slowly and steadily I'm =
getting there.

One more thing: I have asked around the availability of technical documenta=
tion for TWL.
My copy has the big sign: Sigend NDA is required for Distribution...
But, the TPS65950 (also from TI) has the very same audio block as the TWL a=
nd the TRM is
publically available here:
http://focus.ti.com/docs/prod/folders/print/tps65950.html

> Implementing digial routing support is on my radar but it's firmly below
> the V2 merge.
> =


You obviously know about ASoCv2... Do you have some pointers on what is com=
ing and when?

-- =

P=E9ter
