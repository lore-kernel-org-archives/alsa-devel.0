From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: mic bias for tlv320aic3x?
Date: Tue, 27 Nov 2012 17:53:26 +0000
Message-ID: <20121127175326.GB13065@sirena.org.uk>
References: <alpine.DEB.2.01.1211271808130.20477@pmeerw.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 4DDDD26157F
 for <alsa-devel@alsa-project.org>; Tue, 27 Nov 2012 18:53:27 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.01.1211271808130.20477@pmeerw.net>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Peter Meerwald <pmeerw@pmeerw.net>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Tue, Nov 27, 2012 at 06:15:27PM +0100, Peter Meerwald wrote:

> I'd like to enable 2V mic bias on the tlv320aic3x (which offers 2V, 2.5V, 
> AVDD, off) -- I'd have expected some control in alsamixer to so, but there 
> is none

> what is the proper way to implement mic bias selection?

As platform data or possibly via an API offered to the machine driver,
we've yet to see any use case where it's something that should be varied
directly from the application layer.

Always CC maintainers...
