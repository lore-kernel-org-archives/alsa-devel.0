From: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Subject: Re: [PATCH v3 17/20] dt: bindings: fix some broken links from
 txt->yaml conversion
Date: Sat, 8 Jun 2019 07:51:13 -0300
Message-ID: <20190608075113.32f2c7bb@coco.lan>
References: <ff457774d46d96e8fe56b45409aba39d87a8672a.1559933665.git.mchehab+samsung@kernel.org>
 <effeafed3023d8dc5f2440c8d5637ea31c02a533.1559933665.git.mchehab+samsung@kernel.org>
 <20190607185728.GJ2456@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20190607185728.GJ2456@sirena.org.uk>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Mark Brown <broonie@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, Olivier Moysan <olivier.moysan@st.com>, Alexandre Torgue <alexandre.torgue@st.com>, Jonathan Corbet <corbet@lwn.net>, Liam Girdwood <lgirdwood@gmail.com>, Linux Doc Mailing List <linux-doc@vger.kernel.org>, Arnaud Pouliquen <arnaud.pouliquen@st.com>, linux-kernel@vger.kernel.org, Mauro Carvalho Chehab <mchehab@infradead.org>, Rob Herring <robh+dt@kernel.org>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, Hugues Fruchet <hugues.fruchet@st.com>, linux-stm32@st-md-mailman.stormreply.com, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

Em Fri, 7 Jun 2019 19:57:28 +0100
Mark Brown <broonie@kernel.org> escreveu:

> On Fri, Jun 07, 2019 at 03:54:33PM -0300, Mauro Carvalho Chehab wrote:
> > Some new files got converted to yaml, but references weren't
> > updated accordingly.  
> 
> These should probably just be sent as normal patches rather than tied in
> with the rest of this series...

Thanks for applying it!

Yeah, but the problem with documentation patches is that sometimes
the patches are merged via docs tree, and sometimes via maintainer's
tree, depending on the subsystem.

Anyway, Jon merged this week a patch that should produce warnings
on COMPILE_TEST builds when a file has a broken link.

Hopefully, this will help a lot to warn people against regressions
related to it.


Thanks,
Mauro
