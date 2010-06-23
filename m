From: Daniel Mack <daniel@caiaq.de>
Subject: Re: force snd-usb-audio to use "Vendor Specific Class"
Date: Wed, 23 Jun 2010 15:42:05 +0200
Message-ID: <20100623134205.GD2698@buzzloop.caiaq.de>
References: <1277299765.22499.42.camel@zwerg>
	<20100623133640.GC2698@buzzloop.caiaq.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from buzzloop.caiaq.de (buzzloop.caiaq.de [212.112.241.133])
	by alsa0.perex.cz (Postfix) with ESMTP id 82E801038F7
	for <alsa-devel@alsa-project.org>;
	Wed, 23 Jun 2010 15:42:11 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20100623133640.GC2698@buzzloop.caiaq.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Alexey Fisher <bug-track@fisher-privat.net>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Wed, Jun 23, 2010 at 03:36:40PM +0200, Daniel Mack wrote:
> On Wed, Jun 23, 2010 at 03:29:25PM +0200, Alexey Fisher wrote:
> > is there any way to force snd-usb-audio to use some "Vendor Specific
> > Class" device?
> > i currently got two webcams from my friends to take a look on. They are
> > cheep gspca based webcams with Mic. I wont to test if snd-usb-audio can
> > use it if i force it. Devices it self do not provide any hints for the
> > driver.
> 
> Sure. Just grep for 'bInterfaceProtocol' in sound/usb/* and patch all
> places where this field is parsed.

Sorry, I got you wrong. I think you should just need an extra entry in
quirks-table.h and quirks.c - other devices do similar things already.

Daniel
