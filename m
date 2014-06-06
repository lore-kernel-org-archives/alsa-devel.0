From: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Subject: Re: [PATCH] ASoC: Intel: Show Baytrail SST DSP
 firmware details during init
Date: Fri, 06 Jun 2014 17:28:24 +0300
Message-ID: <5391D008.4090803@linux.intel.com>
References: <1402042211-13842-1-git-send-email-jarkko.nikula@linux.intel.com>
 <20140606131327.GQ2520@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id 490FF265284
 for <alsa-devel@alsa-project.org>; Fri,  6 Jun 2014 16:28:28 +0200 (CEST)
In-Reply-To: <20140606131327.GQ2520@sirena.org.uk>
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
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

On 06/06/2014 04:13 PM, Mark Brown wrote:
> On Fri, Jun 06, 2014 at 11:10:11AM +0300, Jarkko Nikula wrote:
>> DSP initialization complete message IPC_IA_FW_INIT_CMPLT is a large message
>> carrying firmware details in mailbox. Read and show those details during
>> init in order to be able to get that information to QA reports.
> Applied, thanks.  Is it worth putting these into sysfs file so we can
> get the data read out with alsa-info.sh?
Not a bad idea. I'm not going to be implementing it instantly but should 
such a file be one generic node listing all the sound components that 
use fw and their info or a node with fixed name under each device's 
directory? Latter one sounds a bit simpler in kernel but I'm thinking 
which way makes most sense for utilities.

-- 
Jarkko
