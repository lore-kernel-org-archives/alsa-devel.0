From: "Ujfalusi, Peter" <peter.ujfalusi@ti.com>
Subject: Re: [PATCH 10/10] ASoC: twl6040: Simplify code in
 out_drv_event for pending work check
Date: Mon, 26 Sep 2011 20:27:44 +0300
Message-ID: <CAPo=G1xSxDYf_JQweku3yE=VVZ8QwCvCF2NPby+LEjT2wjf1bg@mail.gmail.com>
References: <1317043593-27202-1-git-send-email-peter.ujfalusi@ti.com>
	<1317043593-27202-11-git-send-email-peter.ujfalusi@ti.com>
	<20110926143019.GL2946@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na3sys009aog118.obsmtp.com (na3sys009aog118.obsmtp.com
	[74.125.149.244])
	by alsa0.perex.cz (Postfix) with ESMTP id BD2FC24514
	for <alsa-devel@alsa-project.org>;
	Mon, 26 Sep 2011 19:27:48 +0200 (CEST)
Received: by gyd10 with SMTP id 10so5141517gyd.12
	for <alsa-devel@alsa-project.org>; Mon, 26 Sep 2011 10:27:44 -0700 (PDT)
In-Reply-To: <20110926143019.GL2946@opensource.wolfsonmicro.com>
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
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lrg@ti.com>, Misael Lopez Cruz <misael.lopez@ti.com>
List-Id: alsa-devel@alsa-project.org

Hi Mark,

On Mon, Sep 26, 2011 at 5:30 PM, Mark Brown
<broonie@opensource.wolfsonmicro.com> wrote:
> Would it not be easier to just not check at all? =A0It looks like you're
> just deciding if you should schedule the work but schedule_delayed_work
> ought to handle rescheduling of an already scheduled work item fine.

Yeah, we might not need the check.
I think we have other problems here with race conditions...
The best thing to do is to call cancel_delayed_work_sync prior we
do any modification within the twl6040_output structure.
After the cancel_delayed_work_sync, we can be sure that no work
pending, and none is executing at the moment, so we can modify
the ramp configuration, and schedule the work to do the right thing.

Thanks for bringing this to my attention, I knew something was not
right, but I have missed this.
I'll correct this in the v2 series.
BTW: the same issue applies to the wm8350 driver, I think.

-- =

P=E9ter
