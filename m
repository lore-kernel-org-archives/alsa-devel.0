From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH 2/2] ASoC: dapm: Add a helper to get the
 platform for DAPM kcontrol
Date: Mon, 26 May 2014 21:53:45 +0530
Message-ID: <20140526162345.GG21128@intel.com>
References: <1401106136-3745-1-git-send-email-vinod.koul@intel.com>
 <1401106136-3745-2-git-send-email-vinod.koul@intel.com>
 <5383419F.9040105@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id C36832619E6
 for <alsa-devel@alsa-project.org>; Mon, 26 May 2014 18:40:11 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <5383419F.9040105@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: Kp Jeeja <jeeja.kp@intel.com>, alsa-devel@alsa-project.org, broonie@kernel.org, "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

On Mon, May 26, 2014 at 03:29:03PM +0200, Lars-Peter Clausen wrote:
> On 05/26/2014 02:08 PM, Vinod Koul wrote:
> [...]
> >+ * snd_soc_dapm_kcontrol_platform() - Returns the platform associated to a kcontrol
> >+ * @kcontrol: The kcontrol
> >+ */
> >+struct snd_soc_platform *snd_soc_dapm_kcontrol_platform(
> >+		struct snd_kcontrol *kcontrol)
> >+{
> >+	return dapm_kcontrol_get_wlist(kcontrol)->widgets[0]->platform;
> >+}
> >+EXPORT_SYMBOL_GPL(snd_soc_dapm_kcontrol_platform);
> 
> This conflicts with the series that moves DAPM support to the
> component level [1].

Thanks for the pointer, has this series been merged?
Dont see it in topic/core in Mark's tree.

I will take a look but fwiw this statement is not entirely true in the cover
letter of patch:

"This will allow any component to have DAPM widgets and routes, which was
previously only possible for CODECs, and will allow any component to have DAPM
widgets with controls (i.e. Mixers and MUXs), which was previously only possible
for CODECs"

I am already running a system which models platform and has Mixers,
Muxes and works fine (tested on 3.10 and 3.14).

Few bits of code is in RFC I sent earlier and will post these in detail over
next few weeks
> 
> - Lars
> 
> [1] http://mailman.alsa-project.org/pipermail/alsa-devel/2014-May/076718.html
> 

-- 
~Vinod
