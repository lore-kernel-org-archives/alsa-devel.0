From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: [PATCH 1/2] aplay: Show usage if no parameter is
 passed
Date: Mon, 12 Nov 2012 23:04:41 +0100
Message-ID: <50A17279.4020809@ladisch.de>
References: <1352743353-7568-1-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <1352743353-7568-1-git-send-email-festevam@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Fabio Estevam <festevam@gmail.com>
Cc: Fabio Estevam <fabio.estevam@freescale.com>, alsa-devel@alsa-project.org, patch@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Fabio Estevam wrote:
> When aplay/arecord are called without any argument the application hangs forever.
>
> Instead of hanging, print the usage and exit.
>
> +	if (argc == 1) {
> +		usage(command);
> +		return 0;
> +	}

It's possible to call it with "aplay < somefile".
Better add a check like isatty(fileno(stdin)).


Regards,
Clemens
