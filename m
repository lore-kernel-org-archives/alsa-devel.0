From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: Audio codec volume control
Date: Thu, 20 Sep 2012 12:58:30 +0300
Message-ID: <505AE8C6.3040001@ti.com>
References: <505ACC37.3060209@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na3sys009aog116.obsmtp.com (na3sys009aog116.obsmtp.com
 [74.125.149.240])
 by alsa0.perex.cz (Postfix) with ESMTP id 869512652B4
 for <alsa-devel@alsa-project.org>; Thu, 20 Sep 2012 11:57:37 +0200 (CEST)
Received: by obbeh20 with SMTP id eh20so1851705obb.38
 for <alsa-devel@alsa-project.org>; Thu, 20 Sep 2012 02:57:35 -0700 (PDT)
In-Reply-To: <505ACC37.3060209@st.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Rajeev kumar <rajeev-dlh.kumar@st.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

On 09/20/2012 10:56 AM, Rajeev kumar wrote:
> Hello Mark,
> =

> We have three volume control in audio codec.
> 1. Master volume: control both left and right channel volume
> 2. left volume: control left channel vol
> 3. right volume: control right channel vol.
> =

> So we can provide interfaces for all volume control to the user. Please
> find below the control I can provide to the user space
> =

> case 1:
> 1. Provide master volume control
> 2. Provide Left channel volume control.
> 3. Provide Right channel volume control.
> =

> case 2:
> =

> 1. Provide master volume control
> 2. Instead of providing separate control for left and right channel,
> combined it and provide a single control to user space. so that left and =
right
> volume is always in sync.

case 3:
1. Provide master volume control
2. stereo volume control for the left/right channel

-- =

P=E9ter
