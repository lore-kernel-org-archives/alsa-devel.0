From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH v2 00/10] ASoC: support adding PCM
 dynamically from topology
Date: Sat, 15 Aug 2015 09:56:24 +0200
Message-ID: <55CEF0A8.5030707@metafoo.de>
References: <cover.1439217448.git.mengdong.lin@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-221.synserver.de (smtp-out-223.synserver.de
 [212.40.185.223])
 by alsa0.perex.cz (Postfix) with ESMTP id 9CF3F26514B
 for <alsa-devel@alsa-project.org>; Sat, 15 Aug 2015 09:56:26 +0200 (CEST)
In-Reply-To: <cover.1439217448.git.mengdong.lin@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: mengdong.lin@intel.com, alsa-devel@alsa-project.org
Cc: tiwai@suse.de, broonie@kernel.org, liam.r.girdwood@intel.com
List-Id: alsa-devel@alsa-project.org

On 08/10/2015 04:45 PM, mengdong.lin@intel.com wrote:
> From: Mengdong Lin <mengdong.lin@intel.com>
> 
> This series allows the topology core to create PCM devices dynamically.
> The user can define different DAIs in the topology files for different
> versions of firmware, but share a generic platform and machine driver.
> 
> A dummy DAI and DAI link can be used to register the soc card and specify
> the platform with topology. Then real DAIs are created in platform probing
> phase by the topology core, and the machine driver will be notified to create
> relavant DAI links.

This all sounds as if the dynamically loaded topology information does not
describe dynamic topology, e.g. like DSP firmware, but rather the static
topology that would usually come from things like devicetree or ACPI. Maybe
you need to rethink when the topology information is loaded and make sure
that the parts that describe the static topology are available before the
card is instantiated.

- Lars
