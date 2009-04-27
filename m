From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: Driver code with mpc5200 pointer problem.
Date: Mon, 27 Apr 2009 16:15:12 +0100
Message-ID: <20090427151512.GI20591@sirena.org.uk>
References: <9e4733910904270650g204d2660y7e3b9ea03446a752@mail.gmail.com>
	<20090427135737.GA20591@sirena.org.uk>
	<9e4733910904270702w317c8c62vbee38230979ad121@mail.gmail.com>
	<20090427140554.GB20591@sirena.org.uk>
	<9e4733910904270716v289e6d5exaf6e17331786ea11@mail.gmail.com>
	<20090427142437.GF20591@sirena.org.uk>
	<9e4733910904270742l751e660bg66844b98fe261f23@mail.gmail.com>
	<s5h4owa5f1y.wl%tiwai@suse.de>
	<9e4733910904270804k6ed079d4h16b433b6f8a06fc7@mail.gmail.com>
	<alpine.LNX.2.00.0904271707000.25064@eeebox2.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 54CD424590
	for <alsa-devel@alsa-project.org>;
	Mon, 27 Apr 2009 17:15:14 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <alpine.LNX.2.00.0904271707000.25064@eeebox2.perex-int.cz>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jaroslav Kysela <perex@perex.cz>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel mailing list <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Mon, Apr 27, 2009 at 05:09:27PM +0200, Jaroslav Kysela wrote:

> Appearently, FIFO is too big. I'm working on some changes to take account 
> fifo_size to the jiffies based check. Please, set fifo_size correctly in 
> your driver. USB drivers with big "URB FIFOs" should be changed as well, 
> too.

Could you expand a bit on what qualifies as "too big" here?  I've not
been following the thread here or the changes that caused problems.
