From: Marcel <shizuma@magma.ca>
Subject: alsa 1.0rc1 + cmipci
Date: Wed, 3 Dec 2003 11:08:07 -0500
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20031203160807.GA25623@dailyplanet.net>
References: <E1ARFik-00019j-3a@sc8-sf-list2.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <E1ARFik-00019j-3a@sc8-sf-list2.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

> Marcel wrote:
> > I have a dual boot system.  1) kernel 2.4.23 + alsa 0.9.8; 2) kernel
> > 2.6.0test11 w its 0.9.7 drivers and same alsa 0.9.8.
> >
> > I am wondering what could happen if I install recent alsa 1pre.  Kernel 2.4
> > should be happy of the upgrade;
> 
> Yes; the modules for each kernel version get their own directory.
> 
> > but will apps compiled with the 0.9.0 headers still work with
> > kernel 2.6 and its 0.9.7 driver and alsa-lib 1pre?
> 
> Applications access the library only, and the 0.9 and 1.0 versions of
> alsa-lib are binary compatible.
> 

I've just finished installing alsa 1.0pre1.  Compiled fine.  Works pretty
well on both kernels.  Great work!


-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?  SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
