From: Andy Shevchenko <andy@smile.org.ua>
Subject: Re: ACER Aspier 5630 (snd-hda-intel ALC883)
Date: Sat, 26 Jan 2008 20:45:36 +0200
Message-ID: <20080126184535.GL1177@serv.smile.org.ua>
References: <14cea40a0801260447h5582a1cflc05670c7d0077a45@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from serv.smile.org.ua (serv.smile.org.ua [193.178.237.153])
	by alsa0.perex.cz (Postfix) with ESMTP id 6360124770
	for <alsa-devel@alsa-project.org>; Sat, 26 Jan 2008 19:45:40 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <14cea40a0801260447h5582a1cflc05670c7d0077a45@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Marcin Floryan <marcin.floryan@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi Marcin Floryan!

 On Sat, Jan 26, 2008 at 12:47:50PM +0000, Marcin Floryan wrote next:

> I have had some problems using alsa sound on openSuse 10.3 wit the
> above hardware: sound output OK but mic not working. Have seen many
> relevant bugs and with the new driver the microphone is now working OK
> so thanks for all the effort.
> 
> I was wondering now if there is anything I could do to help with
> driver development to fine-tune for this particular hardware setup. I
> can provide some further details or do some tests if guided a bit (I
> am fairly comfortable modifying source code and compiling the driver)
First off, try to choose all models for the given codec (see
Documentation/ALSA-Configuration.txt) one by one and test it. If some model
provides mic work - post it here with the PCI SSID of your sound card.

-- 
With best regards,
Andy Shevchenko.      mailto: andy@smile.org.ua
