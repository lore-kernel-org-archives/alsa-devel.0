From: Niklas Werner <bergtroll@gmx.li>
Subject: Re: usb-audio
Date: Wed, 29 Oct 2003 23:26:07 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200310292326.08018.bergtroll@gmx.li>
References: <20031027180300.GA5016@Zeryn> <200310282018.35309.bergtroll@gmx.li> <s5h8yn3zyv0.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5h8yn3zyv0.wl@alsa2.suse.de>
Content-Disposition: inline
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

Am Mittwoch, 29. Oktober 2003 19:24 wurde geschrieben:
> At Tue, 28 Oct 2003 20:18:35 +0100,
>
>
> hmm, it seems that a wrong label is used.  the label should be
> conv_xx12_xx21 (= conv_labels[35]).  something is really broken.
>
> could you check stepwise the loop there?
>

still checking (any tips on speeding this up (I'm trying "step 80000" 
atm?), seems to happen after the first set of frames (=16384) is 
processed.
the label stays wrong throughout the whole loop, the convidx stays 35


> thanks for check.
> can you hear a clear sound with aplay -M ?
>
Yes :-)


Niklas



-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?   SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
