From: Chris Rankin <rankincj@yahoo.com>
Subject: Re: How much of the X-Fi (emu20k1) chip has Creative
	documented?
Date: Sat, 23 Jan 2010 14:04:12 -0800 (PST)
Message-ID: <161831.52985.qm@web52905.mail.re2.yahoo.com>
References: <20100118172718.07c1053f@darius>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from web52905.mail.re2.yahoo.com (web52905.mail.re2.yahoo.com
	[206.190.49.15]) by alsa0.perex.cz (Postfix) with SMTP id D885F244EC
	for <alsa-devel@alsa-project.org>; Sat, 23 Jan 2010 23:04:14 +0100 (CET)
In-Reply-To: <20100118172718.07c1053f@darius>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Brendan Pike <spike@spykes.net>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

--- On Mon, 18/1/10, Brendan Pike <spike@spykes.net> wrote:
> HWMix also exists and works perfectly,

The last time someone assured me that a card supported HWMix, it turned out that he was using dmix without realising it.

Can you confirm that you can still play two sounds concurrently with the following $HOME/.asoundrc file, please?

pcm.XFi {
    type plug
    slave {
        pcm "hw:0"
    }
}

So you would run the following command simultaneously across two terminals:

$ aplay -D XFi <wav-file>

Cheers,
Chris
