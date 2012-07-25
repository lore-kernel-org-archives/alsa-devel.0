From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [RESEND] ASoC: omap-abe-twl6040: Add device tree
	support
Date: Wed, 25 Jul 2012 16:39:21 +0300
Message-ID: <500FF709.9060205@ti.com>
References: <1343221751-29863-1-git-send-email-peter.ujfalusi@ti.com>
 <20120725131507.GM3099@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na3sys009aog109.obsmtp.com (na3sys009aog109.obsmtp.com
 [74.125.149.201])
 by alsa0.perex.cz (Postfix) with ESMTP id 8E2F3265306
 for <alsa-devel@alsa-project.org>; Wed, 25 Jul 2012 15:38:48 +0200 (CEST)
Received: by qcmv28 with SMTP id v28so380482qcm.11
 for <alsa-devel@alsa-project.org>; Wed, 25 Jul 2012 06:38:49 -0700 (PDT)
In-Reply-To: <20120725131507.GM3099@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

On 07/25/2012 04:15 PM, Mark Brown wrote:
> On Wed, Jul 25, 2012 at 04:09:11PM +0300, Peter Ujfalusi wrote:
> =

>> Could you queue this for 3.6?
> =

> We're already in the merge window...

Yes, I'm aware of that.
I have sent the v3 on 6.6.2012 to the list [1].
I just noticed that on my working branch after I have rebased it on mainline
the omap-abe-twl6040 was not compiling (due to the cpu_dai_of_node rename to
cpu_of_node). I wanted to send a quick fix for this when I realized that the
DT support for the machine driver is not taken.

[1]
http://mailman.alsa-project.org/pipermail/alsa-devel/2012-June/052495.html

-- =

P=E9ter
