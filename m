From: James Pearson <james-p@moving-picture.com>
Subject: Re: alsa-driver-1.0.15rc2 build issues on RHEL4/CentOS4
Date: Tue, 09 Oct 2007 12:58:09 +0100
Message-ID: <470B6CD1.5020506@moving-picture.com>
References: <46EA5F30.7000404@moving-picture.com>	<s5hwsutkq6o.wl%tiwai@suse.de>	<46F9353C.1040105@moving-picture.com>	<46FA47A2.3020205@moving-picture.com>
	<s5hve9gtwis.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from moving-picture.com (mpc-26.sohonet.co.uk [193.203.82.251])
	by alsa0.perex.cz (Postfix) with ESMTP id 2C13724682
	for <alsa-devel@alsa-project.org>;
	Tue,  9 Oct 2007 13:58:10 +0200 (CEST)
In-Reply-To: <s5hve9gtwis.wl%tiwai@suse.de>
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
Cc: ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Takashi Iwai wrote:
> 
> Thanks, I fixed it with #ifdef CONFIG_SND_BIT32_EMUL_MODULE.
> These shouldn't be exported unconditionally.
> 
> Also, some entries in kconfig_vers are changed as you suggested on HG
> tree.
> 
> Hope now it works...

Not quite - the patch at:

<http://hg.alsa-project.org/alsa-driver/raw-diff/4dd14b787ef1/acore/control.patch>

adds EXPORT_SYMBOL(snd_ctl_elem_read) twice - but doesn't add 
EXPORT_SYMBOL(snd_ctl_elem_write) ...

Thanks

James Pearson
