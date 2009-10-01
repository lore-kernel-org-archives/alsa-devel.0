From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [PATCH] ascenario: Add scenario support to alsa-lib
Date: Thu, 01 Oct 2009 14:54:00 +0100
Message-ID: <1254405240.5847.227.camel@odin>
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
Received: from mail-ew0-f209.google.com (mail-ew0-f209.google.com
	[209.85.219.209])
	by alsa0.perex.cz (Postfix) with ESMTP id 3C9ED10396A
	for <alsa-devel@alsa-project.org>;
	Thu,  1 Oct 2009 15:54:08 +0200 (CEST)
Received: by ewy5 with SMTP id 5so181508ewy.12
	for <alsa-devel@alsa-project.org>; Thu, 01 Oct 2009 06:54:07 -0700 (PDT)
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
Cc: Stefan Schmidt <stefan@slimlogic.co.uk>, Mark Brown <broonie@opensource.wolfsonmicro.com>, alsa-devel@alsa-project.org, Ian Molton <ian@mnementh.co.uk>, Graeme Gregory <gg@slimlogic.co.uk>, Stefan Schmidt <stefan@datenfreihafen.org>
List-Id: alsa-devel@alsa-project.org

On Thu, 2009-10-01 at 08:39 -0500, pl bossart wrote:
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
> 

It's only about power usage here. i.e. run CODEC with slower clocks internally, may lower SNR.

So maybe

define SND_POWER_QOS_HIFI 0

> 
> +#define SND_SCN_PHONECALL_HANDSET      "phonecall handset"
> +#define SND_SCN_PHONECALL_HEADSET      "phonecall headset"
> +#define SND_SCN_PHONECALL_BLUETOOTH    "phonecall bluetooth"
> +#define SND_SCN_PHONECALL_IP           "phonecall ip"
> 
> Same here, this is ambiguous, you can have an IP call over bluetooth.
> Which scenario would you use then?
> I guess if you want the scenarios to be used by apps in a portable
> way, a clearer definition of each scenario is probably needed?

These are ambiguous, I guess we need to have

#define SND_SCN_PHONECALL_GSM_HANDSET "phonecall gsm handset"
#define SND_SCN_PHONECALL_BT_HANDSET "phonecall bt handset"
#define SND_SCN_PHONECALL_IP_HANDSET "phonecall ip handset"

For gsm, bluetooth and VOIP handset phone calls respectively.

Thanks

Liam
