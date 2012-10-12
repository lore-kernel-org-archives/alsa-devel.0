From: "Babu, Ramesh" <ramesh.babu@intel.com>
Subject: Re: Silence playback during XRUN
Date: Fri, 12 Oct 2012 16:39:22 +0000
Message-ID: <32F4D3A311A1404B92CF923AFF38C3C526B2CA@BGSMSX101.gar.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id 32762261614
 for <alsa-devel@alsa-project.org>; Fri, 12 Oct 2012 18:39:26 +0200 (CEST)
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
Cc: Takashi Iwai <tiwai@suse.de>, Clemens Ladisch <clemens@ladisch.de>
List-Id: alsa-devel@alsa-project.org

Hi

I am trying to configure my application to use silence playback of ALSA in case XRUN.
I am configuring the silence parameters as below:

silence_threshold = 0
silence_size = boundary
stop_threshold = bounday

Using the above configuration I can see that ALSA sends silence during XRUN.
But I am experiencing audio is jerky, when application starts sending the data after the XRUN.

I noticed someone has met similar situation.
http://mailman.alsa-project.org/pipermail/alsa-devel/2011-December/046894.html

Do I need to modify my silence settings? Anything that I need take care apart from the above mentioned parameters?

Thanks
Ramesh
