From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH] ASoC: omap-abe-twl6040: Remove support for
 pdata (legacy boot)
Date: Fri, 12 Jul 2013 14:08:12 +0200
Message-ID: <51DFF1AC.4040103@ti.com>
References: <1373628835-11439-1-git-send-email-peter.ujfalusi@ti.com>
 <20130712115157.GF24508@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from arroyo.ext.ti.com (arroyo.ext.ti.com [192.94.94.40])
 by alsa0.perex.cz (Postfix) with ESMTP id 882D22659C4
 for <alsa-devel@alsa-project.org>; Fri, 12 Jul 2013 14:08:16 +0200 (CEST)
In-Reply-To: <20130712115157.GF24508@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

On 07/12/2013 01:51 PM, Mark Brown wrote:
> On Fri, Jul 12, 2013 at 01:33:55PM +0200, Peter Ujfalusi wrote:
> =

>> +/* TODO: This file can be removed in 3.12 since it is no longer needed =
*/
>> +
> =

> It's a bit late to do this for v3.11 so may as well just jump straight
> to the removal?  Having the extra code isn't going to actively break
> anything so it's just a cleanup.

I know it is late for 3.11, but if I remove it with this commit your for-ne=
xt
will not compile if OMAP4 is selected since the board files are still there.
I prefer to send a separate patch later on to remove the header file after
your for-next picks up 3.11-rc1

-- =

P=E9ter
