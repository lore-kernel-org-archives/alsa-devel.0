From: David Henningsson <david.henningsson@canonical.com>
Subject: Re: [PATCH] ALSA: hda - Add position_fix=4 (COMBO)
	option
Date: Tue, 28 Feb 2012 19:02:04 +0100
Message-ID: <4F4D169C.40001@canonical.com>
References: <s5hk437p4t5.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
	[91.189.89.112]) by alsa0.perex.cz (Postfix) with ESMTP id CAB5E246CE
	for <alsa-devel@alsa-project.org>; Tue, 28 Feb 2012 19:02:07 +0100 (CET)
In-Reply-To: <s5hk437p4t5.wl%tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org, "Heasley, Seth" <seth.heasley@intel.com>
List-Id: alsa-devel@alsa-project.org

On 02/28/2012 12:37 PM, Takashi Iwai wrote:
> This patch adds a new position_fix option value, 4, as a combo mode
> to use LPIB for playbacks and POSBUF for captures.  It's the way
> recommended by Intel hardware guys.

Interesting. More specifically, for what chips were this mode 
recommended? There were none added with the patch.

-- 
David Henningsson, Canonical Ltd.
http://launchpad.net/~diwic
