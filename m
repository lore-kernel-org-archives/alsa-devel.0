From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: basic question regarding copy unctions
Date: Thu, 29 May 2008 14:07:08 +0200 (CEST)
Message-ID: <Pine.LNX.4.61.0805291406200.1798@tm8103-a.perex-int.cz>
References: <827ad74d0805290458p4944c3f5x35a2d95c75be5a52@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (unknown [212.20.107.53])
	by alsa0.perex.cz (Postfix) with ESMTP id 018122487C
	for <alsa-devel@alsa-project.org>;
	Thu, 29 May 2008 14:07:09 +0200 (CEST)
In-Reply-To: <827ad74d0805290458p4944c3f5x35a2d95c75be5a52@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Harsha priya gupta <harshapriya@gmail.com>
Cc: Alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Thu, 29 May 2008, Harsha priya gupta wrote:

> Hi,
> I have implemented copy function to send the buffer directly to the
> hardware. But i dont see the player playing after it sends the first buffer
> down. It does not seem to be sending more buffer. Can anyone tell me where I
> am going wrong?

You have to call snd_period_elapsed() when period is played.

					Jaroslav

-----
Jaroslav Kysela <perex@perex.cz>
Linux Kernel Sound Maintainer
ALSA Project, Red Hat, Inc.
