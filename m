From: Philip Chu <Philip.Chu@logicpd.com>
Subject: Re: Why is SND_PCM_FORMAT_S32_LE not able to be set
 and passed to Linux Kernel Asoc?
Date: Tue, 28 Dec 2010 01:35:46 -0600
Message-ID: <0520A3FE5EDCF24F88B3F1451CFC64AE02338750F0@EDPREX01.logicpd.com>
References: <0520A3FE5EDCF24F88B3F1451CFC64AE02338750EF@EDPREX01.logicpd.com>
	<AANLkTimE_qnG2Y7Z16qgQbc+N9H7SmNOGmXUUsvyhBgZ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from barracuda.logicpd.com (unknown [174.46.170.145])
	by alsa0.perex.cz (Postfix) with ESMTP id 3E722103869
	for <alsa-devel@alsa-project.org>; Tue, 28 Dec 2010 08:35:48 +0100 (CET)
In-Reply-To: <AANLkTimE_qnG2Y7Z16qgQbc+N9H7SmNOGmXUUsvyhBgZ@mail.gmail.com>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jassi Brar <jassisinghbrar@gmail.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Thanks for your reply.

Yes I am using plughw - "plughw:0,0" and OMAP3530 Torpedo board. And I am attaching my own sound card driver on McBSP 3.

Philip

-----Original Message-----
From: Jassi Brar [mailto:jassisinghbrar@gmail.com] 
Sent: Tuesday, December 28, 2010 2:31 AM
To: Philip Chu
Cc: alsa-devel@alsa-project.org
Subject: Re: [alsa-devel] Why is SND_PCM_FORMAT_S32_LE not able to be set and passed to Linux Kernel Asoc?

On Tue, Dec 28, 2010 at 4:20 PM, Philip Chu <Philip.Chu@logicpd.com> wrote:
> Hi all ALSA experts,
>
> I am seeing a weird behavior of ALSA API lib 1.0.23, i.e., when I use SND_PCM_FORMAT_S32_LE, I am seeing that the data format is still configured as SND_PCM_FORMAT_S16_LE and passed to kernel driver layer.

Perhaps your hardware doesn't support S32_LE, and your application
uses 'plughw' ?
