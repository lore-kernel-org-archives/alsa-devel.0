From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 23/38] sound: soc: add missing put_device
	call
Date: Sat, 21 Dec 2013 14:31:12 +0000
Message-ID: <20131221143112.GI30815@sirena.org.uk>
References: <1387465429-3568-2-git-send-email-levex@linux.com>
 <1387465429-3568-24-git-send-email-levex@linux.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id E592F264F0B
 for <alsa-devel@alsa-project.org>; Sat, 21 Dec 2013 15:31:26 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1387465429-3568-24-git-send-email-levex@linux.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Levente Kurusa <levex@linux.com>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, LKML <linux-kernel@vger.kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

On Thu, Dec 19, 2013 at 04:03:34PM +0100, Levente Kurusa wrote:
> This is required so that we give up the last reference to the device.

Applied, thanks.  Please use subject lines matching the standard for the
subsystem.
