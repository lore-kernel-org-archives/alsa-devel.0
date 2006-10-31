From: "Fatih Asici" <asici.f@gmail.com>
Subject: Re: [RFC: 2.6.19 patch] snd-hda-intel: default MSI to
	off
Date: Tue, 31 Oct 2006 08:56:55 +0200
Message-ID: <5aa69f860610302256u61e30b2aj2501e5c1f5b7335@mail.gmail.com>
References: <200610050938.10997.prakash@punnoor.de>
	<s5h64eh5yzx.wl%tiwai@suse.de> <s5h3b9l5ykv.wl%tiwai@suse.de>
	<200610222229.16927.prakash@punnoor.de> <s5hhcxv1bc3.wl%tiwai@suse.de>
Reply-To: fatih.asici@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from ug-out-1314.google.com (ug-out-1314.google.com [66.249.92.169])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 4F4C6255
	for <alsa-devel@alsa-project.org>; Tue, 31 Oct 2006 07:56:57 +0100 (MET)
Received: by ug-out-1314.google.com with SMTP id j3so1281936ugf
	for <alsa-devel@alsa-project.org>; Mon, 30 Oct 2006 22:56:56 -0800 (PST)
In-Reply-To: <s5hhcxv1bc3.wl%tiwai@suse.de>
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
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Stephen Hemminger <shemminger@osdl.org>, linux-kernel@vger.kernel.org, mingo@redhat.com, hnguyen@de.ibm.com, Prakash Punnoor <prakash@punnoor.de>, perex@suse.cz
List-Id: alsa-devel@alsa-project.org

On 10/23/06, Takashi Iwai <tiwai@suse.de> wrote:
> At Sun, 22 Oct 2006 22:29:13 +0200,
> Prakash Punnoor wrote:
> >
> > Am Mittwoch 18 Oktober 2006 19:21 schrieb Takashi Iwai:
> >
> > > > Yes, it would be better to check the value and reset chip->msi if
> > > > not successful.  But it's not a fatal error, so the current code
> > > > should work.
> > >
> > > The below is the revised patch.
> >
> > I tried it and it works fine for me now (with the driver not using msi
> > automatically now).
>
> Thanks for checking.  I applied the patch to ALSA tree for the next
> push round.
>

It does not solve my problem. I still need to boot with pci=nomsi option.

Prakash: did you use Takashi's patch or Andrian's patch?

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
