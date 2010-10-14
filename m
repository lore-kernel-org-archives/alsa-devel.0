From: Julian Scheel <julian@jusst.de>
Subject: Re: USB asynchronous mode feedback format
Date: Thu, 14 Oct 2010 14:56:51 +0200
Message-ID: <201010141456.51974.julian@jusst.de>
References: <1287046026.4cb6c38a2a179@discus.singnet.com.sg>
	<201010141430.43967.julian@jusst.de>
	<20101014123322.GN7159@buzzloop.caiaq.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp2.work.de (smtp.work.de [212.12.45.188])
	by alsa0.perex.cz (Postfix) with ESMTP id 5FCAC24383
	for <alsa-devel@alsa-project.org>;
	Thu, 14 Oct 2010 14:56:53 +0200 (CEST)
Received: from [127.0.0.1] (helo=juli-workstation.localnet)
	by smtp2.work.de with esmtpa (Exim 4.69)
	(envelope-from <julian@jusst.de>) id 1P6NMa-0000vg-LA
	for alsa-devel@alsa-project.org; Thu, 14 Oct 2010 14:56:52 +0200
In-Reply-To: <20101014123322.GN7159@buzzloop.caiaq.de>
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
List-Id: alsa-devel@alsa-project.org

Am Donnerstag, 14. Oktober 2010, 14:33:22 schrieb Daniel Mack:
> On Thu, Oct 14, 2010 at 02:30:43PM +0200, Julian Scheel wrote:
> > Am Donnerstag, 14. Oktober 2010, 14:06:41 schrieb Daniel Mack:
> > > Yes, that looks suspicious, especially because it doesn't only affect
> > > the lower bits. What do you need this sample rate converter for,
> > > anyway? Can't you feed your signals directly to the DAC? FMT0 and FMT1
> > > should both be set to 0.
> > 
> > You mean OFMT0 and OFMT1? Imho they should be 1,0 for I2S. Or did you
> > refer to the DAC? In that case FMT0 and FMT1 both are set to 0.
> 
> Jup, I was talking about the DAC.

I have the SRC in there to be able to always feed that DAC with 192kHz, as it 
performs best in that mode and allows usage of a slow roll-off filter then.
Anyway, I tried to directly feed the DAC module as well, but it does not 
produce any output so far... Not sure what's wrong there.
As the dac is a current output dac, I am not sure whether it really does not 
output any signal, or if the current->voltage conversion does not work.

Julian
