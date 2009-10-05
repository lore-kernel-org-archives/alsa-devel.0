From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: [PATCH] ascenario: Add scenario support to alsa-lib
Date: Mon, 5 Oct 2009 11:14:33 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.0910051111220.31529@eeebox2.perex-int.cz>
References: <1254390436-5283-1-git-send-email-stefan@datenfreihafen.org>
	<1254390436-5283-2-git-send-email-stefan@datenfreihafen.org>
	<20091001122835.GC14417@sirena.org.uk>
	<20091001131948.GA5936@excalibur.local>
	<20091001150849.GE5936@excalibur.local>
	<20091005082747.GA3983@excalibur.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (unknown [212.20.107.53])
	by alsa0.perex.cz (Postfix) with ESMTP id 1F2AF2434F
	for <alsa-devel@alsa-project.org>;
	Mon,  5 Oct 2009 11:14:35 +0200 (CEST)
In-Reply-To: <20091005082747.GA3983@excalibur.local>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Stefan Schmidt <stefan@datenfreihafen.org>
Cc: Graeme Gregory <gg@slimlogic.co.uk>, alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Ian Molton <ian@mnementh.co.uk>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Mon, 5 Oct 2009, Stefan Schmidt wrote:

> Hello.
>
> On Thu, 2009-10-01 at 17:08, Stefan Schmidt wrote:
>>
>> For an updated patch with all your comments inlcuded see below.
>
> Here is another update on this patch. Fixed a problem I introduced in the last
> iteration and changed the config tokens from MasterPlaybackVolume to Master
> Playback Volume, etc. That's based on a siggestion from Mark which we had
> offlist. Let me quote it here to explain the good reasoning behind it.

Question: What's the IDs (integers) returned with 
snd_scenario_get_master_playback_volume() etc. functions?

Please, include also some test configuration files to review the 
configuration syntax.

 						Jaroslav

-----
Jaroslav Kysela <perex@perex.cz>
Linux Kernel Sound Maintainer
ALSA Project, Red Hat, Inc.
