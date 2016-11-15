From: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Subject: Re: [RESEND RFC PATCH 0/3] ucm: Add support for
	component devices
Date: Tue, 15 Nov 2016 08:55:29 +0000
Message-ID: <1479200129.7823.19.camel@loki>
References: <cover.1479195801.git.mengdong.lin@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
 by alsa0.perex.cz (Postfix) with ESMTP id 53DDE26661C
 for <alsa-devel@alsa-project.org>; Tue, 15 Nov 2016 09:55:34 +0100 (CET)
In-Reply-To: <cover.1479195801.git.mengdong.lin@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: mengdong.lin@linux.intel.com
Cc: alsa-devel@alsa-project.org, tiwai@suse.de, mengdong.lin@intel.com, vinod.koul@intel.com, broonie@kernel.org
List-Id: alsa-devel@alsa-project.org

On Tue, 2016-11-15 at 16:01 +0800, mengdong.lin@linux.intel.com wrote:
> From: Mengdong Lin <mengdong.lin@linux.intel.com>
> 
> Sound cards are defined by machines. And off-soc codecs and DSPs embedded
> in DSP can be taken as the components and resued by different machines/
> sound cards. This series allows codec and SOC vendors to install UCM
> configuration files for a specific codec or DSP, and sound card verb
> files can just include these conf files of components, and trigger enable/
> disable sequence defined by the component devices.
> 
> Component devices will not be exposed to applications for backward
> compatibility. So audio servers like PulseAudio and CRAS still only see
> the machine devices.

The intention here is that the sound server will load the UCM
configuration based on the sound card name in []. I have patches to
improve this for Intel based machines which tend to all use the platform
name....sending shortly.

Liam
