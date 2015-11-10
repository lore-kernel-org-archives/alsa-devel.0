From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: Intel Cherry Trail -- No sound in linux
Date: Tue, 10 Nov 2015 13:00:11 -0600
Message-ID: <56423EBB.8010108@linux.intel.com>
References: <000a01d11b93$38632860$a9297920$@com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by alsa0.perex.cz (Postfix) with ESMTP id D620126546D
 for <alsa-devel@alsa-project.org>; Tue, 10 Nov 2015 20:00:15 +0100 (CET)
In-Reply-To: <000a01d11b93$38632860$a9297920$@com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Zhihe Tu <tuzhihe@pcasl.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 11/10/15 2:38 AM, Zhihe Tu wrote:
> Hi All,
>
> I'm trying to make the CherryTrail tablet works in ubuntu14.04.3,  there's
> no sound at all,  but it works in win8 & android.

> [   12.182265] intel_sst_acpi 808622A8:00: Alloc for str 1 pipe 0x90
> [   13.181361] intel_sst_acpi 808622A8:00: Wait timed-out condition:0x0,
> msg_id:0x1 fw_state 0x2

Did you update /lib/firmware with the latest from 
http://git.kernel.org/cgit/linux/kernel/git/firmware/linux-firmware.git ?
