From: "Ivica Bukvic" <ico@fuse.net>
Subject: RE: Failed to compile HDSP driver from the CVS
Date: Tue, 14 May 2002 09:30:17 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <000601c1fb4b$7cd77ae0$ac1f830a@ico>
References: <200205141306.g4ED65T06570@post2.fast.net>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <200205141306.g4ED65T06570@post2.fast.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: 'Paul Davis' <pbd@op.net>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Thank you for your prompt reply!

However, this is the first time ever I tried using the CVS, so I had no
files hanging around prior to this downloading. I am also pretty sure
that I downloaded the stuff with -P flag (I did it as instructions on
the alsa-project page have stated it, including the -P flag). On top of
that I even tried updating the whole CVS tree just to see if that will
fix it.

So, I am not sure why it is even referencing the file in the first place
if none of the other files are supposed to mention it.

Should I uninstall every trace of Alsa from my cpu before trying to use
CVS?

Ico

> -----Original Message-----
> From: Paul Davis [mailto:pbd@op.net]
> Sent: Tuesday, May 14, 2002 9:07 AM
> To: Ivica Bukvic
> Cc: alsa-devel@alsa-project.org
> Subject: Re: Failed to compile HDSP driver from the CVS

> i think you failed to use the "-P" flag to the CVS update
> command. Always use this flag, otherwise when someone removes a file
> from CVS, its not removed from your local tree.
> 
> as a result, you've still got rme9652_mem.c hanging around, and the
> "fastdep" make target looks at *all* sources, not just those that are
> listed in the Makefile. you need to remove this file. there are two
> versions of it, one under alsa-kernel, one under alsa-driver.
> 
> please keep in mind that you should update alsa-lib and alsa-utils as
> well, because they have been modified to support the 64 bit register
> used by the H-DSP for its RMS meters.
> 
> --p



_______________________________________________________________

Have big pipes? SourceForge.net is looking for download mirrors. We supply
the hardware. You get the recognition. Email Us: bandwidth@sourceforge.net
