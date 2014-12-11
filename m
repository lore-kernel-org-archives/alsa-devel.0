From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: wm8750: Make VREF a VMID instead of
	OUTPUT widget
Date: Thu, 11 Dec 2014 09:54:03 +0000
Message-ID: <20141211095403.GH14516@opensource.wolfsonmicro.com>
References: <1418034191-28010-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 7941326061E
 for <alsa-devel@alsa-project.org>; Thu, 11 Dec 2014 10:54:05 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1418034191-28010-1-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, patches@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

On Mon, Dec 08, 2014 at 11:23:11AM +0100, Lars-Peter Clausen wrote:
> Commit 04489eeb02a4 ("ALSA: wm8750: add missing VREF output") added the
> previously missing VREF widget. And while adding the widget as OUTPUT widget
> silences the error of the missing widget it should have rather been a VMID
> widget.
> 
> The VREF widget is only used internally as a source for the VREF input of
> the Out3 Mux. Selecting that input means that the path should be kept
> powered up at the VREF/VMID voltage, but that there is no actual audio
> signal. Using a VMID widget will do this, whereas using a OUTPUT widget will
> simply cause the path to completely power down.
> 
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
> ---

Acked-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>

Thanks,
Charles
