From: "Ujfalusi, Peter" <peter.ujfalusi@ti.com>
Subject: Re: [RFC 05/12] ASoC: twl6040: Simplify custom
	put_volsw callback
Date: Tue, 4 Oct 2011 19:34:25 +0300
Message-ID: <CAPo=G1zUoF0pBErf1s_Z8CHC3n4ckOrQBH0G2gJ=ZPDNr81rbg@mail.gmail.com>
References: <1317728389-22062-1-git-send-email-peter.ujfalusi@ti.com>
	<1317728389-22062-6-git-send-email-peter.ujfalusi@ti.com>
	<20111004152559.GL6934@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na3sys009aog110.obsmtp.com (na3sys009aog110.obsmtp.com
	[74.125.149.203])
	by alsa0.perex.cz (Postfix) with ESMTP id 7A0DD10388B
	for <alsa-devel@alsa-project.org>;
	Tue,  4 Oct 2011 18:34:34 +0200 (CEST)
Received: by mail-yx0-f169.google.com with SMTP id 19so806901yxi.0
	for <alsa-devel@alsa-project.org>; Tue, 04 Oct 2011 09:34:25 -0700 (PDT)
In-Reply-To: <20111004152559.GL6934@opensource.wolfsonmicro.com>
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
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

On Tue, Oct 4, 2011 at 6:26 PM, Mark Brown
<broonie@opensource.wolfsonmicro.com> wrote:
> On Tue, Oct 04, 2011 at 02:39:42PM +0300, Peter Ujfalusi wrote:
>> Return -EINVAL in the unlikely event, if the function has been called
>> for unhandled control. This way we can remove one check in the code.
>>
>> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
>
> I'll apply this but as with the discussion with the Maxim devices the
> other day it'd be better if there were some sort of loud warning if we
> ever hit the error case as it means that the CODEC driver is disagreeing
> with itself.

Agreed, I'll put dev_err for the error cases.

-- =

P=E9ter
