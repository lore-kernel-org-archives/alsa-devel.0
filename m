From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH v3] ASoC: Intel: Get correct usage_count value to load
 firmware
Date: Wed, 15 Jul 2015 21:46:10 +0530
Message-ID: <20150715161610.GE5086@localhost>
References: <1436898231-118904-1-git-send-email-yang.a.fang@intel.com>
 <1436972289-29835-1-git-send-email-yang.a.fang@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <stable-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1436972289-29835-1-git-send-email-yang.a.fang@intel.com>
Sender: stable-owner@vger.kernel.org
To: yang.a.fang@intel.com
Cc: broonie@kernel.org, lgirdwood@gmail.com, alsa-devel@alsa-project.org, sathyanarayana.nujella@intel.com, kevin.strasser@linux.intel.com, srinivas.sripathi@intel.com, shilpa.sreeramalu@intel.com, dinesh.mirche@intel.com, stable@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Wed, Jul 15, 2015 at 07:58:09AM -0700, yang.a.fang@intel.com wrote:
> From: Shilpa Sreeramalu <shilpa.sreeramalu@intel.com>
> 
> The usage_count variable was read before it was set to the correct
> value, due to which the firmware load was failing. Because of this
> IPC messages sent to the firmware were timing out causing a delay
> of about 1 second while playing audio from the internal speakers.
> 
> With this patch the usage_count is read after the function call
> pm_runtime_get_sync which will increment the usage_count variable
> and the firmware load is successful and all the IPC messages are
> processed correctly.

Acked-by: Vinod Koul <vinod.koul@intel.com>

-- 
~Vinod
