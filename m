From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Problem with setting software parameters.
Date: Thu, 28 Apr 2005 10:49:04 +0200 (METDST)
Message-ID: <Pine.HPX.4.33n.0504281032520.16383-100000@studcom.urz.uni-halle.de>
References: <20050428072218.37233.qmail@web60801.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <20050428072218.37233.qmail@web60801.mail.yahoo.com>
Sender: alsa-devel-admin@lists.sourceforge.net
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
> Back a few versions ago (0.9.6) I had a successful program that worked quite
> well (or at least it didn't have an error like this!).  Now I am updating to
> FC3 and 1.0.8 and with the same source (I swear!!) I'm getting errors when I
> attempt to set the software parameters.
>
> snd_pcm_sw_params: params->avail_min problem for start_threshold
>
> Period_size: 4410
> Buffer_size: 16384
> Avail_min: 4410
> Start_threshold: 16384
>
> Upon looking at the source in pcm.c around line 824 there are some calculations
> for flagging the error, but I don't see the problem.

You've tried to set the start_threshold, but this value doesn't
actually cause the PCM to be started.  When you've written three
periods (13230 = 3*4410 frames), the PCM is not yet started because
the start_threshold hasn't been reached, but you cannot write more
data because the number of available frames (3154 = 16384-13230) is
less than avail_min.

It is recommended to round start_threshold to an integer multiple of
avail_min (and xfer_align), which is in most cases (like here) the
same as the period size.

> Dis something change behind my back?

I guess the new driver has a different buffer size, but this didn't
change behind your back because you installed the new driver yourself.
;-)


HTH
Clemens



-------------------------------------------------------
SF.Net email is sponsored by: Tell us your software development plans!
Take this survey and enter to win a one-year sub to SourceForge.net
Plus IDC's 2005 look-ahead and a copy of this survey
Click here to start!  http://www.idcswdc.com/cgi-bin/survey?id=105hix
