From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: Re: [PATCHv3 00/20] OMAP ASoC changes in DMA
	utilization
Date: Mon, 17 Aug 2009 11:22:30 +0300
Message-ID: <200908171122.30731.peter.ujfalusi__38611.2193963074$1250497386$gmane$org@nokia.com>
References: <1250174133-451-1-git-send-email-eduardo.valentin@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <1250174133-451-1-git-send-email-eduardo.valentin@nokia.com>
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Linux-OMAP <linux-omap@vger.kernel.org>, ALSA-Devel <alsa-devel@vger.kernel.org>, "Nurkkala Eero.An (EXT-Offcode/Oulu)" <ext-Eero.Nurkkala@nokia.com>
List-Id: alsa-devel@alsa-project.org

On Thursday 13 August 2009 17:35:13 Valentin Eduardo (Nokia-D/Helsinki) wrote:
> Hello again guys,
>
> Here is version 3 of these changes. I've changed just 2
> things:
> - all mcbsp instances are in element mode by default
> - moved all mcbsp related code to omap-mcbsp.c
> (although a single callback is still needed)
>
> Jarkko, I think we can add your patch for reading strings
> for dma op mode later on.

In my opinion we can take this series as it is now, what do you think Jarkko?
At least I don't see too (any?) big problems with it...


Acked-by: Peter Ujfalusi <peter.ujfalusi@nokia.com>

