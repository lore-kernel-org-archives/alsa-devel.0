From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: [PATCH - alsa-lib 1/1] Fix for
	snd_seq_parse_address()
Date: Thu, 22 Apr 2010 16:10:26 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1004221610010.16336@eeebox2.perex-int.cz>
References: <1271943740-26817-1-git-send-email-pedro.lopez.cabanillas@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (unknown [212.20.107.53])
	by alsa0.perex.cz (Postfix) with ESMTP id 368451038A1
	for <alsa-devel@alsa-project.org>;
	Thu, 22 Apr 2010 16:10:27 +0200 (CEST)
In-Reply-To: <1271943740-26817-1-git-send-email-pedro.lopez.cabanillas@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Pedro Lopez-Cabanillas <pedro.lopez.cabanillas@gmail.com>
Cc: ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Thu, 22 Apr 2010, pedro.lopez.cabanillas@gmail.com wrote:

> From: Pedro Lopez-Cabanillas <pedro.lopez.cabanillas@gmail.com>
>
> snd_seq_parse_address() uses strncmp() to compare the client name in the 
> string argument with the existing clients, until it finds one name 
> matching the same leading characters. This may produce wrong results 
> when there are two sequencer clients with similar names. For instance, 
> the following procedure produces a wrong result:

Applied to the alsa-lib repo. Thanks.

 					Jaroslav

-----
Jaroslav Kysela <perex@perex.cz>
Linux Kernel Sound Maintainer
ALSA Project, Red Hat, Inc.
