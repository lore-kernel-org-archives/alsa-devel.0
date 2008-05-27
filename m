From: Roman Haefeli <reduzierer@yahoo.de>
Subject: Re: hdsp rpm support
Date: Tue, 27 May 2008 15:46:21 +0200
Message-ID: <1211895981.5482.17.camel@localhost.localdomain>
References: <c62722740805260033t68f1ab1cu7ed5908f803fbacd@mail.gmail.com>
	<47321.137.248.1.11.1211815832.squirrel@webmail.naturestudies.eu>
	<c62722740805262000i33e9ea00p88bc808ef286732c@mail.gmail.com>
	<200805270814.36011.faber@faberman.de>
	<c62722740805270559q6a47d5fq3e3084a995494e1@mail.gmail.com>
Reply-To: reduzierer@yahoo.de
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from n7.bullet.re3.yahoo.com (n7.bullet.re3.yahoo.com
	[68.142.237.92]) by alsa0.perex.cz (Postfix) with SMTP id E5837243D9
	for <alsa-devel@alsa-project.org>;
	Tue, 27 May 2008 15:46:27 +0200 (CEST)
In-Reply-To: <c62722740805270559q6a47d5fq3e3084a995494e1@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Martin Tufnel <martin.tufnel@gmail.com>
Cc: Florian Faber <faber@faberman.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Tue, 2008-05-27 at 22:59 +1000, Martin Tufnel wrote:
> Hi Flo
> 
> On Tue, May 27, 2008 at 4:14 PM, Florian Faber <faber@faberman.de> wrote:
> 
> > Martin,
> >
> > > Just to clarify, given the driver is finished but the user tools are
> > > still under development, this means that the unit will basically work
> > > but not have its full functionality - is this correct?
> >
> > You have IO, you can adjust the input levels, switch standby and
> > disconnect the box. So everything works as you would expect it.
> >
> 
> Great!
> 
> 
> >
> > > Also, did you use the new patched version of the firmware that Karl
> > > worked on?
> >
> > No, it's the original firmware. Why would one want to patch it?
> >
> 
> My understanding from Roman's previous posts was that there was a problem
> loading the firmware from within Linux.  If I understood him correctly, he
> needed to load the fireware from within a Windows boot and then boot into
> Linux (without turning off the machine of course).  Perhaps I misunderstood
> him.

this is exactly what i do. it's no problem, though, to turn off the
computer after having sent the firmware from within windows, but as soon
as i power off the rpm, i need to do the process again. this works well
for me, since most of the time the rpm is sitting home powered on, so i
can plug it to the laptop and it works. 

correct me if i am wrong, but i thought the problem is not the firmware
itself, or the fact that it is missing, but the (old) version of the
hdsploader i used to use only knows about the multiface and the
digiface, but not about the rpm, AFAIK. from what i know, the very same
firmware, that is used in windows, can be used in linux as well (since
its card specific and not os-specific), but as flo suggested, the
userspace tools need to be adapted. 

with the old hdsp* stuff, it technically works, but the hdspmixer looks
like i'd be using a multiface (it shows more channels than the rpm
actually has) and also the hdspconf shows the switches for the
mutliface. some card settings can be changed anyway, but you need to
guess, what is what, since the labels are bogus (for use with the rpm).

i hope i didn't confuse anyone with my old posts. those describe only
the kludges, i am using with old alsa-drives, until the final driver and
userspace tools are written.

roman



		
___________________________________________________________ 
Telefonate ohne weitere Kosten vom PC zum PC: http://messenger.yahoo.de
