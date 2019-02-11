From: Charles Keepax <ckeepax@opensource.cirrus.com>
Subject: Re: [PATCH v2] ASoC: wm8741: Set OSR mode in
	hw_params()
Date: Mon, 11 Feb 2019 16:03:23 +0000
Message-ID: <20190211160323.GF6336@imbe.wolfsonmicro.main>
References: <1549812569-17533-1-git-send-email-sergej@taudac.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com
 [67.231.149.25])
 by alsa0.perex.cz (Postfix) with ESMTP id 29950267468
 for <alsa-devel@alsa-project.org>; Mon, 11 Feb 2019 17:03:26 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1549812569-17533-1-git-send-email-sergej@taudac.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Sergej Sawazki <sergej@taudac.com>
Cc: ce3a@gmx.de, patches@opensource.cirrus.com, alsa-devel@alsa-project.org, broonie@kernel.org, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

On Sun, Feb 10, 2019 at 04:29:29PM +0100, Sergej Sawazki wrote:
> For correct operation of the digital filtering and other processing on the
> WM8741, the user must ensure the correct value of OSR[1:0] is set at all
> times.[1] Hence, depending the selected sampling rate, set the OSR (over-
> sampling rate) mode in hw_params().
> 
> References:
> 	[1] "WM8741 Data Sheet"
> 
> Signed-off-by: Sergej Sawazki <sergej@taudac.com>
> ---

Acked-by: Charles Keepax <ckeepax@opensource.cirrus.com>

Thanks,
Charles
