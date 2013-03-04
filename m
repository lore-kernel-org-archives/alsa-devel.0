From: Daniel Mack <zonque@gmail.com>
Subject: Re: [PATCH v3] davinci-mcasp: don't overwrite DIT
	settings
Date: Mon, 04 Mar 2013 11:11:38 +0100
Message-ID: <5134735A.8070004@gmail.com>
References: <1362391330-4731-1-git-send-email-yegorslists@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ea0-f182.google.com (mail-ea0-f182.google.com
 [209.85.215.182])
 by alsa0.perex.cz (Postfix) with ESMTP id B9710264F24
 for <alsa-devel@alsa-project.org>; Mon,  4 Mar 2013 11:11:43 +0100 (CET)
Received: by mail-ea0-f182.google.com with SMTP id a12so754627eaa.27
 for <alsa-devel@alsa-project.org>; Mon, 04 Mar 2013 02:11:43 -0800 (PST)
In-Reply-To: <1362391330-4731-1-git-send-email-yegorslists@googlemail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: yegorslists@googlemail.com
Cc: mporter@ti.com, alsa-devel@alsa-project.org, vaibhav.bedia@ti.com
List-Id: alsa-devel@alsa-project.org

On 04.03.2013 11:02, yegorslists@googlemail.com wrote:
> From: Yegor Yefremov <yegorslists@googlemail.com>
> 
> Channel size settings will be made at the end of
> davinci_mcasp_hw_params() routine and thus overwrite frame
> format settings made for DIT mode. This patch fixes this issue
> by taking op_mode into account. Tested with official PSP 3.2
> kernel and sii9022a HDMI transmitter.
> 
> Signed-off-by: Yegor Yefremov <yegorslists@googlemail.com>

Ah, and when resending, please make sure to prefix your subject with
"ALSA: ASoC: " ...


Daniel
