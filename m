From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: [PATCH 0/8]ALSA: ASoc: DaVinci: cleanup
Date: Wed, 24 Dec 2008 14:44:14 +0000
Message-ID: <20081224144413.GA1091@sirena.org.uk>
References: <1229629006-4261-1-git-send-email-troy.kisky@boundarydevices.com>
	<FF55437E1F14DA4BAEB721A458B670170622FF42ED@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 96BFB2434E
	for <alsa-devel@alsa-project.org>; Wed, 24 Dec 2008 15:44:18 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <FF55437E1F14DA4BAEB721A458B670170622FF42ED@dbde02.ent.ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "Medisetty, Naresh" <naresh@ti.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "davinci-linux-open-source@linux.davincidsp.com" <davinci-linux-open-source@linux.davincidsp.com>, Troy Kisky <troy.kisky@boundarydevices.com>
List-Id: alsa-devel@alsa-project.org

On Wed, Dec 24, 2008 at 12:06:56PM +0530, Medisetty, Naresh wrote:
> Mark,

> > DAI mode should always produce the same effect in hardware no matter 
> > which device is being configured.  This makes the code much easier to 

> From this I came to conclusion in ASoC Normal FS means active high
> and Normal BCLK means receive data sampled on rising edge and transmit 
> data driven on falling edge. Correct me if I am wrong here.

No.  It means whatever is standard for the mode (DSP, I2S, left
justified and so on) that the DAI is operating in.  For DSP mode the
above is accurate but the others differ.  The reason why the same
case statement is used for all modes in the DaVinci mode is that when
I2S mode is selected the user provided bit/frame inversion options are
changed before they are used.
