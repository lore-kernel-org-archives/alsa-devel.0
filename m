From: Brian Austin <brian.austin@cirrus.com>
Subject: Re: [PATCH v4 2/2] ASoc: Add devictree bindings for
	CS35L35 CODEC
Date: Mon, 30 Jan 2017 14:39:35 -0600
Message-ID: <b4c5fd4d-cc0b-4e17-923e-87048f391cec@EX3.ad.cirrus.com>
References: <1485360798-15523-1-git-send-email-brian.austin@cirrus.com>
 <c3224f63-e5d1-4874-8317-c5df53d0207d@EX3.ad.cirrus.com>
 <20170130201655.zuozjbg5jnhwrezy@rob-hp-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com
 [67.231.152.168])
 by alsa0.perex.cz (Postfix) with ESMTP id BD754266EF9
 for <alsa-devel@alsa-project.org>; Mon, 30 Jan 2017 21:36:55 +0100 (CET)
In-Reply-To: <20170130201655.zuozjbg5jnhwrezy@rob-hp-laptop>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Rob Herring <robh@kernel.org>
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, Brian Austin <brian.austin@cirrus.com>, alsa-devel@alsa-project.org, lgirdwood@gmail.com, broonie@kernel.org, ckeepax@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

On Mon, 30 Jan 2017, Rob Herring wrote:

> On Wed, Jan 25, 2017 at 10:13:18AM -0600, Brian Austin wrote:
> > Add devicetree bindings documentatin for
> > Cirrus Logic CS35L35 Boosted Amplifier
> > 
> > Signed-off-by: Brian Austin <brian.austin@cirrus.com>
> > ---
> >  .../devicetree/bindings/sound/cs35l35.txt          | 171 +++++++++++++++++++++
> >  1 file changed, 171 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/sound/cs35l35.txt
> 
> This looks similar to the CS35L33. Please align the property names and 
> perhaps combine into a single binding doc.
> 
> Rob
> 
I can make sure the names are consistent for some of them but most of it 
would be messy to combine into a single doc IMO. I know it looks similar 
for some of them like the algorithm nodes but they are very different in 
parameters and operation.

Would it suffice to just make sure the properties that are the same be 
reflected across both docs?

Thanks
Brian
