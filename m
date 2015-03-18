From: Tanu Kaskinen <tanu.kaskinen@linux.intel.com>
Subject: Separate input and output jacks for one UCM device?
Date: Wed, 18 Mar 2015 21:41:08 +0200
Message-ID: <5509D4D4.6030000@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id 1E6AF2605F1
 for <alsa-devel@alsa-project.org>; Wed, 18 Mar 2015 20:41:15 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, Liam Girdwood <liam.r.girdwood@linux.intel.com>
Cc: Han Lu <han.lu@intel.com>, Arun Raghavan <arun@accosted.net>
List-Id: alsa-devel@alsa-project.org

Hi Liam and alsa-devel,

My understanding is that a UCM device can represent a thing that has 
both input and output (I don't particularly like that, but it's too late 
to complain). How likely do you think that there are or there will be 
some drivers that expose separate input and output jack kcontrols for a 
headset jack, to differentiate between headphones/headset/microphone? My 
understanding is that jack kcontrols store only booleans, so there's no 
way to distinguish between headphones and a headset with just one kcontrol.

The current UCM "spec" doesn't support specifying multiple kcontrols, 
since there's only one "JackControl" value. (Perhaps the "JackDev" value 
suffers from this problem too, but I don't know if jack input devices 
already support reporting the state separately for input and output.)

-- 
Tanu
