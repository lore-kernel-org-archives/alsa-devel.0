From: Karsten Wiese <annabellesgarden@yahoo.de>
Subject: Re: [PATCH]snd-usb-usx2y 0.7.2a
Date: Mon, 13 Sep 2004 19:08:08 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200409131908.09116.annabellesgarden@yahoo.de>
References: <200409121133.46219.annabellesgarden@yahoo.de> <s5h7jqyt9ld.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5h7jqyt9ld.wl@alsa2.suse.de>
Content-Disposition: inline
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

Am Montag 13 September 2004 18:30 schrieb Takashi Iwai:
> At Sun, 12 Sep 2004 11:33:46 +0200,
>
> Karsten Wiese wrote:
> > [1  <text/plain; us-ascii (7bit)>]
> > Hi Takashi,
> >
> > I found some improvements in the current kernel's version.
> > Please also apply in cvs.
>
> Could you send the summary and the description of the patch for
> changelog?
summary:
  Coding style changes and sanity checks 
  ported back from kernel 2.6.9-rc1-bk12.

description:
- Use NULL instead of 0 for pointers
- check results of kmalloc() and copy_from_user() in
  snd_usX2Y_hwdep_dsp_load()
- unnest initialisation calls in
  snd_usX2Y_hwdep_dsp_load()

thanks,
Karsten


-------------------------------------------------------
This SF.Net email is sponsored by: YOU BE THE JUDGE. Be one of 170
Project Admins to receive an Apple iPod Mini FREE for your judgement on
who ports your project to Linux PPC the best. Sponsored by IBM. 
Deadline: Sept. 13. Go here: http://sf.net/ppc_contest.php
