From: Adrian Knoth <adi@drcomp.erfurt.thur.de>
Subject: Re: Issues with HDSPM
Date: Tue, 7 Jun 2011 08:33:05 +0200
Message-ID: <20110607063305.GE17989@ltw.loris.tv>
References: <20110606210425.0a4c2901@revell.mafea.no-ip.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="NMuMz9nt05w80d4+"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ltw.loris.tv (ltw.loris.tv [85.14.220.160])
	by alsa0.perex.cz (Postfix) with ESMTP id 2AE7510389E
	for <alsa-devel@alsa-project.org>;
	Tue,  7 Jun 2011 08:33:23 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20110606210425.0a4c2901@revell.mafea.no-ip.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Andre Schramm <andre.schramm@iosono-sound.com>
Cc: alsa-devel@alsa-project.org, fredrik.lingvall@gmail.com
List-Id: alsa-devel@alsa-project.org


--NMuMz9nt05w80d4+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jun 06, 2011 at 09:04:25PM +0200, Andre Schramm wrote:

> Hello,

Hi!

> the HDSPM driver seems to be broken in the current ALSA release.
> We're using CentOS 5 with 2.6.33.9-rt31.64.el5rt and ALSA 1.0.24
> compiled from source, the card is a PCIe Hammerfall DSP MADI (rev d2).
> As already mentioned in [1], the card operates in master mode, but the
> system clock mode can't be set to anything higher than 48kHz.

Unfortunately, I don't happen to have a MADI card, but Fredrik has.
Fredrik, can you confirm the problem?

At least my RayDAT can be perfectly set to all sample rates via
alsamixer, and the code for setting sample rates isn't device specific,
so I'd expect it to work on MADI, too.


> When switching to a PCI version of the card, the kernel completely
> crashes on boot.

We'd need a crash report. Best is to blacklist the kernel module, boot
the machine and then trying to load the module, maybe on a console.

If need be, we can meet and fix the problem on-site, I'm living close to
your place.


> http://mailman.alsa-project.org/pipermail/alsa-devel/2008-March/006723.html
> And with [2], there is another issue which unfortunately hasn't been
> merged yet and still exists in the current release.

Could you try this patch? (for your convenience, I've also attached it)


diff --git a/sound/pci/rme9652/hdspm.c b/sound/pci/rme9652/hdspm.c
index 949691a..6649aed 100644
--- a/sound/pci/rme9652/hdspm.c
+++ b/sound/pci/rme9652/hdspm.c
@@ -1143,7 +1143,7 @@ static int hdspm_external_sample_rate(struct hdspm *hdspm)
 
 		/* if wordclock has synced freq and wordclock is valid */
 		if ((status2 & HDSPM_wcLock) != 0 &&
-				(status & HDSPM_SelSyncRef0) == 0) {
+				(status2 & HDSPM_SelSyncRef0) == 0) {
 
 			rate_bits = status2 & HDSPM_wcFreqMask;
 



Cheers

-- 
mail: adi@thur.de  	http://adi.thur.de	PGP/GPG: key via keyserver

--NMuMz9nt05w80d4+
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment; filename="hdspm-wc.patch"

diff --git a/sound/pci/rme9652/hdspm.c b/sound/pci/rme9652/hdspm.c
index 949691a..6649aed 100644
--- a/sound/pci/rme9652/hdspm.c
+++ b/sound/pci/rme9652/hdspm.c
@@ -1143,7 +1143,7 @@ static int hdspm_external_sample_rate(struct hdspm *hdspm)
 
 		/* if wordclock has synced freq and wordclock is valid */
 		if ((status2 & HDSPM_wcLock) != 0 &&
-				(status & HDSPM_SelSyncRef0) == 0) {
+				(status2 & HDSPM_SelSyncRef0) == 0) {
 
 			rate_bits = status2 & HDSPM_wcFreqMask;
 

--NMuMz9nt05w80d4+
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--NMuMz9nt05w80d4+--
