From: jassi brar <jassisinghbrar@gmail.com>
Subject: Re: [PATCH 2/7] S3C AUDIO: Rename 's3c24xx-pcm' driver
	to 's3c_audio'
Date: Tue, 17 Nov 2009 08:47:49 +0900
Message-ID: <1b68c6790911161547w267fe704h39a2018b821f26c9@mail.gmail.com>
References: <1257914702-4417-1-git-send-email-jassi.brar@samsung.com>
	<20091116104658.GT23772@trinity.fluff.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pw0-f53.google.com (mail-pw0-f53.google.com
	[209.85.160.53])
	by alsa0.perex.cz (Postfix) with ESMTP id C88FA10383C
	for <alsa-devel@alsa-project.org>; Tue, 17 Nov 2009 00:47:50 +0100 (CET)
Received: by pwj11 with SMTP id 11so8078550pwj.32
	for <alsa-devel@alsa-project.org>; Mon, 16 Nov 2009 15:47:49 -0800 (PST)
In-Reply-To: <20091116104658.GT23772@trinity.fluff.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Ben Dooks <ben-linux@fluff.org>
Cc: alsa-devel@alsa-project.org, broonie@opensource.wolfsonmicro.com, Jassi Brar <jassi.brar@samsung.com>
List-Id: alsa-devel@alsa-project.org

On Mon, Nov 16, 2009 at 7:46 PM, Ben Dooks <ben-linux@fluff.org> wrote:
> On Wed, Nov 11, 2009 at 01:45:02PM +0900, Jassi Brar wrote:
>> Making room for namespace for the PCM Controller driver
>> the platform driver(s3c24xx-pcm) has been renamed to SoC
>> agnostic name 's3c-audio'.
>
> s3c-dma or s3c-audio-dma would have been a better name for this.
okay, will rename it to s3c-dma. thanks
