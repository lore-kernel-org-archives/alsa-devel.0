From: Rene Herman <rene.herman@keyaccess.nl>
Subject: Re: [PATCH 2/2] opti93x: use cs4231 lib
Date: Tue, 10 Jun 2008 01:29:16 +0200
Message-ID: <484DBCCC.5050800@keyaccess.nl>
References: <20080609230732.cb77724c.krzysztof.h1@poczta.fm>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtpq1.tilbu1.nb.home.nl (smtpq1.tilbu1.nb.home.nl
	[213.51.146.200])
	by alsa0.perex.cz (Postfix) with ESMTP id 371F324A27
	for <alsa-devel@alsa-project.org>;
	Tue, 10 Jun 2008 01:29:15 +0200 (CEST)
In-Reply-To: <20080609230732.cb77724c.krzysztof.h1@poczta.fm>
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
Cc: Alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On 09-06-08 23:07, Krzysztof Helt wrote:

> From: Krzysztof Helt <krzysztof.h1@wp.pl>
> 
> This patch converts the Opti93x driver to use
> the cs4231 library instead of duplicating the code.
> 
> Signed-off-by: Krzysztof Helt <krzysztof.h1@wp.pl>
> 
> ---
> This patch requires the patch which adds opti93x
> support to the cs4231 library. It saves few hundreds LOCs.
> 
> This patch was sent some time ago. It should work
> now on Opti93x.
> 
> The patch was prepared against the 2.6.26-rc5 kernel.
> 
> Tested on Opti 930, 931 and 933.

Tested-by: Rene Herman <rene.herman@gmail.com>

again also on 930, 931 and 933. As said, good to see this. Only quickly 
scanned the code and didn't immedately see the mixer level issue. Is the 
level difference reproducible at your end or should I investigate further?

Rene.
