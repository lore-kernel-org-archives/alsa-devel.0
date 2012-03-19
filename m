From: Bob Tracy <rct@gherkin.frus.com>
Subject: Re: static /dev configuration
Date: Mon, 19 Mar 2012 07:20:38 -0500
Message-ID: <20120319122038.GA3192@gherkin.frus.com>
References: <20120319053820.GA14603@gherkin.frus.com>
	<4F66ECD3.5020406@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from gherkin.frus.com (gherkin.frus.com [192.158.254.49])
	by alsa0.perex.cz (Postfix) with ESMTP id 968E71040A7
	for <alsa-devel@alsa-project.org>; Mon, 19 Mar 2012 13:20:41 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <4F66ECD3.5020406@ladisch.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Clemens Ladisch <clemens@ladisch.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Mon, Mar 19, 2012 at 09:22:43AM +0100, Clemens Ladisch wrote:
> Bob Tracy wrote:
> > Does ALSA now require dynamic devices (udev)
> 
> It does if the kernel is compiled with CONFIG_SND_DYNAMIC_MINORS.

SND_HDA_CODEC_HDMI forces SND_DYNAMIC_MINORS :-(.

SND_HDA_CODEC_HDMI --> "Build HDMI/DisplayPort HD-audio codec support"
    Say Y here to include HDMI and DisplayPort HD-audio codec
    support in snd-hda-intel driver.  This includes all AMD/ATI,
    Intel and Nvidia HDMI/DisplayPort codecs.

I knew I didn't explicitly select SND_DYNAMIC_MINORS...  Thanks for the
pointer.

--Bob
