From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: [PATCH v2 1/2] aplay: Show usage if no parameter
	is passed
Date: Tue, 13 Nov 2012 12:25:36 +0100
Message-ID: <50A22E30.1050501@ladisch.de>
References: <1352804763-6373-1-git-send-email-fabio.estevam@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <1352804763-6373-1-git-send-email-fabio.estevam@freescale.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Fabio Estevam <fabio.estevam@freescale.com>
Cc: alsa-devel@alsa-project.org, patch@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Fabio Estevam wrote:
> When aplay/arecord are called without any argument the application hangs forever.
>
> +	if (isatty(fileno(stdin)) && (argc == 1)) {

And that would be stdout for arecord. :)


Regards,
Clemens
