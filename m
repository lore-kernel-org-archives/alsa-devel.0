From: "Hennerich, Michael" <Michael.Hennerich@analog.com>
Subject: RE: [alsa-devel] [PATCH 5/8] ASoC: Fix BUGS in Blackfin AC97 DAI
Date: Tue, 18 Nov 2008 11:58:55 -0000
Message-ID: <8A42379416420646B9BFAC9682273B6D0693623D@limkexm3.ad.analog.com>
References: <1226996302-10234-1-git-send-email-cooloney@kernel.org> <1226996302-10234-6-git-send-email-cooloney@kernel.org> <20081118115426.GG23217@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1752681AbYKRL74@vger.kernel.org>
Content-class: urn:content-classes:message
In-Reply-To: <20081118115426.GG23217@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@sirena.org.uk>, Bryan Wu <cooloney@kernel.org>
Cc: tiwai@suse.de, Cliff Cai <cliff.cai@analog.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Michael Hennerich <michael.hennerich@analog.com>
List-Id: alsa-devel@alsa-project.org

>> sport_handle is a global and not allocated my kmalloc.
>
>There's no reference to sport_handle in the patch...

Sorry - spurious comment please ignore.

-Michael

>-----Original Message-----
>From: Mark Brown [mailto:broonie@sirena.org.uk]
>Sent: Tuesday, November 18, 2008 12:54 PM
>To: Bryan Wu
>Cc: tiwai@suse.de; Cliff Cai; alsa-devel@alsa-project.org; linux-
>kernel@vger.kernel.org; Michael Hennerich
>Subject: Re: [alsa-devel] [PATCH 5/8] ASoC: Fix BUGS in Blackfin AC97
DAI
>
>On Tue, Nov 18, 2008 at 04:18:19PM +0800, Bryan Wu wrote:
>> From: Michael Hennerich <michael.hennerich@analog.com>
>
>> sport_handle is a global and not allocated my kmalloc.
>
>There's no reference to sport_handle in the patch...
>
>> A probe function should have a clean return 0 path.
>
>...only this.
