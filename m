From: mru@users.sourceforge.net (=?iso-8859-1?q?M=E5ns_Rullg=E5rd?=)
Subject: Re: aplay not playing MPEG
Date: Mon, 21 Jul 2003 23:55:27 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <yw1xfzkzfsts.fsf@zaphod.guide>
References: <20030721144218.92.h004.c012.wm@mail.icqmail.com.criticalpath.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

"Eliot Blennerhassett" <bigblen@icqmail.com> writes:

> Can aplay/alsa send raw MPEG data to a card?
>
>   aplay -Dhw:0  -v -t raw --channels=2 --format=MPEG --rate=44100 ~/audio/44khz
>   Playing raw data '/home/eliot/audio/44khz' : MPEG, Rate 44100 Hz, Stereo
>   aplay: set_params:805: Sample format non available
>
> This command works fine if I specify S16_LE, S23, FLOAT, S24, but
> not MPEG.  Any suggestions as to whe - do I have a hope of making it
> work?  (My card supports all the above including MPEG in exactly the
> same way as far as ALSA driver is concerned)

What model is your card?  Are you sure that it really supports mpeg,
and that it isn't just a windows driver faking it for marketing
reasons?

-- 
Måns Rullgård
mru@users.sf.net



-------------------------------------------------------
This SF.net email is sponsored by: VM Ware
With VMware you can run multiple operating systems on a single machine.
WITHOUT REBOOTING! Mix Linux / Windows / Novell virtual machines at the
same time. Free trial click here: http://www.vmware.com/wl/offer/345/0
