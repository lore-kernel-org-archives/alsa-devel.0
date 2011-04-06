From: Peter Hsiang <Peter.Hsiang@maxim-ic.com>
Subject: Dynamic control commands that match the downloadable
	DSP firmware
Date: Wed, 6 Apr 2011 15:51:49 -0700
Message-ID: <B2150E1E4418E1438554A300EA5040E40DAC774969@ITSVLEX06.it.maxim-ic.internal>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from antispam02.maxim-ic.com (antispam02.maxim-ic.com
	[205.153.101.183])
	by alsa0.perex.cz (Postfix) with ESMTP id 63707103859
	for <alsa-devel@alsa-project.org>;
	Thu,  7 Apr 2011 00:52:41 +0200 (CEST)
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, Liam Girdwood <lrg@slimlogic.co.uk>, Dimitris Papastamos <dp@opensour>
List-Id: alsa-devel@alsa-project.org

Hi Mark and Everyone,

For codecs with a programmable DSP core, one needs to provide the amixer controls for the 'soft' features.  As there could be multiple DSP firmware images for different applications, it would be nice if a single codec driver source can support an unlimited combination of commands for DSP firmware features.  

Rather than hard coding the control commands in the driver directly, wouldn't it be cool if, in addition to the firmware being loaded from file, the control commands information can be loaded from file as well.  Then the driver would dynamically create and install the control commands the same way we already do for the EQ.

What do you think?

Peter
