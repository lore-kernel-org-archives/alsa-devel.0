From: Alan Horstmann <gineera@aspect135.co.uk>
Subject: Re: Re: mpu401_uart -how to set for output only?
Date: Wed, 24 May 2006 16:21:14 +0100
Message-ID: <200605241621.14432.gineera@aspect135.co.uk>
References: <200605191151.24428.gineera@aspect135.co.uk> <200605231044.41691.gineera@aspect135.co.uk> <s5hodxpx9rr.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hodxpx9rr.wl%tiwai@suse.de>
Content-Disposition: inline
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Tuesday 23 May 2006 12:26, you wrote:

> My bad.  The input and output are swapped at calling
> snd_rawmidi_new().
>
> I committed the fixed change to HG repo now.  Please use HG repo
> instead.

That was it!  Great.  Swapped input and output arguments, and code functions 
with MPU401_INFO_OUTPUT as expected.

Patch for ice1712 next, as separate thread.

Alan



-------------------------------------------------------
All the advantages of Linux Managed Hosting--Without the Cost and Risk!
Fully trained technicians. The highest number of Red Hat certifications in
the hosting industry. Fanatical Support. Click to learn more
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=107521&bid=248729&dat=121642
