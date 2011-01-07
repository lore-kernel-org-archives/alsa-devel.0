From: Jassi Brar <jassisinghbrar@gmail.com>
Subject: Re: [PATCH 1/4] ASoC: SAMSUNG: Remove AC97 header file
Date: Fri, 7 Jan 2011 15:02:29 +0900
Message-ID: <AANLkTik+SZi8_aNo96CD907ews_vur=EziT87fPKqEiX@mail.gmail.com>
References: <1294375429-16729-1-git-send-email-sw.youn@samsung.com>
	<1294375612-16776-1-git-send-email-sw.youn@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bw0-f51.google.com (mail-bw0-f51.google.com
	[209.85.214.51])
	by alsa0.perex.cz (Postfix) with ESMTP id D3CD010392C
	for <alsa-devel@alsa-project.org>; Fri,  7 Jan 2011 07:02:29 +0100 (CET)
Received: by bwz10 with SMTP id 10so10167631bwz.38
	for <alsa-devel@alsa-project.org>; Thu, 06 Jan 2011 22:02:29 -0800 (PST)
In-Reply-To: <1294375612-16776-1-git-send-email-sw.youn@samsung.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Seungwhan Youn <sw.youn@samsung.com>
Cc: alsa-devel@alsa-project.org, broonie@opensource.wolfsonmicro.com, jassi.brar@samsung.com, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

On Fri, Jan 7, 2011 at 1:46 PM, Seungwhan Youn <sw.youn@samsung.com> wrote:
> This patch moves AC97 specific definitions, they doesn't need to be shared,
> into 'ac97.c' from 'ac97.h'. This patch also remove header file, 'ac97.h',
> and remove includes on machine drivers.

Acked-by: Jassi Brar <jassi.brar@samsung.com>
