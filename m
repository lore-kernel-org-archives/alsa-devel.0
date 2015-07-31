From: "Bayyavarapu, Maruthi" <Maruthi.Bayyavarapu@amd.com>
Subject: query on upstream ASoC driver split across SOUND and
	DRM subsystems
Date: Fri, 31 Jul 2015 18:07:51 +0000
Message-ID: <8A8837939561D241AC8141C31522BA68291E33F9@SCYBEXDAG01.amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1bbn0107.outbound.protection.outlook.com [157.56.111.107])
 by alsa0.perex.cz (Postfix) with ESMTP id 024C9261692
 for <alsa-devel@alsa-project.org>; Fri, 31 Jul 2015 20:08:01 +0200 (CEST)
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
To: "tiwai@suse.de" <tiwai@suse.de>, "broonie@kernel.org" <broonie@kernel.org>, "perex@perex.cz" <perex@perex.cz>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "Vemuri,
 Murali-krishna" <Murali-krishna.Vemuri@amd.com>
List-Id: alsa-devel@alsa-project.org

Hi,

I want to send AMD ASoC driver for review.  
This driver has a dependency with AMD's 'DRM' subsystem components, which are not upstreamed yet.
Please suggest, whether this ASoC driver can be upstreamed via 'DRM' tree or any alternate approach is preferred.

The link to ASoC driver is : http://cgit.freedesktop.org/~agd5f/linux/commit/?h=acp-wip&id=2b67a441509886132456096256e99795c4d1c661

ASoC commits  and dependencies are currently in 'acp-wip' branch of :
git://people.freedesktop.org/~agd5f/linux 

Thanks,
Maruthi
