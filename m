From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: GPL/LGPL licensing of the Alsa library
Date: Mon, 28 Mar 2011 10:49:31 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1103281046120.4805@eeebox2.perex-int.cz>
References: <5B9D7D28-C10D-42D5-9BB1-675103BC0957@neolex.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (unknown [212.20.107.53])
	by alsa0.perex.cz (Postfix) with ESMTP id E236F10382C
	for <alsa-devel@alsa-project.org>;
	Mon, 28 Mar 2011 10:49:32 +0200 (CEST)
In-Reply-To: <5B9D7D28-C10D-42D5-9BB1-675103BC0957@neolex.fi>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Ossi Niiranen <oniiranen@neolex.fi>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Mon, 28 Mar 2011, Ossi Niiranen wrote:

> Hi,
>
> We recently performed a licensing audit of a larger software project 
> incorporating the Alsa library 1.0.19. One issue we identified was that 
> although the Alsa library purported to state that the library was 
> licensed under the LGPL, there were still several files with third party 
> copyright holders that indicated in their header that the file in 
> question was licensed under the GPL.

Please, show us the list of files with different licenses to check.
I found test files and aserver (which is not probably used widely and the 
code is optional) as GPL. The library itself (.a and .so binaries) should 
follow LGPL.

 					Jaroslav

-----
Jaroslav Kysela <perex@perex.cz>
Linux Kernel Sound Maintainer
ALSA Project, Red Hat, Inc.
