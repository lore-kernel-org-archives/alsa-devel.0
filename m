From: Stephen Warren <swarren@wwwdotorg.org>
Subject: Re: HDA codec in embedded device
Date: Thu, 31 May 2012 10:02:21 -0600
Message-ID: <4FC7960D.6000405@wwwdotorg.org>
References: <20120531061302.GA11605@avionic-0098.adnet.avionic-design.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from avon.wwwdotorg.org (avon.wwwdotorg.org [70.85.31.133])
	by alsa0.perex.cz (Postfix) with ESMTP id 4F5A1104424
	for <alsa-devel@alsa-project.org>;
	Thu, 31 May 2012 18:02:27 +0200 (CEST)
In-Reply-To: <20120531061302.GA11605@avionic-0098.adnet.avionic-design.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Thierry Reding <thierry.reding@avionic-design.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 05/31/2012 12:13 AM, Thierry Reding wrote:
> Hi,
> 
> I work on an Atom-based platform that uses a Realtek ALC892 codec connected
> via HDA. The current code in patch_realtek.c seems to assume a standard
> desktop setup and maps the ports accordingly. The setup that I have is
> entirely different and involves, among other things, to reconfigure some of
> the ports typically used as outputs as inputs and vice versa. It'll also need
> to provide a way to pass through some inputs on the outputs without going
> through the DAC.
> 
> All of these features are supported by the ALC982, but I don't see how this
> could be implemented with the current driver. My question is how this could
> possibly be solved in a way acceptable for mainline?

The way I solved this was to add a machine-specific fixup rto
alc269_fixups[] that set up the pin default registers as required by the
HW prior to the parser interpreting those fields. I assume the same
would work on the alc982.

I think in general as Takashi mentioned, the driver assumes that the pin
default registers are already set up to values correct for the HW.
Typically, I believe this is done by the SBIOS or audio card BIOS prior
to the OS starting, or perhaps by EEPROM/straps in the HW. Is there a
way that can be made to happen?
