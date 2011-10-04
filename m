From: Ben Gardiner <bengardiner@nanometrics.ca>
Subject: Re: [PATCH 1/3] ASoC: davinci-pcm: latch EDMA errors
Date: Mon, 3 Oct 2011 22:04:29 -0400
Message-ID: <CAPcSpELpNXazvbwEs9b-bkvP=fzSzkv944-J25Jkji=TQ_9CDg@mail.gmail.com>
References: <cover.1317417232.git.bengardiner@nanometrics.ca>
	<647c53d57c6dc6b9780f7f1ad21f39106e702566.1317417232.git.bengardiner@nanometrics.ca>
	<20111002184842.GF2857@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na3sys009aog117.obsmtp.com (na3sys009aog117.obsmtp.com
	[74.125.149.242])
	by alsa0.perex.cz (Postfix) with ESMTP id E660C24159
	for <alsa-devel@alsa-project.org>;
	Tue,  4 Oct 2011 04:04:34 +0200 (CEST)
Received: by gyd8 with SMTP id 8so19096gyd.11
	for <alsa-devel@alsa-project.org>; Mon, 03 Oct 2011 19:04:29 -0700 (PDT)
In-Reply-To: <20111002184842.GF2857@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: davinci-linux-open-source@linux.davincidsp.com, alsa-devel@alsa-project.org, Sekhar Nori <nsekhar@ti.com>, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

Hi Mark,

Thank you for offering your insights.

On Sun, Oct 2, 2011 at 2:48 PM, Mark Brown
<broonie@opensource.wolfsonmicro.com> wrote:
> On Fri, Sep 30, 2011 at 05:23:01PM -0400, Ben Gardiner wrote:
>> The davinci-pcm driver currently ignores all EDMA completion callbacks t=
hat
>> could be indicating an error.
>
>> Latch any edma error-status callbacks and report them as SNDDRV_PCM_POS_=
XRUN
>> like is done in fsl_dma.c.
>
> Nothing in this patch ever seems to clear the flag which seems rather
> extreme. =A0I'd expect that if you're going to do this then the flag would
> be cleared after one error has been reported.

Ok. I think you have impressed upon me the intent of the _POS_XRUN
retum -- i see now that it should not be latched. I will fix this in
spin 2.

>> In testing when an error occured early-on in playback the stream did not=
 halt,
>> but several underruns were reported until eventually the stream halted.
>
>> Is there a better way to report HW errors up the stack?
>
> Not really, and it's not clear that it's constructive to try - =A0if
> there's a problem that doesn't otherwise cause a failure then generally
> the user will intervene.

Again, thank you for your insight. My understanding now is that
_POS_XRUN is _the_ way to report HW errors and that it is up to the
application to determine the consequences of an xrun.

Best Regards,
Ben Gardiner

---
Nanometrics Inc.
http://www.nanometrics.ca
