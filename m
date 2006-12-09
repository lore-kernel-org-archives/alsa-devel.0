From: "Ian E. Morgan" <penguin.wrangler@gmail.com>
Subject: Re: Loud POP from sound system during module init w/
	2.6.19
Date: Sat, 9 Dec 2006 08:17:46 -0500
Message-ID: <2a6e8c0d0612090517j5afe2161p591203c70ddfc890@mail.gmail.com>
References: <2a6e8c0d0612081053v4fa0f2b0uea82fac75976b767@mail.gmail.com>
	<Pine.LNX.4.61.0612091020450.8055@yvahk01.tjqt.qr>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from ag-out-0708.google.com (ag-out-0708.google.com [72.14.246.243])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 372202F5
	for <alsa-devel@alsa-project.org>; Sat,  9 Dec 2006 14:17:47 +0100 (MET)
Received: by ag-out-0708.google.com with SMTP id 26so719079agb
	for <alsa-devel@alsa-project.org>; Sat, 09 Dec 2006 05:17:46 -0800 (PST)
In-Reply-To: <Pine.LNX.4.61.0612091020450.8055@yvahk01.tjqt.qr>
Content-Disposition: inline
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: alsa-devel@alsa-project.org, LKML <linux-kernel@vger.kernel.org>, perex@suse.cz
List-Id: alsa-devel@alsa-project.org

Previous kernel was 2.6.18.3, which did not exhibit the problem. I was
aware of udev setting the mixer at module load time, but I disabled
that and the problem still exists.

-- 
Ian E. Morgan
penguin.wrangler@gmail.com

On 09/12/06, Jan Engelhardt <jengelh@linux01.gwdg.de> wrote:
>
> On Dec 8 2006 13:53, Ian E. Morgan wrote:
> >Subject: Loud POP from sound system during module init w/ 2.6.19
>
> What kernel did you have before?
>
> What you see is the same I am experiencing on every boot - when the sound
> module is loaded, udev loads the previous volume settings. The volume settings
> are normal for me, but I guess the instant jump from 0-70% (for Master) and
> 0-61% (for PCM) is not taken too heartly by the soundcard.
>
> > Since upgrading to 2.6.19, two of my boxes (one workstation, one
> > notebook) started making a very loud (and scary) POP from the sound
> > system when the alsa modules are loaded. Unloading and reloading the
> > modules will generate another pop.
> >
> > Anybody else seeing this behaviour and know how to stop it?

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
