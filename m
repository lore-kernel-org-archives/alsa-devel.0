From: Stefan Schmidt <stefan@datenfreihafen.org>
Subject: Re: [PATCH] ascenario: Add scenario support to alsa-lib
Date: Thu, 1 Oct 2009 16:11:45 +0200
Message-ID: <20091001141145.GC5936@excalibur.local>
References: <1254390436-5283-1-git-send-email-stefan@datenfreihafen.org>
	<1254390436-5283-2-git-send-email-stefan@datenfreihafen.org>
	<20091001122835.GC14417@sirena.org.uk>
	<20091001131948.GA5936@excalibur.local>
	<20091001132417.GA26663@rakim.wolfsonmicro.main>
	<6160a5130910010639u11b764bfh92cfb6f6aef671c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from sirius.lasnet.de (sirius.lasnet.de [78.47.116.19])
	by alsa0.perex.cz (Postfix) with ESMTP id 8E9B510399E
	for <alsa-devel@alsa-project.org>;
	Thu,  1 Oct 2009 16:12:00 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <6160a5130910010639u11b764bfh92cfb6f6aef671c@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: pl bossart <bossart.nospam@gmail.com>
Cc: Stefan Schmidt <stefan@slimlogic.co.uk>, Mark Brown <broonie@opensource.wolfsonmicro.com>, alsa-devel@alsa-project.org, Ian Molton <ian@mnementh.co.uk>, Graeme Gregory <gg@slimlogic.co.uk>, Stefan Schmidt <stefan@datenfreihafen.org>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

Hello.

On Thu, 2009-10-01 at 08:39, pl bossart wrote:
> +/** QOS
> + *
> + * Defines Audio Quality of Service
> + */
> +#define SND_QOS_HIFI                   0
> +#define SND_QOS_VOICE                  1
> +#define SND_QOS_SYSTEM                 2
> 
> My $0.02 comment is that I don't know what QOS entails. I have no
> issue with all the other defines, but this one isn't quite clear.
> What exactly is supposed to happen if I set the QOS to voice? A lower
> SNR for voice? A lower latency for voice with a lower group delay? A
> lower oversampling ratio? An optimized routing for voice? All of the
> above?

Good point. The key is here that some systems offer lower quality audio which
also has a lower power consumption. That would save power when being on a voice
call but give you the best quality when listening to your music.

> +#define SND_SCN_PHONECALL_HANDSET      "phonecall handset"
> +#define SND_SCN_PHONECALL_HEADSET      "phonecall headset"
> +#define SND_SCN_PHONECALL_BLUETOOTH    "phonecall bluetooth"
> +#define SND_SCN_PHONECALL_IP           "phonecall ip"
> 
> Same here, this is ambiguous, you can have an IP call over bluetooth.
> Which scenario would you use then?
> I guess if you want the scenarios to be used by apps in a portable
> way, a clearer definition of each scenario is probably needed?

I removed the defines here. We don't use them and should re-think and define
them when we actually implement its users.

Thanks for your comments.

regards
Stefan Schmidt
