From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: Add Jassi Brar as Samsung maintainer
Date: Sun, 26 Sep 2010 17:20:00 -0700
Message-ID: <20100927001959.GB10638@opensource.wolfsonmicro.com>
References: <1285402601-10131-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<AANLkTik5q1B9B5V0rUHVfAXPHe7vWbxJm3dK_A6QfTJ=@mail.gmail.com>
	<AANLkTi=xEwPGsf756EG3c4sC5F4mDevoXwcMtSYnrXt_@mail.gmail.com>
	<AANLkTimf1BmDe0pPqPgi0qWYG9pb2tZVgvLQ4VVEh6K5@mail.gmail.com>
	<AANLkTimvdZP3pjYv56+AXGy5d7ceb+q1=NomH3fr1isC@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id E807924607
	for <alsa-devel@alsa-project.org>;
	Mon, 27 Sep 2010 02:19:42 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <AANLkTimvdZP3pjYv56+AXGy5d7ceb+q1=NomH3fr1isC@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Kyungmin Park <kmpark@infradead.org>
Cc: alsa-devel@alsa-project.org, Jassi Brar <jassisinghbrar@gmail.com>, Jassi Brar <jassi.brar@samsung.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Sun, Sep 26, 2010 at 07:49:42PM +0900, Kyungmin Park wrote:

> I'm not sure runtime PM is required for audio since ALSA control the
> codec well. but try to reduce the power as we can.

About all you can do with most CPUs is turn off the clocks within the
block when they're not needed, the runtime PM subsystem itself is
usually only useful if you've got support for power gating within the
CPU (which tends to be done over multiple blocks so they all need to go
idle before you can power them off).
