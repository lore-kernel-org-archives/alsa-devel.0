From: Adrian Knoth <adi@drcomp.erfurt.thur.de>
Subject: Re: hdspmixer broken for 96khz
Date: Mon, 4 Apr 2011 12:01:32 +0200
Message-ID: <20110404100132.GQ28811@ltw.loris.tv>
References: <in74oi$qce$1@dough.gmane.org> <201104031139.41395.tim@klingt.org>
	<s5hr59imoqt.wl%tiwai@suse.de> <201104041005.58890.tim@klingt.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ltw.loris.tv (ltw.loris.tv [85.14.220.160])
	by alsa0.perex.cz (Postfix) with ESMTP id B1367103828
	for <alsa-devel@alsa-project.org>;
	Mon,  4 Apr 2011 12:01:40 +0200 (CEST)
Received: from localhost (ltw.loris.tv [127.0.0.1])
	by ltw.loris.tv (Postfix) with ESMTP id CA41B1AC360
	for <alsa-devel@alsa-project.org>;
	Mon,  4 Apr 2011 12:01:39 +0200 (CEST)
Received: from ltw.loris.tv ([127.0.0.1])
	by localhost (ltw.loris.tv [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id cu+H-FMqCrem for <alsa-devel@alsa-project.org>;
	Mon,  4 Apr 2011 12:01:32 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <201104041005.58890.tim@klingt.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Mon, Apr 04, 2011 at 10:05:58AM +0200, Tim Blechmann wrote:

> > Any chance to recover the old broken configuration?
> > Then we can track down the bug.
> attached

This isn't the old configuration, it's the new one. (it has my new magic
code "HDSPMixer v1" right at the beginning)

The foremost question is: when did you wrote your old configuration
file?

What I tried so far: checked out tag 1.0.24, created a conf file, then
checked out HEAD. As expected, hdspmixer correctly loads the file,
switching samplerates works.

Since I only have a RayDAT at hand right now, I cannot test with
anything older than 1.0.24 (to be precise, older than commit
e24e56795ea57e3dd7da45063ab71f04e231192d)

But what I can say for sure is: if you used hdspmixer before 1.0.24 on a
non-MADI card like Multiface/Digiface, loading this preset file in
1.0.24 would break the configuration. Is this what we're talking about?

Reason: defines.h contains HDSP_MAX_CHANNELS, it was 26 until adding
support for MADI cards, bumping this value to 64. And now let's have a
look at the preset load/restore code:

    for (int speed = 0; speed < 3; ++speed) {
	for (int card = 0; card < MAX_CARDS; ++card) {
	    for (int preset = 0; preset < 8; ++preset) {
		for (int channel = 0; channel < HDSP_MAX_CHANNELS; ++channel) {
		    /* inputs pans and volumes */
		    if (fread((void
*)&(inputs->strips[channel]->data[card][speed][preset]->pan_pos[0]),
sizeof(int), 14, file) != 14) {
			goto load_error;
		    }
		    if (fread((void
*)&(inputs->strips[channel]->data[card][speed][preset]->fader_pos[0]),
sizeof(int), 14, file) != 14) {
			goto load_error;
		    }

As I said earlier, the ondisk format is a pure 1:1 memory dump without
any meta information, just an array of integers.

Now that HDSP_MAX_CHANNELS has changed, the size of the final memory
dump differs and different values end up in different places.

The only possible way to circumvent this is to check the file size.
3*3*8*26*some_constant is different than 3*3*8*64*some_constant, and we
would be able to guess if it's a pre-1.0.24 preset file or a newer one.


Cheers

-- 
mail: adi@thur.de  	http://adi.thur.de	PGP/GPG: key via keyserver
