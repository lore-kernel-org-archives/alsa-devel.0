From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] Add SoundCard driver for OKI SEMICONDUCTOR
	ML7213 IOH
Date: Tue, 8 Nov 2011 10:39:39 +0000
Message-ID: <20111108103939.GB25591@opensource.wolfsonmicro.com>
References: <70D251FDDC55405882A8447CC455D56E@hacdom.okisemi.com>
	<8486F61FC3B94B908BFE654234DD6C97@hacdom.okisemi.com>
	<4E9BAEF7.1080406@dsn.lapis-semi.com>
	<s5h7h3ysa4l.wl%tiwai@suse.de> <4EA5563A.10703@dsn.lapis-semi.com>
	<20111024122015.GA26033@opensource.wolfsonmicro.com>
	<4EB8F079.9080703@dsn.lapis-semi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 09CD324369
	for <alsa-devel@alsa-project.org>; Tue,  8 Nov 2011 11:39:42 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <4EB8F079.9080703@dsn.lapis-semi.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Tomoya MORINAGA <tomoya-linux@dsn.lapis-semi.com>
Cc: alsa-devel@alsa-project.org, "Wang, Qi" <qi.wang@intel.com>, Takashi Iwai <tiwai@suse.de>, "Wang,
	Yong Y" <yong.y.wang@intel.com>, linux-kernel@vger.kernel.org, "Ewe, Kok Howg" <kok.howg.ewe@intel.com>, Liam Girdwood <lrg@ti.com>, "Clark, Joel" <joel.clark@intel.com>
List-Id: alsa-devel@alsa-project.org

On Tue, Nov 08, 2011 at 06:03:53PM +0900, Tomoya MORINAGA wrote:

> Though roughly, we re-created 3 files codec driver, platform drive
> and machine driver. (Not debugged/tested)
> Could you check these files ?

Please send patches for review using the standard kernel review process
- see Documentation/SubmittingPatches.  Sending a single enormous review
makes it much more difficult for people to review as there's so much
code in the one mail and attachments don't work with people's normal
workflows.
