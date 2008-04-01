From: Michael Cree <mcree@orcon.net.nz>
Subject: Re: [regression] 2.6.25-rc4 snd-es18xx broken on Alpha
Date: Wed, 2 Apr 2008 10:02:37 +1300
Message-ID: <CB76D24F-0C1F-4FDA-B6B0-4B842989718B@orcon.net.nz>
References: <20080401202605.70554DBA2@gherkin.frus.com>
Mime-Version: 1.0 (Apple Message framework v919.2)
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx5.orcon.net.nz (mx5.orcon.net.nz [219.88.242.55])
	by alsa0.perex.cz (Postfix) with ESMTP id 0767924A4F
	for <alsa-devel@alsa-project.org>;
	Tue,  1 Apr 2008 23:02:55 +0200 (CEST)
Received: from Debian-exim by mx5.orcon.net.nz with local (Exim 4.67)
	(envelope-from <mcree@orcon.net.nz>) id 1Jgnd3-00026r-84
	for alsa-devel@alsa-project.org; Wed, 02 Apr 2008 10:02:49 +1300
In-Reply-To: <20080401202605.70554DBA2@gherkin.frus.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Bob Tracy <rct@frus.com>
Cc: ALSA devel <alsa-devel@alsa-project.org>, Krzysztof Helt <krzysztof.h1@wp.pl>, Takashi Iwai <tiwai@suse.de>, Rene Herman <rene.herman@keyaccess.nl>, linux-kernel@vger.kernel.org, Ivan Kokshaysky <ink@jurassic.park.msu.ru>, linux-alpha@vger.kernel.org, Tyson Whitehead <twhitehe@uwo.ca>
List-Id: alsa-devel@alsa-project.org

On 2/04/2008, at 9:26 AM, Bob Tracy wrote:
> Hugh said we could blame him or Nick for removing the special
> PageReserved usage, or the Alpha for ignoring gfp_flags in the
> following:
>
>  #define dma_alloc_coherent(dev, size, addr, gfp)      \
>                pci_alloc_consistent(alpha_gendev_to_pci(dev), size,  
> addr)
>
> The workaround (until the official patch was issued) was a small patch
> against arch/alpha/kernel/pci_iommu.c:pci_alloc_consistent() that
> replaced "gfp_t gfp = GFP_ATOMIC;" with "gfp_t gfp = GFP_ATOMIC| 
> __GFP_COMP;".
> That eliminated the "bad page state" errors for me, and I don't recall
> what the official patch was.

The official patch has just been uploaded to the -mm kernel.  Get it at:

http://userweb.kernel.org/~akpm/mmotm/broken-out/alpha-fix-alsa-dma-mmap-crash.patch

It fixed up quite a number of sound playing applications that were  
causing kernel oops on my newer PWS600au (the older one still has  
problems that are of a completely different nature) and also fixed use  
of an M-Audio Revolution audio card on my XP1000.

The repeated small passages at the end of a short sound file still  
occurs with the es18xx driver on the newer PWS600au (and to a lesser  
extent on the Compaq XP1000).  Other sound drivers (cmipci, ice1724)  
do not exhibit the same anomalous symptoms so the problem is probably  
in the es18xx driver.

The older PWS600au fails to play sound at all and exhibits the  
behaviour you described in a recent message (machine gun like noises  
and the interrupts don't clock up at all) with the es18xx driver. I  
tried to put the C-Media audio card (which uses the cmipci driver)  
into this machine, but SRM reports on powerup that there is an  
"illegal" card installed (I hope the police don't turn up at my door)  
and that it must be removed to continue booting!!!  I tried setting  
pci_device_override to 1 in SRM, but that didn't help.  So I can't  
verify whether this is an es18xx specific problem or a more general  
alsa problem.

Now that the crashes due to "bad page state" errors are solved on both  
of my PWS600aus, maybe I should start re-applying the es18xx interrupt  
type patches that Tyson, et al., suggested and see if they now make a  
difference.  I will not be able to do this before the weekend.

Cheerz
Michael.
