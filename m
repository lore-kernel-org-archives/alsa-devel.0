From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Attempts on the ESS-1869 card (one more time)
Date: Mon, 03 May 2004 10:00:53 +0200 (METDST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.HPX.4.33n.0405030952410.11208-100000@studcom.urz.uni-halle.de>
References: <20040502084829.56484.qmail@web60801.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: <20040502084829.56484.qmail@web60801.mail.yahoo.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: tsw@johana.com
Cc: alsa development <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Tom Watson wrote:
> Well, I've gone to another Compaq laptop.  The previous one I had to
> resort to OSS (yuck) drivers and send it on its way.  This laptop is
> one I'm going to use, so I'd like to get ALSA working on it.
>
> So...  I've loaded ALSA and put the following in 'modules.conf':
> alias char-major-116 snd
> alias snd-card-0 snd-es18xx
> options snd-es18xx index=1

This is sound card 0, so use index=0.

> id=1

The id cannot be a number.  But ALSA has a sensible default anyway, so
you don't need to specify this.

> fm_port=0x338

  fm_port=0x388

> dma1=1 dma2=0

Does your card really use 1/0 and not 0/1?
(To disable a dma channel, specify -1.)

> But alas, nothing works.

What exactly doesn't work?  Error messages when trying to load the
driver?  No sound?  Green demons coming out of your speakers?  ;-)


HTH
Clemens




-------------------------------------------------------
This SF.Net email is sponsored by: Oracle 10g
Get certified on the hottest thing ever to hit the market... Oracle 10g. 
Take an Oracle 10g class now, and we'll give you the exam FREE.
http://ads.osdn.com/?ad_id=3149&alloc_id=8166&op=click
