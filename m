From: Peter Hsiang <Peter.Hsiang@maxim-ic.com>
Subject: synchronized block of register writes
Date: Wed, 6 Apr 2011 15:28:10 -0700
Message-ID: <B2150E1E4418E1438554A300EA5040E40DAC77494E@ITSVLEX06.it.maxim-ic.internal>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from antispam01.maxim-ic.com (antispam01.maxim-ic.com
	[205.153.101.182])
	by alsa0.perex.cz (Postfix) with ESMTP id C3010103834
	for <alsa-devel@alsa-project.org>;
	Thu,  7 Apr 2011 00:30:36 +0200 (CEST)
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

When a codec driver control handling function needs to write a group of registers without any other register of the same codec being written to in parallel by ALSA, what is the best way to do this under the snd-soc codec driver architecture?  In the current architecture, does the driver's control handling function execute serially with other ALSA automated activities?

For example, the codec has filter coefficient data registers in a secondary registers "segment"  i.e. a portion of the register map is banked, and the secondary bank is purely for coefficients and they do not require caching.  The coefficient registers share the same register numbers as those in the normal primary segment.  To write the coefficients, one would first write to a register bit to select the desired segment, and then switch back when done.  This means when writing the coefficients, I use the un-cached write.

Thanks in advance for your sound advice.

Peter
