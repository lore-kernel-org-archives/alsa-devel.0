From: Jean Delvare <khali@linux-fr.org>
Subject: Re: [PATCH] AOA: Convert onyx and tas codecs to
 new-style i2c drivers
Date: Thu, 16 Apr 2009 09:53:39 +0200
Message-ID: <20090416095339.5cd026a0@hyperion.delvare>
References: <20090408150249.5a62a56c@hyperion.delvare>
	<1239205899.16477.32.camel@johannes.local>
	<20090408224858.04cb6dc4@hyperion.delvare>
	<1239263089.24548.30.camel@johannes.local>
	<20090409141945.116772e3@hyperion.delvare>
	<20090410170238.6cc3a420@hyperion.delvare>
	<20090414163741.2a98b5d6@hyperion.delvare>
	<s5h1vrv2t0t.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from services.gcu-squad.org (zone0.gcu-squad.org [212.85.147.21])
	by alsa0.perex.cz (Postfix) with ESMTP id 8DC3110381E
	for <alsa-devel@alsa-project.org>;
	Thu, 16 Apr 2009 09:54:00 +0200 (CEST)
In-Reply-To: <s5h1vrv2t0t.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: linuxppc-dev@ozlabs.org, Johannes Berg <johannes@sipsolutions.net>, alsa-devel@alsa-project.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>
List-Id: alsa-devel@alsa-project.org

On Tue, 14 Apr 2009 16:45:38 +0200, Takashi Iwai wrote:
> Johannes, please let me know if the patch works.  Then I'll merge them.

Note if it matters: the new I2C binding model my patch uses is only
available since kernel 2.6.26.

-- 
Jean Delvare
