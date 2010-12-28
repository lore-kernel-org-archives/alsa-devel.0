From: Jassi Brar <jassisinghbrar@gmail.com>
Subject: Re: Why is SND_PCM_FORMAT_S32_LE not able to be set
 and passed to Linux Kernel Asoc?
Date: Tue, 28 Dec 2010 16:31:22 +0900
Message-ID: <AANLkTimE_qnG2Y7Z16qgQbc+N9H7SmNOGmXUUsvyhBgZ@mail.gmail.com>
References: <0520A3FE5EDCF24F88B3F1451CFC64AE02338750EF@EDPREX01.logicpd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bw0-f51.google.com (mail-bw0-f51.google.com
	[209.85.214.51])
	by alsa0.perex.cz (Postfix) with ESMTP id D114A103858
	for <alsa-devel@alsa-project.org>; Tue, 28 Dec 2010 08:31:22 +0100 (CET)
Received: by bwz10 with SMTP id 10so3080006bwz.38
	for <alsa-devel@alsa-project.org>; Mon, 27 Dec 2010 23:31:22 -0800 (PST)
In-Reply-To: <0520A3FE5EDCF24F88B3F1451CFC64AE02338750EF@EDPREX01.logicpd.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Philip Chu <Philip.Chu@logicpd.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Tue, Dec 28, 2010 at 4:20 PM, Philip Chu <Philip.Chu@logicpd.com> wrote:
> Hi all ALSA experts,
>
> I am seeing a weird behavior of ALSA API lib 1.0.23, i.e., when I use SND_PCM_FORMAT_S32_LE, I am seeing that the data format is still configured as SND_PCM_FORMAT_S16_LE and passed to kernel driver layer.

Perhaps your hardware doesn't support S32_LE, and your application
uses 'plughw' ?
