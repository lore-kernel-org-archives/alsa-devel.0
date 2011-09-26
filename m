From: "Ujfalusi, Peter" <peter.ujfalusi@ti.com>
Subject: Re: [PATCH 05/10] ASoC: twl6040: One workqueue should
	be enough
Date: Mon, 26 Sep 2011 20:20:11 +0300
Message-ID: <CAPo=G1yaVVosP=KxH07akYzCuLF6hxP3YGqF0AfH4kHC0bNetw@mail.gmail.com>
References: <1317043593-27202-1-git-send-email-peter.ujfalusi@ti.com>
	<1317043593-27202-6-git-send-email-peter.ujfalusi@ti.com>
	<20110926144114.GM2946@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na3sys009aog117.obsmtp.com (na3sys009aog117.obsmtp.com
	[74.125.149.242])
	by alsa0.perex.cz (Postfix) with ESMTP id 81B31243DC
	for <alsa-devel@alsa-project.org>;
	Mon, 26 Sep 2011 19:20:13 +0200 (CEST)
Received: by mail-yx0-f175.google.com with SMTP id 17so5565230yxj.6
	for <alsa-devel@alsa-project.org>; Mon, 26 Sep 2011 10:20:11 -0700 (PDT)
In-Reply-To: <20110926144114.GM2946@opensource.wolfsonmicro.com>
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

On Mon, Sep 26, 2011 at 5:41 PM, Mark Brown
<broonie@opensource.wolfsonmicro.com> wrote:
> Do we even need specific workqueues at all or can we use the system
> workqueue? =A0Looks OK though.

For the jack detection we might be OK with the system workqueue,
if we got delayed by few tens of ms it does not hurt that much (well
the handover
from earpiece/IHF to headset might take longer).
For the ramp code execution we should avoid any delay at all costs, since i=
t can
have audible side effects.
In my past experience the system wq can cause latency, since we usually have
slow devices on it (GPS, proximity sensor, magnetometer, etc).
Reading from those usually takes considerable amount of time, and
we can end up with delayed execution of our ramp code.

As of it now, I would keep the separate wq, and revisit later after I can g=
et
tests running on a 'full' device.

-- =

P=E9ter
