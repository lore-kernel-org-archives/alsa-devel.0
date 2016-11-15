From: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Subject: Re: [RFC PATCH 1/3] ucm: Skip component directories
 when scanning sound card configuration files
Date: Tue, 15 Nov 2016 08:45:45 +0000
Message-ID: <1479199545.7823.10.camel@loki>
References: <cover.1479195801.git.mengdong.lin@linux.intel.com>
 <5d26bcb59c9dc3ef0b1e004b1e9bd5346160c54d.1479195801.git.mengdong.lin@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by alsa0.perex.cz (Postfix) with ESMTP id 7048926661C
 for <alsa-devel@alsa-project.org>; Tue, 15 Nov 2016 09:45:49 +0100 (CET)
In-Reply-To: <5d26bcb59c9dc3ef0b1e004b1e9bd5346160c54d.1479195801.git.mengdong.lin@linux.intel.com>
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
> Cards are defined by machines. DSPs embedded in SoC and off-soc codecs
> can be taken as components for machines, and can be reused by different
> machines/cards. Codec and SoC vendors can define their own UCM config
> files. If a codec or DSP is used by a machine, the card configuration file
> can include the conf file of the codec and DSP. Later patches will
> complete support for this feature.
> 
> Two new directories will be used to store the UCM configuration files for
> a specific codec or DSP firmware:
> - /usr/share/alsa/ucm/dsps ... for DSP embedded in SoC
> - /usr/share/alsa/ucm/codecs ... for off-soc codecs
> 
> These two directories will be skipped when UCM manager scans the card
> directories under /usr/share/alsa/ucm.
> 
> Signed-off-by: Mengdong Lin <mengdong.lin@linux.intel.com>
> 
> diff --git a/src/ucm/parser.c b/src/ucm/parser.c
> index 13f62d7..5fc98a1 100644
> --- a/src/ucm/parser.c
> +++ b/src/ucm/parser.c
> @@ -1259,7 +1259,18 @@ static int filename_filter(const struct dirent *dirent)
>  	return 0;
>  }
>  
> -/* scan all cards and comments */
> +/* scan all cards and comments
> + *
> + * Cards are defined by machines. Each card/machine installs its UCM
> + * configuration files in a subdirectory with the same name as the sound
> + * card under /usr/share/alsa/ucm. This function will scan all the card
> + * directories.
> + * Two direcotries, 'codecs' and 'dsps', are skipped in the scanning. These
> + * two directories are used to store UCM configurations file for off-soc
> + * codecs and DSPs embedded in SoC, which are components of machines.
> + * Their configuration files can be included by different machines/cards,
> + * and alsaconf will import the included files automatically.
> + */
>  int uc_mgr_scan_master_configs(const char **_list[])
>  {
>  	char filename[MAX_FILE], dfl[MAX_FILE];
> @@ -1309,6 +1320,13 @@ int uc_mgr_scan_master_configs(const char **_list[])
>  	}
>  
>  	for (i = 0; i < cnt; i++) {
> +
> +		/* Skip the directories for component devices */
> +		if (!strncmp(namelist[i]->d_name, "codecs", 6))
> +			continue;
> +		if (!strncmp(namelist[i]->d_name, "dsps", 4))
> +			continue;

Maybe we should have an array of strings that denote directories that
contain non master components, that way we could easily add other
directories for components.

Liam 
