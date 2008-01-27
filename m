From: Alan Horstmann <gineera@aspect135.co.uk>
Subject: Re: Broken seq
Date: Sun, 27 Jan 2008 20:36:30 +0000
Message-ID: <200801272036.30629.gineera@aspect135.co.uk>
References: <200801261250.58032.gineera@aspect135.co.uk>
	<200801261808.47613.cave.dnb2m97pp@aliceadsl.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp.talktalk.net (wmsmtp.opaltelecom.net [62.24.128.253])
	by alsa0.perex.cz (Postfix) with ESMTP id AE62F1037FD
	for <alsa-devel@alsa-project.org>; Sun, 27 Jan 2008 21:17:36 +0100 (CET)
In-Reply-To: <200801261808.47613.cave.dnb2m97pp@aliceadsl.fr>
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ALSA devel <alsa-devel@alsa-project.org>
Cc: Nigel Henry <cave.dnb2m97pp@aliceadsl.fr>
List-Id: alsa-devel@alsa-project.org

On Saturday 26 January 2008 17:08, Nigel Henry wrote:
> On Saturday 26 January 2008 13:50, Alan Horstmann wrote:
> > During repeated testing of MIDI, something has broken the seq system, so
> > when loading previously working sound drivers, I get a message:
> >
> >  /proc/asound/seq/clients   File not found
> >
> > Why has it gone and how can I get it back?
> >
> > Thanks  Alan
>
> Hi Alan. I don't know too much, but try doing a:
> modprobe snd-seq  (as root obviously)

Thanks for that.  A combination, in several attempts, of your suggestion, 
restoring my previous modules configuration and rebooting (snd module would 
not unload) has got back a fully operational system.

Now to continue the MIDI testing -will be posting those results some time 
soon!

Alan
