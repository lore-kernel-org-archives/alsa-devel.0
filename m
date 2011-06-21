From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: How to implement capture_switch control?
Date: Tue, 21 Jun 2011 02:51:50 +0100
Message-ID: <20110621015149.GA3753@sirena.org.uk>
References: <BANLkTikZYqdQJh6T1_XwpcxcTb=m1qOuUw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id DD2EC245E7
	for <Alsa-devel@alsa-project.org>;
	Tue, 21 Jun 2011 03:51:51 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <BANLkTikZYqdQJh6T1_XwpcxcTb=m1qOuUw@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Adam Jiang <jiang.adam@gmail.com>
Cc: Alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Mon, Jun 20, 2011 at 04:15:38PM +0900, Adam Jiang wrote:

> I have a device with wm8903 codec. To support mute/unmute capture
> signal, I was trying to enable/disable PGA on this codec from user
> space application like

If the hardware does not physically support mute then this should be
emulated in software.  In the case of the WM8903 the device does not
have a specific capture mute control, though extremely low gains are
supported for the Capture Volume control which function as a mute so 
you could also set minimum Capture Volume.

> alwasy return false. I guess something is missing in my driver. Could
> you please give some bright how could I use capture switch to
> mute/unmute a channel. How could I implement capture_switch control
> properly? Thank you!

Not all hardware supports all possible features.  Either configure a
software volume control, the softvol plugin for ALSA should be able to
do this, or adjust your application to handle this in the application
layer.

http://alsa.opensrc.org/How_to_use_softvol_to_control_the_master_volume

has some information on using softvol.
