From: Steven Young <sdyoung@miranda.org>
Subject: Re: Sound trouble with MCP61 chipset.
Date: Fri, 21 Sep 2007 12:41:51 -0400
Message-ID: <20070921164151.GE30453@miranda.org>
References: <20070918180221.GI29734@miranda.org> <s5hy7f1pfzn.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from miranda.org (miranda.org [216.93.242.2])
	by alsa0.perex.cz (Postfix) with SMTP id 1CC3F1037F6
	for <alsa-devel@alsa-project.org>;
	Fri, 21 Sep 2007 18:41:54 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <s5hy7f1pfzn.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Thu, Sep 20, 2007 at 04:29:32PM +0200, Takashi Iwai wrote:
> Still too little information to analyze.  I see only that you
> apparently have an ASUS machine with HD-audio controller.
> Which version of ALSA driver are you using?  Which codec is on it?  It
> can be obtained from /proc/asound/card0/codec#* file.

  I am using the codec "Analog Devices AD1986A", with ALSA 1.0.14rc1 
(which is the default with Ubuntu), and the snd_hda_intel kernel module.

> It might help to pass various model options for testing in most
> cases.  See ALSA-Configuartion.txt for details.

  I had a look at that ... but I didn't see anything that looked likely
to fix my problem.  Are there any parameters you can suggest as being
relevant?

  Thanks,
  Steve.
