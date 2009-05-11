From: Arun KS <getarunks@gmail.com>
Subject: Re: [PATCH 0/1] ASoC: TWL4030: Headset ramp down fix
Date: Mon, 11 May 2009 18:27:28 +0530
Message-ID: <dfeb90390905110557m79ce9a51n5b8b73e5a736d05b@mail.gmail.com>
References: <1242040465-10835-1-git-send-email-peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ti-out-0910.google.com (ti-out-0910.google.com [209.85.142.184])
	by alsa0.perex.cz (Postfix) with ESMTP id 77C4524802
	for <alsa-devel@alsa-project.org>;
	Mon, 11 May 2009 14:57:30 +0200 (CEST)
Received: by ti-out-0910.google.com with SMTP id i7so61008tid.8
	for <alsa-devel@alsa-project.org>; Mon, 11 May 2009 05:57:28 -0700 (PDT)
In-Reply-To: <1242040465-10835-1-git-send-email-peter.ujfalusi@nokia.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Cc: sakoman@gmail.com, anuj.aggarwal@ti.com, alsa-devel@alsa-project.org, broonie@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

On Mon, May 11, 2009 at 4:44 PM, Peter Ujfalusi
<peter.ujfalusi@nokia.com> wrote:
> Hello,
>
> The following patch should fix (or at least makes it less intrusive) the =
'tuck'
> phenomena on observed on the twl4030 Headset outputs when the codec is go=
ing
> to standby mode.
>
> I have debugged this with the scope and if we are not waiting RAMP_DELAY =
time,
> the VMID is cut before it reaching 0, which generates the 'tuck'.
>
> Note that I have not removed the control for the RAMP_DELAY configuration=
, the
> code will use that to calculate the needed delay (also the sysfreq is nee=
ded,
> which also stored).
> However I do think that one should not touch the RAMP_DELAY...
>
> It would be nice to hear from you guys, if it solves/softens the 'tuck'.

'Tuck' still present on omap3evm board.

>
> ---
> Peter Ujfalusi (1):
> =A0ASoC: TWL4030: Wait RAMP_DELAY on headsetl_event: POST_PMD
>
> =A0sound/soc/codecs/twl4030.c | =A0 20 ++++++++++++++++++++
> =A01 files changed, 20 insertions(+), 0 deletions(-)
>
>
