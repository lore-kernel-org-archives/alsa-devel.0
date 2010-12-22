From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: [PATCH] alsa-python mixer: add poll_fds property
Date: Wed, 22 Dec 2010 08:14:09 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1012220813540.28150@eeebox2.perex-int.cz>
References: <AANLkTinG30KekgVAFLdrk=1f=-psvv8QfEXViQ-JQEeu@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (unknown [212.20.107.53])
	by alsa0.perex.cz (Postfix) with ESMTP id 6740C10383E
	for <alsa-devel@alsa-project.org>; Wed, 22 Dec 2010 08:14:10 +0100 (CET)
In-Reply-To: <AANLkTinG30KekgVAFLdrk=1f=-psvv8QfEXViQ-JQEeu@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Milan Nikolic <gen2brain@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Mon, 20 Dec 2010, Milan Nikolic wrote:

> Hi,
> this patch adds poll_fds property to pyalsa alsamixer. register_poll works
> with Python's select.poll but not with main loop of GUI toolkits. This is
> already done for hcontrol by Clemens Ladisch, patch is based on his patch.
> Other patch fixes memory leak as reported by him.

Thanks. I applied both patches to our repository.

 						Jaroslav

-----
Jaroslav Kysela <perex@perex.cz>
Linux Kernel Sound Maintainer
ALSA Project, Red Hat, Inc.
