From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH 08/14] soundwire: Add Slave status handling
 helpers
Date: Wed, 1 Nov 2017 14:38:20 +0530
Message-ID: <20171101090820.GA3187@localhost>
References: <1508382211-3154-1-git-send-email-vinod.koul@intel.com>
 <1508382211-3154-9-git-send-email-vinod.koul@intel.com>
 <s5h60bbqmkz.wl-tiwai@suse.de> <20171031130412.GW3187@localhost>
 <98f1b39a-b48d-2603-8e9d-88b4f804e2c8@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id 6F53E266AE1
 for <alsa-devel@alsa-project.org>; Wed,  1 Nov 2017 10:05:16 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <98f1b39a-b48d-2603-8e9d-88b4f804e2c8@linux.intel.com>
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
Cc: ALSA <alsa-devel@alsa-project.org>, Charles Keepax <ckeepax@opensource.cirrus.com>, Takashi Iwai <tiwai@suse.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, plai@codeaurora.org, LKML <linux-kernel@vger.kernel.org>, Sagar Dharia <sdharia@codeaurora.org>, patches.audio@intel.com, Mark <broonie@kernel.org>, srinivas.kandagatla@linaro.org, Shreyas NC <shreyas.nc@intel.com>, Sanyog Kale <sanyog.r.kale@intel.com>, Sudheer Papothi <spapothi@codeaurora.org>, alan@linux.intel.com
List-Id: alsa-devel@alsa-project.org

On Wed, Nov 01, 2017 at 02:49:15AM +0530, Pierre-Louis Bossart wrote:
> 
> >
> >>>+		if (found == false) {
> >>>+			/* TODO: Park this device in Group 13 */
> >>>+			dev_err(bus->dev, "Slave Entry not found");
> >>
> >>No break here?  Otherwise...
> >
> >Thats intentional. We want to still read next device that show up
> >
> >>
> >>>+		}
> >>>+
> >>>+	} while (ret == 0);
> >>
> >>... the outer loop may go endlessly.
> >>This condition doesn't look effective.
> >
> >not really. We cant keep reading successfully. At some point all slaves will
> >ignore and return ENODATA and we exit. Bus errors will also make it exit
> >
> >BUT given that we have seen stuff i am inclined to add a counter, we cant
> >have more than 11 device so that's a sane value to use :)
> 
> Yep. Keep in mind however that there could be theoretical corner cases: if a
> device is enumerated, loses sync and becomes attached again while you deal
> with others, you'd have more than 11 iterations.

Not really as that would be another interrupt and another status report.

-- 
~Vinod
