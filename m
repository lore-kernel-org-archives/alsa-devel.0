From: Arun Raghavan <arun.raghavan@collabora.co.uk>
Subject: Re: How to pair Wine with ALSA? part1: intro &
 underruns (long)
Date: Wed, 17 Aug 2011 08:55:45 +0530
Message-ID: <1313551557.533.14.camel@snowflake>
References: <8E4C156DA5797D418DBFADFD8CE655A4138FB471F5@HE113481.emea1.cds.t-internal.com>
	<4E47BE17.1000205@ladisch.de>
	<8E4C156DA5797D418DBFADFD8CE655A41392BAD314@HE113481.emea1.cds.t-internal.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [93.93.128.226])
	by alsa0.perex.cz (Postfix) with ESMTP id 24AD11038A5
	for <alsa-devel@alsa-project.org>;
	Wed, 17 Aug 2011 05:24:49 +0200 (CEST)
In-Reply-To: <8E4C156DA5797D418DBFADFD8CE655A41392BAD314@HE113481.emea1.cds.t-internal.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Joerg-Cyril.Hoehle@t-systems.com
Cc: alsa-devel@alsa-project.org, clemens@ladisch.de
List-Id: alsa-devel@alsa-project.org

On Mon, 2011-08-15 at 17:50 +0200, Joerg-Cyril.Hoehle@t-systems.com
wrote:
[...]
> >I would be tempted to just ignore the exclusive/share flag.
> The flag is MS' view on it.  I never would think about using O_EXCL on
> the host OS side.

FWIW, the passthrough support that's in PulseAudio git master should
correspond to what exclusive mode does.

-- Arun
