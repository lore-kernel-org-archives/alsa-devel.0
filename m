From: "Singh, Guneshwor" <guneshwor.o.singh@intel.com>
Subject: Re: [PATCH] ALSA: hda - Add vendor id for Cannonlake
	HDMI codec
Date: Fri, 8 Dec 2017 09:31:35 +0530
Message-ID: <20171208040134.GA29106@g2>
References: <20171207123620.25640-1-guneshwor.o.singh@intel.com>
 <20171208033629.GA31207@subhransu-desktop>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id 73B92266D7D
 for <alsa-devel@alsa-project.org>; Fri,  8 Dec 2017 05:01:30 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20171208033629.GA31207@subhransu-desktop>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
Cc: Takashi Iwai <tiwai@suse.de>, Vinod Koul <vinod.koul@intel.com>, ALSA <alsa-devel@alsa-project.org>, Patches Audio <patches.audio@intel.com>
List-Id: alsa-devel@alsa-project.org

On Fri, Dec 08, 2017 at 09:06:34AM +0530, Subhransu S. Prusty wrote:
> On Thu, Dec 07, 2017 at 06:06:20PM +0530, Guneshwor Singh wrote:
> > Cannonlake HDMI codec has the same nid as Geminilake. This adds the
> > codec entry for it.
> 
> CNL and GLK share the same vendor nid not the vendor id. 
> You may update the subject and commit message.
> 

It's adding new vendor id and uses vendor nid from GLK's. So commit msg
seems fine.
