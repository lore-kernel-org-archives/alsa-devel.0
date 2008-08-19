From: Rene Herman <rene.herman@keyaccess.nl>
Subject: Re: [PATCH] opl3sa2: replace nd_opl3sa2_info_xxx()
	with snd_wss_info_xxx()
Date: Tue, 19 Aug 2008 22:44:04 +0200
Message-ID: <48AB3094.5020806@keyaccess.nl>
References: <20080819215149.ee9ff50e.krzysztof.h1@poczta.fm>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtpq1.tilbu1.nb.home.nl (smtpq1.tilbu1.nb.home.nl
	[213.51.146.200])
	by alsa0.perex.cz (Postfix) with ESMTP id 24ED82417E
	for <alsa-devel@alsa-project.org>;
	Tue, 19 Aug 2008 22:43:00 +0200 (CEST)
In-Reply-To: <20080819215149.ee9ff50e.krzysztof.h1@poczta.fm>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Krzysztof Helt <krzysztof.h1@poczta.fm>
Cc: Alsa-devel <alsa-devel@alsa-project.org>, Rene Herman <rene.herman@gmail.com>
List-Id: alsa-devel@alsa-project.org

On 19-08-08 21:51, Krzysztof Helt wrote:

> From: Krzysztof Helt <krzysztof.h1@wp.pl>
> 
> Replace snd_opl3sa2_info_xxx() with snd_wss_info_xxx().
> Drop check of card->private_data which cannot be NULL
> if card is not NULL (spotted by Rene Herman).
> 
> Signed-off-by: Krzysztof Helt <krzysztof.h1@wp.pl>

Reviewed-by: Rene Herman <rene.herman@gmail.com>

Rene.
