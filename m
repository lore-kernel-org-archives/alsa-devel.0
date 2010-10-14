From: Daniel Mack <daniel@caiaq.de>
Subject: Re: USB asynchronous mode feedback format
Date: Thu, 14 Oct 2010 14:33:22 +0200
Message-ID: <20101014123322.GN7159@buzzloop.caiaq.de>
References: <1287046026.4cb6c38a2a179@discus.singnet.com.sg>
	<201010141332.37735.julian@jusst.de>
	<20101014120641.GM10432@buzzloop.caiaq.de>
	<201010141430.43967.julian@jusst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from buzzloop.caiaq.de (buzzloop.caiaq.de [212.112.241.133])
	by alsa0.perex.cz (Postfix) with ESMTP id D92BC2414C
	for <alsa-devel@alsa-project.org>;
	Thu, 14 Oct 2010 14:33:25 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <201010141430.43967.julian@jusst.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Julian Scheel <julian@jusst.de>
Cc: alsa-devel@alsa-project.org, lee188@singnet.com.sg
List-Id: alsa-devel@alsa-project.org

On Thu, Oct 14, 2010 at 02:30:43PM +0200, Julian Scheel wrote:
> Am Donnerstag, 14. Oktober 2010, 14:06:41 schrieb Daniel Mack:
> > Yes, that looks suspicious, especially because it doesn't only affect
> > the lower bits. What do you need this sample rate converter for, anyway?
> > Can't you feed your signals directly to the DAC? FMT0 and FMT1 should
> > both be set to 0.
> 
> You mean OFMT0 and OFMT1? Imho they should be 1,0 for I2S. Or did you refer to 
> the DAC? In that case FMT0 and FMT1 both are set to 0.

Jup, I was talking about the DAC.

Daniel
