From: Manuel Jander <manuel.jander@mat.utfsm.cl>
Subject: Re: Occasional metallic sound when recording (cs46xx)
Date: Thu, 23 Oct 2003 16:51:12 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1066942272.2216.8.camel@localhost>
References: <200310221739.h9MHd0m1024945@oud.linuxaudiosystems.com>
	 <3F981FF3.4040902@gmx.at>  <87oew7g4m9.fsf@canaima.chapus.net>
Reply-To: manuel.jander@mat.utfsm.cl
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <87oew7g4m9.fsf@canaima.chapus.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: "Eloy A. Paris" <peloy@chapus.net>
Cc: Alsa Devel list <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Hello,

> > hmm, what makes something sound metallic anyway? echo?
> 
> Good question, I wish I knew. I guess I'll try enabling debugging output
> in the cs46xx driver. I am particulary interested in knowing what
> happens when you toggle capture of the ADC channel in alsamixer.

It could be a stereo demultiplexer problem. I had such kind of problems
on the Aureal driver while reverse engineering the Audio routing. If you
mess the order of the samples, you can end up with the MSB in place of
the LSB on such things, one piece of one channel swapped into the
other... very weird things, and interesting special effects :D.

I would suggest trying with other formats, say 8 bit mono, since if the
problem appears in such a format, where byte stream misalignment doesn't
care (one frame = one byte), then maybe the problem is related to
somewhat else, like DAC Antialiasing filter being setup wrong, or left
unprogrammed.

Once you have the pattern, of which formats are affected and which don't
its much easier to figure out where the problem lies.

Best Regards




-------------------------------------------------------
This SF.net email is sponsored by: The SF.net Donation Program.
Do you like what SourceForge.net is doing for the Open
Source Community?  Make a contribution, and help us add new
features and functionality. Click here: http://sourceforge.net/donate/
