From: Jure Repinc <jlp@holodeck1.com>
Subject: Re: Lockups with KDE 3.3.0 Beta 2 and Audigy 2 ZS
Date: Mon, 26 Jul 2004 01:24:51 +0200
Sender: alsa-user-admin@lists.sourceforge.net
Message-ID: <200407260124.51599.jlp@holodeck1.com>
References: <200407251639.02671.jlp@holodeck1.com> <200407260049.41454.jlp@holodeck1.com> <1090796834.719.14.camel@mindpipe>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-user-admin@lists.sourceforge.net>
In-Reply-To: <1090796834.719.14.camel@mindpipe>
Content-Disposition: inline
Errors-To: alsa-user-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-user>,
	<mailto:alsa-user-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-user@lists.sourceforge.net>
List-Help: <mailto:alsa-user-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-user>,
	<mailto:alsa-user-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-user>
To: alsa-user@lists.sourceforge.net
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Monday 26 of July 2004 01:07, Lee Revell wrote:
> On Sun, 2004-07-25 at 18:49, Jure Repinc wrote:
> > I tried with CVS compile but computer stil locks :(
> > Anything else I could try?
>
> Hmm, I did not see the part about your having a 64-bit system.  I
> believe there are places in the driver (pci/emu10k1/emufx.c) where a
> pointer is stored in an FX8010 GPR, which are 32 bits.  Someone on
> alsa-devel might know better, I will cc that list.
>
> Meanwhile, you should file a bug report with the ALSA bug tracker.
>
> Lee

OK. I didn't know there are still problems with 64-bit systems. Thanks for 
help. I'll report a bug.

-- 
Live long and prosper!
http://www.slo-comp.net/


-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=4721&alloc_id=10040&op=click
