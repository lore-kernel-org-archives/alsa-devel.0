From: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Subject: Re: [RFC] ALSA: add new alsa control byte extended
Date: Fri, 29 Nov 2013 09:27:21 +0200
Message-ID: <529841D9.7060301@linux.intel.com>
References: <1385699397-18662-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id EFFFE26030E
 for <alsa-devel@alsa-project.org>; Fri, 29 Nov 2013 08:27:25 +0100 (CET)
In-Reply-To: <1385699397-18662-1-git-send-email-vinod.koul@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Vinod Koul <vinod.koul@intel.com>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, broonie@kernel.org, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

Hi

On 11/29/2013 06:29 AM, Vinod Koul wrote:
> @@ -891,6 +892,11 @@ struct snd_ctl_elem_value {
>   			unsigned char data[512];
>   			unsigned char *data_ptr;	/* obsoleted */
>   		} bytes;
> +		struct {
> +			unsigned long size;	/* size of buffer */
> +			__u64 data;	i	/* user data pointer */
>
Typo here? (__u64 data;    i)

-- 
Jarkko
