From: "Clemens Ladisch" <cladisch@fastmail.net>
Subject: Re: Problems while using mplayer based on ALSA
Date: Fri, 30 Nov 2007 08:38:13 +0100
Message-ID: <1196408293.2669.1224048439@webmail.messagingengine.com>
References: <BAY117-W107B2FDEF231255CEB7B9DC0710@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out1.smtp.messagingengine.com (out1.smtp.messagingengine.com
	[66.111.4.25]) by alsa0.perex.cz (Postfix) with ESMTP id B0D172455A
	for <alsa-devel@alsa-project.org>; Fri, 30 Nov 2007 08:38:14 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <BAY117-W107B2FDEF231255CEB7B9DC0710@phx.gbl>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: =?iso-8859-1?Q?=11?= <semiyd@hotmail.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

 wrote:
> Im having problems while using mplayer 1.0

1.0 isn't yet released.

> to play music based on alsa 1.0.15.
> Im using an ARM9 system and montavista linux 2.6.18.
> 
> / $ mplayer /tmp/a.wav

Please use the -v option when reporting problems.

> ...
> [AO_ALSA] alsa-lib: conf.c:2699:(snd_config_hooks_call) Cannot open shared library (null)

Does your platform support dynamic linking and versioned symbols?
How did you configure alsa-lib?


Regards,
Clemens
