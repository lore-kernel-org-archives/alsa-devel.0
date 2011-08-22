From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: about UCM on bluetooth headset
Date: Mon, 22 Aug 2011 15:25:08 +0100
Message-ID: <20110822142508.GA26317@sirena.org.uk>
References: <20110822061911.GA7993@guanqun-laptop.sh.intel.com>
	<4E52336A.6060007@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 9B2A924597
	for <alsa-devel@alsa-project.org>;
	Mon, 22 Aug 2011 16:25:14 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <4E52336A.6060007@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@ti.com>
Cc: ALSA devel <alsa-devel@alsa-project.org>, Lu Guanqun <guanqun.lu@intel.com>
List-Id: alsa-devel@alsa-project.org

On Mon, Aug 22, 2011 at 11:46:02AM +0100, Liam Girdwood wrote:
> On 22/08/11 07:19, Lu Guanqun wrote:

> > 	* a conversation etc. The device describes the physical audio capture and playback
> > 	* hardware i.e. headphones, phone handset, bluetooth headset, etc.

> > Could you shed some lights on this? What's the best practises to use UCM
> > with bluetooth?

> This is intended for systems where the BT audio is integrated in some
> way with the other audio ICs. It's intended to configure the other
> audio devices to allow use cases involving BT in such systems.

Specifically it's for BT SCO (in call 8kHz headset modes).  In call
audio generally doesn't go through the CPU, the BT device has a path to
the baseband via some other route which is typically similar to or part
of the connection the CODEC has which bypasses the CPU entirely allowing
the CPU to be suspended.

[Liam, your mailer still isn't word wrapping within paragraphs.]
