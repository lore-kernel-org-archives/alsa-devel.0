From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Boundary calculation
Date: Tue, 17 Jul 2018 08:43:27 +0200
Message-ID: <834aaf57-b1d0-1a00-48f8-796add3027e0@ladisch.de>
References: <20180716192507.GA7151@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from webclient5.webclient5.de (webclient5.webclient5.de
 [136.243.32.184])
 by alsa0.perex.cz (Postfix) with ESMTP id 816C626767C
 for <alsa-devel@alsa-project.org>; Tue, 17 Jul 2018 08:43:01 +0200 (CEST)
Received: from [10.1.2.4] (unknown [94.101.37.79])
 by webclient5.webclient5.de (Postfix) with ESMTPSA id A0E5F5581A27
 for <alsa-devel@alsa-project.org>; Tue, 17 Jul 2018 08:43:00 +0200 (CEST)
In-Reply-To: <20180716192507.GA7151@localhost.localdomain>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Ricardo Biehl Pasquali wrote:
> The current calculation for boundary is:
>
> 	boundary = buffer_size;
> 	while (boundary * 2 <= LONG_MAX - buffer_size)
> 		boundary *= 2;
>
> Why isn't a simpler calculation used instead? e.g.:
>
> 	/* closest multiple of buffer size less or equal LONG_MAX */
> 	boundary = LONG_MAX - LONG_MAX % buffer_size;

To ensure that the factor is a power of two.

Originally, that was not really necessary, but the algorithm is
now part of the kernel/userspace interface.


Regards,
Clemens
