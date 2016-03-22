From: Stefan Monnier <monnier@iro.umontreal.ca>
Subject: Re: [linux-sunxi] Re: [PATCH v8 2/2] ASoc: sun4i-codec: Add FM, Line and Mic inputs
Date: Tue, 22 Mar 2016 08:20:27 -0400
Message-ID: <jwvio0eu2pr.fsf-monnier+gmane.comp.hardware.netbook.arm.sunxi@gnu.org>
References: <20151221123148.1ab6480b@dayas> <20151221123416.51aa938e@dayas>
	<20151227182157.GI30359@lukather> <20151228040649.475a742f@dayas>
	<20160106220908.GE9631@lukather> <20160109164832.515d69b0@dayas>
	<20160312085222.226d89bf@scratchpost.org>
	<20160314104939.GL8418@lukather>
	<20160319175124.6bfe3617@scratchpost.org>
	<20160321180605.GE30977@lukather>
	<20160321181900.GZ2566@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, alsa-devel@alsa-project.org, linux-sunxi@googlegroups.com
List-Id: alsa-devel@alsa-project.org

>> I don't think you should focus too much on alsamixer, there's other
>> tools to modify the configuration.
> The expectation is that most users will use something like UCM and only
> system integrators will see the full control set in normal operation.

This presumes the "system integrator" (which could very well be the end
user in many cases) somehow knows what all the controls do/mean.

Anyway, it seems this is an ALSA problem rather than a sunxi problem.


        Stefan "who wishes ALSA could describe the meaning of all those
                controls, maybe as a graphical diagram, or as some kind
                of (hopefully simple) program"
