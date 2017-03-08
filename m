From: "Austin, Brian" <Brian.Austin@cirrus.com>
Subject: Re: [PATCH 1/5] ASoC: cs35l35: Add missing return in
 probe
Date: Wed, 8 Mar 2017 19:55:36 +0000
Message-ID: <e1d91274-e6c6-4de6-abe2-44490efabeb3@EX4.ad.cirrus.com>
References: <1488991371-22513-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com
 [67.231.149.25])
 by alsa0.perex.cz (Postfix) with ESMTP id B34C7266B5E
 for <alsa-devel@alsa-project.org>; Wed,  8 Mar 2017 20:55:46 +0100 (CET)
In-Reply-To: <1488991371-22513-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Content-Language: en-US
Content-ID: <FB500D88E1DEF4428737431A8667839C@ad.cirrus.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, "broonie@kernel.org" <broonie@kernel.org>
Cc: "mark.rutland@arm.com" <mark.rutland@arm.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "patches@opensource.wolfsonmicro.com" <patches@opensource.wolfsonmicro.com>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>, "robh+dt@kernel.org" <robh+dt@kernel.org>
List-Id: alsa-devel@alsa-project.org



On 3/8/17, 10:42 AM, "alsa-devel-bounces@alsa-project.org on behalf of
Charles Keepax" <alsa-devel-bounces@alsa-project.org on behalf of
ckeepax@opensource.wolfsonmicro.com> wrote:

>A return statement is missing just before the error paths at the end of
>probe. This causes us to fall straight into the error path and disable
>the supplies and re-enable reset, as these are only controlled during
>probe this causes the part to no longer function.
>
>Signed-off-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
>---

For the series
Acked-by: Brian Austin <brian.austin@cirrus.com>
