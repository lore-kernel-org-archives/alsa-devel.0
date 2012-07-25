From: Lauri Hintsala <lauri.hintsala@bluegiga.com>
Subject: Re: [PATCH 0/4] ASoC: fix saif record unwork issue
Date: Wed, 25 Jul 2012 11:55:01 +0300
Message-ID: <500FB465.1080707@bluegiga.com>
References: <1342776027-31758-1-git-send-email-b29396@freescale.com>
 <500E992E.6090900@bluegiga.com>
 <20120724192125.GF3099@opensource.wolfsonmicro.com>
 <500F838E.6050709@bluegiga.com>
 <20120725064440.GA30982@shlinux2.ap.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from darkblue.bluegiga.com (bluegiga.fi [194.100.31.45])
 by alsa0.perex.cz (Postfix) with ESMTP id 90CE7265DAE
 for <alsa-devel@alsa-project.org>; Wed, 25 Jul 2012 10:55:02 +0200 (CEST)
In-Reply-To: <20120725064440.GA30982@shlinux2.ap.freescale.net>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Dong Aisheng <b29396@freescale.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Mark Brown <broonie@opensource.wolfsonmicro.com>, "w.sang@pengutronix.de" <w.sang@pengutronix.de>, Guo Shawn-R65073 <r65073@freescale.com>, "lrg@ti.com" <lrg@ti.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: alsa-devel@alsa-project.org

On 07/25/2012 09:44 AM, Dong Aisheng wrote:
> I reproduced your issue.
> It seems the root cause is that you used the wrong device to record.
> The record device is 1.

That was the problem. I used wrong device. I tried to record without 
parameter -D.


> Can you try again with below command?
> arecord -D hw:0,1 -d 5 -f S16_LE -r 44100 -c 2 1.wav

This works fine. Thanks!


Lauri
