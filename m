From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: Merged upstream to topic/asoc branch
Date: Mon, 1 Dec 2008 17:06:34 +0000
Message-ID: <20081201170633.GI13758@sirena.org.uk>
References: <s5h8wqzzv8r.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 99CCC2452B
	for <alsa-devel@alsa-project.org>; Mon,  1 Dec 2008 18:06:34 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <s5h8wqzzv8r.wl%tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Mon, Dec 01, 2008 at 06:00:04PM +0100, Takashi Iwai wrote:

> FYI, I merged the current Linus tree back to topic/asoc branch on
> sound git tree for clean-up works including the latest commit in 
> sound/soc/fsl.

> If you have any problems with it, please let me know.

Hrm.  Which compiler are you using?  The WM8903 warning patch you
introduced is not needed on any of my systems (primarily ARM and
x86-64).  It smells like a problem with the BUG() definition on your
platform...
