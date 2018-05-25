From: Shreyas NC <shreyas.nc@intel.com>
Subject: Re: [PATCH v5 1/3] ASoC: Add initial support for
 multiple CPU DAIs
Date: Fri, 25 May 2018 07:46:17 +0530
Message-ID: <20180525021617.GD3116@snc-desk>
References: <1526985623-2606-1-git-send-email-shreyas.nc@intel.com>
 <1526985623-2606-2-git-send-email-shreyas.nc@intel.com>
 <471c42d3-881f-692a-8713-a6f2c4917bd7@linux.intel.com>
 <20180524053411.GB4205@snc-desk>
 <613e98a3-830a-c19a-da60-91f5d546aafc@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
 by alsa0.perex.cz (Postfix) with ESMTP id 9769B267646
 for <alsa-devel@alsa-project.org>; Fri, 25 May 2018 04:18:02 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <613e98a3-830a-c19a-da60-91f5d546aafc@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: alsa-devel@alsa-project.org, ckeepax@opensource.cirrus.com, patches.audio@intel.com, liam.r.girdwood@linux.intel.com, Vinod Koul <vkoul@kernel.org>, broonie@kernel.org
List-Id: alsa-devel@alsa-project.org

On Thu, May 24, 2018 at 03:45:40PM -0500, Pierre-Louis Bossart wrote:
> =

> =

> On 05/24/2018 12:34 AM, Shreyas NC wrote:
> >>>@@ -1120,6 +1123,9 @@ struct snd_soc_pcm_runtime {
> >>>  	struct snd_soc_dai **codec_dais;
> >>>  	unsigned int num_codecs;
> >>>+	struct snd_soc_dai **cpu_dais;
> >>>+	unsigned int num_cpu_dai;
> >>>+
> >>This structure is becoming difficult to interpret:
> >>
> >> =A0=A0=A0 struct snd_soc_dai *codec_dai;
> >> =A0=A0=A0 struct snd_soc_dai *cpu_dai;
> >>
> >> =A0=A0=A0 struct snd_soc_dai **codec_dais;
> >> =A0=A0=A0 unsigned int num_codecs;
> >>
> >> =A0=A0=A0 struct snd_soc_dai **cpu_dais;
> >> =A0=A0=A0 unsigned int num_cpu_dai;
> >>
> >>What is the intended usage of codec_dai vs. codec_dais and cpu_dai vs.
> >>cpu_dais?
> >rtd->cpu_dai is used in many drivers to get cpu_dai from soc_pcm_runtime.
> >Similarly cpu_dais is addded to get multiple cpu_dais from runtime.
> >
> >TBH, I have shadowed the codec_dais implementation for sake of
> >convenience and being conformal :)
> >
> >>If this is only to handle the single codec_dai/single cpu_dai as an
> >>exception, should we port the code to support multiple cpu_dais/multiple
> >>codec_dais?
> >>
> >As mentioned in [1] (in cover letter), there are discussions to unify cp=
u and
> >codec dais and this is the first step towards that. So, yes, eventually =
we
> >should port the code as you have suggested :)
> ok, maybe add a comment in the commit message then?

Ok

> >
> >-	/*
> >-	 * At least one of CPU DAI name or CPU device name/node must be
> >-	 * specified
> >-	 */
> >-	if (!link->cpu_dai_name &&
> >-	    !(link->cpu_name || link->cpu_of_node)) {
> >-		dev_err(card->dev,
> >-			"ASoC: Neither cpu_dai_name nor cpu_name/of_node are set for %s\n",
> >-			link->name);
> >-		return -EINVAL;
> >-	}
> >+	for (i =3D 0; i < link->num_cpu_dai; i++) {
> >+		if (link->cpu_dai[i].name &&
> >+			link->cpu_dai[i].of_node) {
> >+			dev_err(card->dev,
> >+			    "ASoC: Neither/both cpu name/of_node are set for %s\n",
> >+					link->cpu_dai[i].name);
> >+			return -EINVAL;
> >+		}
> >+
> >+		/*
> >+		 * At least one of CPU DAI name or CPU device name/node must be
> >+		 * specified
> >+		 */
> >+		if (!link->cpu_dai[i].dai_name &&
> >+			!(link->cpu_dai[i].name || link->cpu_dai[i].of_node)) {
> >>This doesn't seem to be the logical translation of the initial condition
> >>based on link->cpu_name and link->cpu_of_node?
> >>
> >pasting the code added from the function above to show the mapping b/w n=
ame,
> >of_node and dai_name:
> >
> >		dai_link->cpu_dai[0].name =3D dai_link->cpu_name;
> >		dai_link->cpu_dai[0].of_node =3D dai_link->cpu_of_node;
> >		dai_link->cpu_dai[0].dai_name =3D dai_link->cpu_dai_name;
> >
> >and the original condition was:
> >		if (!link->cpu_dai_name &&
> >			!(link->cpu_name || link->cpu_of_node)) {
> >
> >So, it does look correct to me, unless I am missing something obvious :(
> The original code I was referring to is this:
> =

> =A0=A0=A0 /*
> =A0=A0=A0 =A0* CPU device may be specified by either name or OF node, but
> =A0=A0=A0 =A0* can be left unspecified, and will be matched based on DAI
> =A0=A0=A0 =A0* name alone..
> =A0=A0=A0 =A0*/
> =A0=A0=A0 if (link->cpu_name && link->cpu_of_node) {
> =A0=A0=A0 =A0=A0=A0 dev_err(card->dev,
> =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 "ASoC: Neither/both cpu name/of_node are se=
t for %s\n",
> =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 link->name);
> =A0=A0=A0 =A0=A0=A0 return -EINVAL;
> =A0=A0=A0 }
> =A0=A0=A0 /*
> =A0=A0=A0 =A0* At least one of CPU DAI name or CPU device name/node must =
be
> =A0=A0=A0 =A0* specified
> =A0=A0=A0 =A0*/
> =A0=A0=A0 if (!link->cpu_dai_name &&
> =A0=A0=A0 =A0=A0=A0 !(link->cpu_name || link->cpu_of_node)) {
> =A0=A0=A0 =A0=A0=A0 dev_err(card->dev,
> =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 "ASoC: Neither cpu_dai_name nor cpu_name/of=
_node are set for
> %s\n",
> =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 link->name);
> =A0=A0=A0 =A0=A0=A0 return -EINVAL;
> =A0=A0=A0 }
> =

> =A0=A0=A0 return 0;
> =

> The new code is this:
> =

> =A0=A0=A0 for (i =3D 0; i < link->num_cpu_dai; i++) {
> =A0=A0=A0 =A0=A0=A0 if (link->cpu_dai[i].name &&
> =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 link->cpu_dai[i].of_node) {
> =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 dev_err(card->dev,
> =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 "ASoC: Neither/both cpu name/of_n=
ode are set for %s\n",
> =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 link->cpu_dai[i].name);
> =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 return -EINVAL;
> =A0=A0=A0 =A0=A0=A0 }
> =

> =A0=A0=A0 =A0=A0=A0 /*
> =A0=A0=A0 =A0=A0=A0 =A0* At least one of CPU DAI name or CPU device name/=
node must be
> =A0=A0=A0 =A0=A0=A0 =A0* specified
> =A0=A0=A0 =A0=A0=A0 =A0*/
> =A0=A0=A0 =A0=A0=A0 if (!link->cpu_dai[i].dai_name &&
> =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 !(link->cpu_dai[i].name || link->cpu_dai[i]=
.of_node)) {
> =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 dev_err(card->dev,
> =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 "ASoC: Neither cpu_dai_name nor c=
pu_name/of_node are set for
> %s\n",
> =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 link->name);
> =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 return -EINVAL;
> =A0=A0=A0 =A0=A0=A0 }
> =A0=A0=A0 }
> =

> Yes, it's equivalent for i=3D=3D0, but it's not clear to me for non-zero
> indices. I don't get how/where
> link->cpu_dai[i].name and link->cpu_dai[i].of_node are initialized for i>=
0.
> =


Aaah ok, I understand your question now :)

That is added in the dai_link description in the machine driver.

Like this:

static struct snd_soc_dai_link_component test_multi_cpu_component[] =3D {
        { /* Left */
                .name =3D "int-sdw.1",
                .dai_name =3D "SDW1 Pin0",
        },
        { /* Right */
                .name =3D "int-sdw.2",
                .dai_name =3D "SDW2 Pin0",
        },
};

struct snd_soc_dai_link test_dailink[] =3D {
        	{
                	.name =3D "SDW0-Codec",
	                .cpu_dai =3D test_multi_cpu_component,
        	        .num_cpu_dai =3D ARRAY_SIZE(sdw_multi_cpu_comp),
			...
		}
}

> >>>-	if (cpu_dai->driver->compress_new) {
> >>>+	if (rtd->cpu_dais[0]->driver->compress_new) {
> >>>+		if (rtd->num_cpu_dai > 1)
> >>>+			dev_warn(card->dev,
> >>>+				"ASoC: multi-cpu compress dais not supported");
> >>Not sure this is right, you could have a case where the compress dai is=
 not
> >>on the cpu_dai[0]?
> >I am not able to comprehend that we can have multi CPU DAIS in a DAI Link
> >with one of the DAI being compress and the other being a PCM DAI.
> >
> >Any such systems that you can think of ?
> Yes I agree, my point was that you test only for the first cpu_dai (index
> 0), but if rtd->cpu_dais[1]->drivers->compress_new is non NULL then it's
> also wrong. You should test for all cpu_dais to make sure they are all PC=
M.
> =


Ok

--Shreyas
-- =
