From: Wei Ni <wni@nvidia.com>
Subject: Re: [PATCH]Support MCP89 and GT21x hdmi audio
Date: Wed, 3 Mar 2010 11:33:25 +0800
Message-ID: <6B4D417B830BC44B8026029FD256F7F1C16A89A119@HKMAIL01.nvidia.com>
References: <6B4D417B830BC44B8026029FD256F7F1C068B2BA8B@HKMAIL01.nvidia.com>
	<20100302054307.GA6165@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from hqemgate04.nvidia.com (hqemgate04.nvidia.com [216.228.121.35])
	by alsa0.perex.cz (Postfix) with ESMTP id 8775C10380B
	for <alsa-devel@alsa-project.org>; Wed,  3 Mar 2010 04:33:30 +0100 (CET)
In-Reply-To: <20100302054307.GA6165@localhost>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: 'Wu Fengguang' <fengguang.wu@intel.com>
Cc: 'Takashi Iwai' <tiwai@suse.de>, 'akpm' <akpm@linux-foundation.org>, 'alsa-devel' <alsa-devel@alsa-project.org>, 'Pavel Hofman' <pavel.hofman@insite.cz>, 'linux-kernel' <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

Hi,
Because there have no common codes for standard HDMI operation,
So in my patch file, there have some codes same as patch_intelhdmi.c
I think we could merge them later.

Thanks
Wei.

-----Original Message-----
From: Wu Fengguang [mailto:fengguang.wu@intel.com] 
Sent: Tuesday, March 02, 2010 1:43 PM
To: Wei Ni
Cc: 'Takashi Iwai'; 'akpm'; 'alsa-devel'; 'linux-kernel'; 'Pavel Hofman'
Subject: Re: [alsa-devel] [PATCH]Support MCP89 and GT21x hdmi audio

On Mon, Mar 01, 2010 at 07:27:53PM +0800, Wei Ni wrote:
> Hi, Takashi
> I developed the hdmi audio driver for new chipset MCP89 and GT21x.
> The new HAD controller and codec support standard HDMI operation.
> 
> I attached the patch file, please check it.

Wei Ni,

Can we avoid the big copy&paste and do more code reuse?
This benefits all of us in long term.

Thanks,
Fengguang
-----------------------------------------------------------------------------------
This email message is for the sole use of the intended recipient(s) and may contain
confidential information.  Any unauthorized review, use, disclosure or distribution
is prohibited.  If you are not the intended recipient, please contact the sender by
reply email and destroy all copies of the original message.
-----------------------------------------------------------------------------------
