From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: Re: System with multiple arizona (wm5102) codecs
Date: Tue, 15 Sep 2015 09:06:48 +0100
Message-ID: <20150915080648.GG11200@ck-lbox>
References: <20150914115439.GA29646@amd> <20150914115255.GE11200@ck-lbox>
 <20150915061832.GA25442@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0a-001ae601.pphosted.com (mx0a-001ae601.pphosted.com
 [67.231.149.25])
 by alsa0.perex.cz (Postfix) with ESMTP id 5C2512606D6
 for <alsa-devel@alsa-project.org>; Tue, 15 Sep 2015 10:30:12 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20150915061832.GA25442@amd>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Pavel Machek <pavel@ucw.cz>
Cc: alsa-devel@alsa-project.org, tiwai@suse.de, linux-kernel@vger.kernel.org, patches@opensource.wolfsonmicro.com, lgirdwood@gmail.com, broonie@kernel.org
List-Id: alsa-devel@alsa-project.org

On Tue, Sep 15, 2015 at 08:18:32AM +0200, Pavel Machek wrote:
> Hi!
> 
> > > I've got an embedded system with two arizona / wm5102 codecs.
> > > 
> > > Unfortunately, kernel does not seem to be ready for that
> > > configuration.
> > > 
> > > In particular, drivers/regulator/arizona-ldo1.c and
> > > drivers/regulator/arizona-micsupp.c register system-wide "MICVDD" and
> > > "LDO1" regulators, but with two codecs in the system, we really have
> > > wm5102-codec.1.MICVDD, wm5102-codec.2.MICVDD, wm5102-codec.1.LDO1 and
> > > wm5102-codec.2.LDO1.
> > > 
> > > That got me second codec working in two-codec configuration, but first
> > > one still stops working as soon as two codecs are enabled.
> > > 
> > > If you have idea what else needs fixing, let me know.
> > > 
> > > Best regards,
> > > 								Pavel
> > 
> > I must confess I haven't ever tested a system with two Arizona
> > CODECs connected. Yes it seems you would get clashes on the
> > regulator names, I guess that would need to be fixed up. If you
> > were doing so wm831x-ldo.c would probably make a reasonable
> > example.
> > 
> > I guess you would need to be careful with the machine driver as
> > well, you will need to use a snd_soc_codec_conf structure for at
> > least one (although I would do both) of the CODECs to give  a
> > prefix for all the widget/control names, otherwise those will
> > clash and everything will probably behave very strangely. See
> > sound/soc/samsung/bells.c for an example doing this for wm9081.
> > 
> > Those are the only two things that spring to mind at the moment
> > but keep me informed on how you are getting on and I will let you
> > know if I can come up with any other traps.
> 
> It seems that davinci-evm takes data from device tree, but then uses
> statically-allocated evm_soc_card, which would lead to problems in
> dual-codec config....?

That somewhat depends on how you plan on doing things. I had
assumed you would be having a single machine driver with both
CODECs connected to it, in which case the statically allocated
snd_soc_card wouldn't be a problem. However, if you wanted to
have two seperate machine drivers with a single CODEC connected
to each then you would have an issue.

I guess either approach is reasonable and probably just depends
on what your end goal is.

Thanks,
Charles
