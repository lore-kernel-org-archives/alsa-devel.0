From: Daniel Mack <daniel@zonque.org>
Subject: Re: Use more than 1 .c file for a single codec driver
Date: Fri, 8 Nov 2013 12:37:46 +0100
Message-ID: <20131108113746.GA6684@tamtam.fritz.box>
References: <1121E117AD4ECE49880A389A396215BB935CA227EA@rtitmbs7.realtek.com.tw>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.zonque.de (svenfoo.org [82.94.215.22])
 by alsa0.perex.cz (Postfix) with ESMTP id 3BDD8261646
 for <alsa-devel@alsa-project.org>; Fri,  8 Nov 2013 12:37:48 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1121E117AD4ECE49880A389A396215BB935CA227EA@rtitmbs7.realtek.com.tw>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Bard Liao <bardliao@realtek.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "Mark Brown (broonie@linaro.org)" <broonie@linaro.org>
List-Id: alsa-devel@alsa-project.org

On Fri, Nov 08, 2013 at 01:32:55PM +0800, Bard Liao wrote:
> Can we use more than one .c file for a codec driver?
> There are some codecs with DSP function.
> I want to know if I can separate the DSP part from other functions.
> For example, rt5670.c/.h rt5670-dsp.c/.h for RT5670 codec driver.

Have a look at adau1701.c and sigmadsp.c, and at the Makefile of course.


Daniel
