From: James Courtier-Dutton <James@superbug.co.uk>
Subject: Re: dB gain
Date: Mon, 29 May 2006 20:21:44 +0100
Message-ID: <447B49C8.8060007@superbug.co.uk>
References: <4478A290.80702@superbug.co.uk> <s5hverp7zcr.wl%tiwai@suse.de>
	<Pine.LNX.4.61.0605291540430.11164@tm8103-a.perex-int.cz>
	<Pine.LNX.4.61.0605291601230.11164@tm8103-a.perex-int.cz>
	<s5hbqtg9a8a.wl%tiwai@suse.de>
	<Pine.LNX.4.61.0605291630000.11164@tm8103-a.perex-int.cz>
	<447B0F62.6010802@superbug.co.uk> <s5hzmh0deir.wl%tiwai@suse.de>
	<Pine.LNX.4.61.0605292031100.11164@tm8103-a.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from anchor-post-32.mail.demon.net (anchor-post-32.mail.demon.net
	[194.217.242.90])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id B0E3D150
	for <alsa-devel@alsa-project.org>;
	Mon, 29 May 2006 21:21:45 +0200 (MEST)
In-Reply-To: <Pine.LNX.4.61.0605292031100.11164@tm8103-a.perex-int.cz>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Jaroslav Kysela <perex@suse.cz>
Cc: Takashi Iwai <tiwai@suse.de>, ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Jaroslav Kysela wrote:
>>
>> But, still it won't save so much memory at all, given that we have at
>> most 100 controls with volumes...
> 
> Sorry, I was looking to the proposed patch very quickly so my ideas were
> based on old implementation which is #if 0 #endifed for alsa-lib (there 
> was only one 32-bit hint value specifying the dB expression).

Yes, I dropped the 32-bit hint value as a result of your comments some
time ago.

The latest patch does things quite a lot differently.

James
