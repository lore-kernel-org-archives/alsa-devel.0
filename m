From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: Declaring HDMI channel allocation to kernel
Date: Mon, 23 Jul 2012 14:39:38 -0500
Message-ID: <500DA87A.8080901@linux.intel.com>
References: <500D5D3D.2060108@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [143.182.124.21])
 by alsa0.perex.cz (Postfix) with ESMTP id 74885260317
 for <alsa-devel@alsa-project.org>; Mon, 23 Jul 2012 21:39:37 +0200 (CEST)
In-Reply-To: <500D5D3D.2060108@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 7/23/2012 9:18 AM, Gabriel M. Beddingfield wrote:
>
> Is there an established way for me (from userspace) to pass the HDMI 
> Channel Allocation (1 byte) to the driver?  If not, can you recommend 
> an approach?
>
> In most of the drivers that I've inspected, the drivers seem to assume 
> that there's a 1:1 mapping of Number-of-Channels to 
> Channel-Allocation.  However, the HDMI sink declares which speakers it 
> has attached in the EDID.  If I can match this in userspace... I need 
> a way to communicate it to the driver.
I believe this is one of the topics that will be presented by Takashi at 
LPC, we need the ability to specify a arbitrary sink-specific channel 
mapping.
