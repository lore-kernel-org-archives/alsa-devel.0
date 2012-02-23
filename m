From: Vinod Koul <vinod.koul@linux.intel.com>
Subject: Re: [PATCH 6/8] ASoC: dapm: Implement and instantiate
 DAI widgets
Date: Thu, 23 Feb 2012 12:20:03 +0530
Message-ID: <1329979803.24656.125.camel@vkoul-udesk3>
References: <1329458170-22119-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1329458170-22119-6-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1329468009.24656.15.camel@vkoul-udesk3>
	<1329914154.24656.95.camel@vkoul-udesk3>
	<20120222124301.GA7340@opensource.wolfsonmicro.com>
	<1329915673.24656.107.camel@vkoul-udesk3>
	<20120222132912.GI7340@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [143.182.124.37])
	by alsa0.perex.cz (Postfix) with ESMTP id D3F4D10402D
	for <alsa-devel@alsa-project.org>; Thu, 23 Feb 2012 07:48:25 +0100 (CET)
In-Reply-To: <20120222132912.GI7340@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

On Wed, 2012-02-22 at 13:29 +0000, Mark Brown wrote:
> On Wed, Feb 22, 2012 at 06:31:13PM +0530, Vinod Koul wrote:
> 
> > So from a codec driver, how does these two get linked, who fills the
> > playback_widget pointer in dais?
> 
> > For a codec which has two DAIs and I register two AIFs how will you fill
> > the respective dia widgets in the DAIs...
> 
> The core initialises everything when it creates the widgets...
Looks like I am completely on tangent here :(

Sorry but I am not able to comprehend how the core created playback and
capture widget in the dai, which would be now used to trigger the
stream_event instead of stream name is being associated with DAPM map.

Earlier we would check the stream_name and find the widgets
corresponding to this and power up, how exactly would it work now :)


-- 
~Vinod
