From: Chris Rankin <rankincj@yahoo.com>
Subject: Re: Linux 2.6.22 and SB-Live! - broken microphone
	capture?
Date: Thu, 9 Aug 2007 02:03:05 +0100 (BST)
Message-ID: <766049.99404.qm@web52912.mail.re2.yahoo.com>
References: <20070809022429.Q9639-100000@xs2.xs4all.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from web52912.mail.re2.yahoo.com (web52912.mail.re2.yahoo.com
	[206.190.49.22]) by alsa0.perex.cz (Postfix) with SMTP id CC83B10384B
	for <alsa-devel@alsa-project.org>;
	Thu,  9 Aug 2007 03:03:06 +0200 (CEST)
In-Reply-To: <20070809022429.Q9639-100000@xs2.xs4all.nl>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Stefan de Konink <skinkie@xs4all.nl>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

--- Stefan de Konink <skinkie@xs4all.nl> wrote:
> On Thu, 9 Aug 2007, Chris Rankin wrote:
> 
> > The microphone works, is plugged into the correct slot, and (AFAICT) all the mixer settings
> are
> > correct:
> >
> > - playback AC97 = 0
> > - capture AC97 = 100
> > - mic select = mic1
> > - mic set to capture
> > - capture volume = 100, and set to capture
> 
> Is it possible something like 'Digital' is set muted/unmuted?

Thanks, but I think this is a false alarm. When I cold-booted this PC, I found that the
snd-emu10k1 driver started refusing to load. Apparently the AC97 codec was failing to initialise
(suddenly). Removing the card, rebooting, shutting down and replacing the card seems to have done
the trick, for now at least.

My only problem now is that I don't know what caused the problem in the first place. Could
scanning the i2c bus for sensors do this? Considering that whatever happened couldn't be fixed by
a cold boot alone.

Cheers,
Chris



      ___________________________________________________________ 
Yahoo! Mail is the world's favourite email. Don't settle for less, sign up for
your free account today http://uk.rd.yahoo.com/evt=44106/*http://uk.docs.yahoo.com/mail/winter07.html 
