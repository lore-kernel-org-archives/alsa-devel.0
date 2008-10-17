From: Xarteras <xarteras@nostalgicnetworxx.org>
Subject: Re: Backported sbxfi driver (UNTESTED!)
Date: Fri, 17 Oct 2008 10:35:56 +0000
Message-ID: <48F86A8C.6020309@nostalgicnetworxx.org>
References: <s5hy70xsl46.wl%tiwai@suse.de>	<loom.20081016T120322-319@post.gmane.org>	<s5h8wso3ejg.wl%tiwai@suse.de>	<48F739F4.5070303@nostalgicnetworxx.org>	<48F74344.4090509@gmail.com>	<s5hvdvs1wig.wl%tiwai@suse.de>	<48F74C91.7040708@gmail.com>	<s5hprm01v3g.wl%tiwai@suse.de>	<48F75284.1040901@gmail.com>	<s5hljwo1u01.wl%tiwai@suse.de>	<48F75700.5060102@gmail.com>	<s5hfxmw1syu.wl%tiwai@suse.de>	<48F75892.8000209@gmail.com>	<s5hbpxk1shh.wl%tiwai@suse.de>	<48F7855F.6060806@gmail.com>	<s5hbpxj6902.wl%tiwai@suse.de>	<48F83013.4060203@gmail.com>	<s5h7i8767zu.wl%tiwai@suse.de>	<48F8542E.30702@nostalgicnetworxx.org>	<s5hwsg7zib3.wl%tiwai@suse.de>
	<48F85FE3.4060704@nostalgicnetworxx.org>
	<1224237619.4011.8.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from nostalgicnetworxx.org (snowleopard.nostalgicnetworxx.org
	[87.106.211.229])
	by alsa0.perex.cz (Postfix) with ESMTP id 33D4D24440
	for <alsa-devel@alsa-project.org>;
	Fri, 17 Oct 2008 12:38:13 +0200 (CEST)
In-Reply-To: <1224237619.4011.8.camel@localhost>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Tony Vroon <tony@vroon.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Tony Vroon wrote:
> On Fri, 2008-10-17 at 09:50 +0000, Xarteras wrote:
>> ossplay still crashes though and strace isn't of much use.
>> Running ossplay causes a sys reset so fast the strace output cannot even 
>> be flushed to disk anymore, neverless be up long enough to read it on 
>> the screen.
> 
> A serial console may help you there, assuming you have two machines.

Good idea :)

Just tried it, but even a 115200 baud serial connection isn't fast 
enough to give me more than the first three lines of useless strace 
output before it's back to BIOS.

Jan Wolf
