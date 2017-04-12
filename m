From: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Subject: Re: [PATCH v2 0/3] ucm-conf: Add intel UCM conf files
 to alsa-ucm-conf repo
Date: Wed, 12 Apr 2017 15:50:57 +0100
Message-ID: <1492008657.3482.184.camel@loki>
References: <cover.1490064444.git.fuweix.tang@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 by alsa0.perex.cz (Postfix) with ESMTP id F247B266FA9
 for <alsa-devel@alsa-project.org>; Wed, 12 Apr 2017 16:51:13 +0200 (CEST)
In-Reply-To: <cover.1490064444.git.fuweix.tang@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: fuweix.tang@intel.com
Cc: tiwai@suse.de, mengdong.lin@intel.com, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Wed, 2017-04-12 at 16:54 +0800, fuweix.tang@intel.com wrote:
> From: Fuwei Tang <fuweix.tang@intel.com>
> 
> Add the intel UCM configs to a dedicated UCM conf repo and release them using
> the BSD license.

We are still missing the LICENSE/COPYING file. We need to add it the top
directory level so it's clear to users. 

> The other non intel UCM files can be moved over when there is agreement with the
> file authors, but in the mean time they will stay in alsa-lib.
> The configs are moved from alsa-lib repo. The original authorship and commit
> message of all config files will be reserved.
> 

Takashi, how do you want to manage the move ? We could add the files to
the new repo first and then only delete them in alsa-lib after the next
alsa-lib release ? This would give time for distros to pick up the new
conf package. I'm easy on whatever works best here.

Thanks

Liam


> Fuwei Tang (1):
>   ucm-conf: Set up for installation
> 
> Vinod Koul (2):
>   ucm-conf: broxton: add broxton-rt298 conf files
>   ucm-conf: skylake: add skylake-rt286 conf files
> 
>  .gitignore                       |  12 ++++
>  ChangeLog                        |   1 +
>  INSTALL                          |   1 +
>  Makefile.am                      |   1 +
>  broxton-rt298/Hdmi1              |  22 +++++++
>  broxton-rt298/Hdmi2              |  14 +++++
>  broxton-rt298/HiFi               | 129 +++++++++++++++++++++++++++++++++++++++
>  broxton-rt298/Makefile.am        |   4 ++
>  broxton-rt298/broxton-rt298.conf |  58 ++++++++++++++++++
>  configure.ac                     |  24 ++++++++
>  gitcompile                       |   5 ++
>  skylake-rt286/Hdmi1              |  20 ++++++
>  skylake-rt286/Hdmi2              |  20 ++++++
>  skylake-rt286/HiFi               | 129 +++++++++++++++++++++++++++++++++++++++
>  skylake-rt286/Makefile.am        |   4 ++
>  skylake-rt286/skylake-rt286.conf |  60 ++++++++++++++++++
>  16 files changed, 504 insertions(+)
>  create mode 100644 .gitignore
>  create mode 100644 ChangeLog
>  create mode 120000 INSTALL
>  create mode 100644 Makefile.am
>  create mode 100644 broxton-rt298/Hdmi1
>  create mode 100644 broxton-rt298/Hdmi2
>  create mode 100644 broxton-rt298/HiFi
>  create mode 100644 broxton-rt298/Makefile.am
>  create mode 100644 broxton-rt298/broxton-rt298.conf
>  create mode 100644 configure.ac
>  create mode 100755 gitcompile
>  create mode 100644 skylake-rt286/Hdmi1
>  create mode 100644 skylake-rt286/Hdmi2
>  create mode 100644 skylake-rt286/HiFi
>  create mode 100644 skylake-rt286/Makefile.am
>  create mode 100644 skylake-rt286/skylake-rt286.conf
> 
