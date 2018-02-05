From: KaiChieh Chuang <kaichieh.chuang@mediatek.com>
Subject: Re: [PATCH] ASoC: dapm: fix debugfs read using
 path->connected
Date: Mon, 5 Feb 2018 09:00:18 +0800
Message-ID: <1517792418.27374.3.camel@mtkswgap22>
References: <1517555015-19080-1-git-send-email-kaichieh.chuang@mediatek.com>
 <20180202155340.GC7101@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0277486972825275171=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailgw01.mediatek.com (unknown [210.61.82.183])
 by alsa0.perex.cz (Postfix) with ESMTP id 27ED5266D06
 for <alsa-devel@alsa-project.org>; Mon,  5 Feb 2018 02:00:26 +0100 (CET)
In-Reply-To: <20180202155340.GC7101@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: shane.chien@mediatek.com, alsa-devel@alsa-project.org, garlic.tseng@mediatek.com, chipeng.chang@mediatek.com
List-Id: alsa-devel@alsa-project.org

--===============0277486972825275171==
Content-Transfer-Encoding: 7bit
Content-Type: multipart/related;
	boundary="__=_Part_Boundary_005_835681164.197294686"

--__=_Part_Boundary_005_835681164.197294686
MIME-Version: 1.0
Content-Type: text/plain

On Fri, 2018-02-02 at 16:53 +0100, Mark Brown wrote:
> On Fri, Feb 02, 2018 at 03:03:35PM +0800, kaichieh.chuang@mediatek.com wrote:
> > From: KaiChieh Chuang <kaichieh.chuang@mediatek.com>
> >
> > This fix a bug in dapm_widget_power_read_file(),
> > where it may sent opposite order of source/sink widget
> > into the p->connected().
>
> This doesn't apply against my tree or Linus' tree, can you please check
> and resend?  The change itself seems to make sense.

I can't figure out where I have do it wrong, can you help me point it
out? Thanks

this is how i get the code base:
git clone
http://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git
git checkout remotes/origin/for-next

HEAD commit is at
commit 56821b5652e2228ba875b72c73f4d8450b63e032
Merge: f91a4c1 0619093
Author: Mark Brown <broonie@kernel.org>
Date:   Wed Jan 31 10:42:43 2018 +0000

    Merge remote-tracking branch 'asoc/fix/mtk' into asoc-linus

which matches the tree on http
https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git/log/?h=for-nex
t


************* Email Confidentiality Notice ********************
The information contained in this e-mail message (including any
attachments) may be confidential, proprietary, privileged, or otherwise
exempt from disclosure under applicable laws. It is intended to be
conveyed only to the designated recipient(s). Any use, dissemination,
distribution, printing, retaining or copying of this e-mail (including its
attachments) by unintended recipient(s) is strictly prohibited and may
be unlawful. If you are not an intended recipient of this e-mail, or believe
that you have received this e-mail in error, please notify the sender
immediately (by replying to this e-mail), delete any and all copies of
this e-mail (including any attachments) from your system, and do not
disclose the content of this e-mail to any other person. Thank you!

--__=_Part_Boundary_005_835681164.197294686--


--===============0277486972825275171==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0277486972825275171==--
