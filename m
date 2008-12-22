From: "Arun KS" <arunks@mistralsolutions.com>
Subject: Re: [topic/asoc][PATCH 1/1] ASoC: Fix incorrect DSP
	format in OMAP McBSP DAI and affected drivers
Date: Mon, 22 Dec 2008 14:30:03 +0530
Message-ID: <dfeb90390812220100y3f7d93b7t49e298c4c46e387b@mail.gmail.com>
References: <1229934096-4715-1-git-send-email-jarkko.nikula@nokia.com>
	<1229934096-4715-2-git-send-email-jarkko.nikula@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ti-out-0910.google.com (ti-out-0910.google.com [209.85.142.187])
	by alsa0.perex.cz (Postfix) with ESMTP id 3C7571037E3
	for <alsa-devel@alsa-project.org>; Mon, 22 Dec 2008 10:00:04 +0100 (CET)
Received: by ti-out-0910.google.com with SMTP id j3so1328154tid.8
	for <alsa-devel@alsa-project.org>; Mon, 22 Dec 2008 01:00:03 -0800 (PST)
In-Reply-To: <1229934096-4715-2-git-send-email-jarkko.nikula@nokia.com>
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
To: Jarkko Nikula <jarkko.nikula@nokia.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Mon, Dec 22, 2008 at 1:51 PM, Jarkko Nikula <jarkko.nikula@nokia.com> wrote:
> - OMAP McBSP DAI driver claims to support DSP_A format which has 1-bit data
>  delay but configures link for 0-bit data delay which is in fact DSP_B
> - Fix this by changing format from DSP_A to DSP_B
> - Fix also TLV320AIC23 codec and OSK5912 machine drivers since the same
>  error is populated also there
>
> Signed-off-by: Jarkko Nikula <jarkko.nikula@nokia.com>
> Cc: Arun KS <arunks@mistralsolutions.com>

Acked-by: Arun KS <arunks@mistralsolutions.com>
