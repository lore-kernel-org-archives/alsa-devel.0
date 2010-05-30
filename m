From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: [patch 0/6] kirkwood openrd client audio support - v4
Date: Sun, 30 May 2010 16:44:47 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.1005301638420.24526@xanadu.home>
References: <20100527125737.524554667@mandriva.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-reply-to: <20100527125737.524554667@mandriva.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: apatard@mandriva.com
Cc: alsa-devel@alsa-project.org, broonie@opensource.wolfsonmicro.com, saeed@marvell.com, tbm@cyrius.com, linux-arm-kernel@lists.infradead.org, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

On Thu, 27 May 2010, apatard@mandriva.com wrote:

> 
> Hi,
> 
> This patchset is an other try to get merged openrd audio support mainline.
> The main change is going back to using kirkwood instead of orion, as the 
> only orion having i2s is not merged mainline (if I got it right).

Right.

> I've also fixed the lastests comments on the cs42l51 codec patch.
> 
> Arnaud
> 
> Changes :
> - changed back from orion to kirkwood
> - removed cs42l51 adc input register initialisation
> - moved the DAPM event macro to soc-dapm
> - fixed cs42l51_set_dai_fmt() master/slave check
> - removed cs42l51 startup message
> - use snd_soc_update_bits() in cs42l51_pdn_event()

I acked the first patch which touches directly the directory I normally 
handle patches for.  Given the series is mostly about ASOC stuff, I 
think it is best if the whole series, including the first patch, is 
pushed through the ASOC tree (if Mark agrees with the rest that is of 
course).


Nicolas
