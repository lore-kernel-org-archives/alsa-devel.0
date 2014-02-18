From: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Subject: Re: [PATCHv2 4/5] ASoC: Intel: Add trace support for
 generic SST IPC messages.
Date: Tue, 18 Feb 2014 08:52:12 +0000
Message-ID: <1392713532.2304.15.camel@loki>
References: <1392643930-6030-1-git-send-email-liam.r.girdwood@linux.intel.com>
 <1392643930-6030-4-git-send-email-liam.r.girdwood@linux.intel.com>
 <20140218013618.GW2669@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id 1FB22265148
 for <alsa-devel@alsa-project.org>; Tue, 18 Feb 2014 09:52:26 +0100 (CET)
In-Reply-To: <20140218013618.GW2669@sirena.org.uk>
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
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, Benson Leung <bleung@google.com>, Jarkko Nikula <jarkko.nikula@intel.com>
List-Id: alsa-devel@alsa-project.org

On Tue, 2014-02-18 at 10:36 +0900, Mark Brown wrote:
> On Mon, Feb 17, 2014 at 01:32:09PM +0000, Liam Girdwood wrote:
> 
> >  include/trace/events/sst.h | 148 +++++++++++++++++++++++++++++++++++++++++++++
> 
> intel-sst perhaps?  It just seems like something someone else might use
> as a name.

True, it's a little generic. I also have trace/events/hswadsp.h for
Haswell IPC but that's quite specific so should be OK.

Liam
