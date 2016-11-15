From: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Subject: Re: [RFC PATCH 2/3] ucm: Parse sequence of component
	devices
Date: Tue, 15 Nov 2016 08:45:51 +0000
Message-ID: <1479199551.7823.11.camel@loki>
References: <cover.1479195801.git.mengdong.lin@linux.intel.com>
 <9baaf7a3d55a86e417826715e8e63d1a76582156.1479195801.git.mengdong.lin@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id DC9C226661C
 for <alsa-devel@alsa-project.org>; Tue, 15 Nov 2016 09:45:57 +0100 (CET)
In-Reply-To: <9baaf7a3d55a86e417826715e8e63d1a76582156.1479195801.git.mengdong.lin@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: mengdong.lin@linux.intel.com
Cc: alsa-devel@alsa-project.org, tiwai@suse.de, mengdong.lin@intel.com, vinod.koul@intel.com, broonie@kernel.org
List-Id: alsa-devel@alsa-project.org

On Tue, 2016-11-15 at 16:02 +0800, mengdong.lin@linux.intel.com wrote:
> From: Mengdong Lin <mengdong.lin@linux.intel.com>
> 
> A machine device's verb file (e.g.HiFi) can include configuration files
> of component devices via alsaconf syntax <searchdir:xxx> and <file_name>.
> Then the machine device's sequence can enable or disable a component
> device by keyword 'enadev' and 'disdev' followed the name of the component
> device.
> 
> UCM sequence parser will find the component device and mark if its enable
> or disable sequence is needed by the parent, the machine device.
> 
> New element type and struct are defined for the sequence of a component
> device. Component devices will be removed from the machine device list
> 'device_list' of a verb, since we don't want to expose them to audio
> servers with original API to list devices for backward compatibility.
> A new list 'cmpt_device_list' is used for the component devices of a verb.
> 
> Signed-off-by: Mengdong Lin <mengdong.lin@linux.intel.com>
> 



> @@ -306,6 +381,30 @@ static int parse_sequence(snd_use_case_mgr_t *uc_mgr ATTRIBUTE_UNUSED,
>  			continue;
>  		}
>  
> +		if (strcmp(cmd, "enadev") == 0) {
> +			/* need to enable a component device */
> +			curr->type = SEQUENCE_ELEMENT_TYPE_CMPT_SEQ;
> +			err = parse_component_seq(uc_mgr, n, 1,
> +						&curr->data.cmpt_seq);
> +			if (err < 0) {
> +				uc_error("error: enadev requires a valid device!");
> +				return err;
> +			}
> +			continue;
> +		}
> +
> +		if (strcmp(cmd, "disdev") == 0) {

Do we need to document enadev and disdev anywhere ?

Liam
