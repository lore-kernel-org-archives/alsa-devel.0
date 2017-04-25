From: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
Subject: Re: [PATCH v2 15/18] dt-bindings: sound: Add bindings
 for Cirrus Logic Madera codecs
Date: Tue, 25 Apr 2017 17:27:44 +0100
Message-ID: <1493137664.4826.75.camel@rf-debian.wolfsonmicro.main>
References: <1493050124-5970-1-git-send-email-rf@opensource.wolfsonmicro.com>
 <1493050124-5970-16-git-send-email-rf@opensource.wolfsonmicro.com>
 <20170425155257.s6m4wgrzxxsxcggo@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com
 [67.231.152.168])
 by alsa0.perex.cz (Postfix) with ESMTP id 438E0266F9D
 for <alsa-devel@alsa-project.org>; Tue, 25 Apr 2017 18:27:47 +0200 (CEST)
In-Reply-To: <20170425155257.s6m4wgrzxxsxcggo@sirena.org.uk>
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
Cc: gnurou@gmail.com, alsa-devel@alsa-project.org, jason@lakedaemon.net, devicetree@vger.kernel.org, linus.walleij@linaro.org, patches@opensource.wolfsonmicro.com, linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org, robh+dt@kernel.org, tglx@linutronix.de, lee.jones@linaro.org
List-Id: alsa-devel@alsa-project.org

On Tue, 2017-04-25 at 16:52 +0100, Mark Brown wrote:
> On Mon, Apr 24, 2017 at 05:08:41PM +0100, Richard Fitzgerald wrote:
> > The Cirrus Logic Madera codecs are a family of related codecs with
> > extensive digital and analogue I/O, digital mixing and routing,
> > signal processing and programmable DSPs.
> 
> Please submit patches using subject lines reflecting the style for the
> subsystem.  This makes it easier for people to identify relevant
> patches.  Look at what existing commits in the area you're changing are
> doing and make sure your subject lines visually resemble what they're
> doing.
> 
> > +Required properties:
> > +  - compatible : One of the following chip-specific strings:
> > +        "cirrus,cs47l35-codec"
> > +        "cirrus,cs47l85-codec"
> > +        "cirrus,cs47l90-codec"
> 
> You shouldn't have compatible strings for subfunctions of a MFD unless
> these represent meaningful reusable IPs that can exist separately from
> the parent chip, that's clearly not the case here.  All you're doing
> here is encoding Linux internal abstractions which aren't OS neutral and
> might change in future (for example clocking might move more into the
> clock API).

While that's nice, the of_node doesn't get populated if there isn't a
compatible string. And people don't like workarounds for the missing
of_node.
