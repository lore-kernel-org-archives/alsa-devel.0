From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: newbie, arecord
Date: Mon, 28 Jun 2010 20:06:37 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1006282004430.15497@eeebox2.perex-int.cz>
References: <AANLkTiko21FyDgoTz2lPx-DtVsT48sXXCFzUkJ4RackM@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (unknown [212.20.107.53])
	by alsa0.perex.cz (Postfix) with ESMTP id 7C2CD24397
	for <alsa-devel@alsa-project.org>;
	Mon, 28 Jun 2010 20:06:38 +0200 (CEST)
In-Reply-To: <AANLkTiko21FyDgoTz2lPx-DtVsT48sXXCFzUkJ4RackM@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: javi perez <havingfunwithjavi@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Mon, 28 Jun 2010, javi perez wrote:

> I am trying to do a speech recognition system. In the aplay file I would
> like to conver the unsigned char buffer
> to a float buffer to be able to make comparisons the way I would like. The
> floats that I am getting after the conversion are these.
> How should I do the conversion from unsigned char to float array? thanks in
> advance.

Study more C language. Hint: Forget memcpy and use the standard for loop 
to copy unsigned char samples to float array.

 						Jaroslav

-----
Jaroslav Kysela <perex@perex.cz>
Linux Kernel Sound Maintainer
ALSA Project, Red Hat, Inc.
