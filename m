From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: Is the mixer interface in the kernel protect
 against concurrent access?
Date: Mon, 17 Dec 2007 16:43:01 +0100 (CET)
Message-ID: <Pine.LNX.4.61.0712171641070.14817@tm8103.perex-int.cz>
References: <1197900817.1365.38.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (unknown [212.20.107.53])
	by alsa0.perex.cz (Postfix) with ESMTP id 4BCCD10388B
	for <alsa-devel@alsa-project.org>; Mon, 17 Dec 2007 16:43:02 +0100 (CET)
In-Reply-To: <1197900817.1365.38.camel@localhost.localdomain>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Hans-Christian Egtvedt <hcegtvedt@atmel.no>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Mon, 17 Dec 2007, Hans-Christian Egtvedt wrote:

> Hi,
> 
> I am solving a locking bug in the at73c213 SPI sound driver, and
> wondered if the mixer API is protected against concurrent access in
> ALSA? Or should I implement a mutex to protect my hardware against
> concurrent access?

Control r/w callbacks are protected with a semaphore - 
card->controls_rwsem . See sound/core/control.c for more details. Anyway, 
you need to protect your registers with spinlocks (if required of 
course).

					Jaroslav

-----
Jaroslav Kysela <perex@perex.cz>
Linux Kernel Sound Maintainer
ALSA Project
