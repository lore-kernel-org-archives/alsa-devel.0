From: "Gorm Lai" <lai@daimi.au.dk>
Subject: Re: problems with rme digi96/8
Date: Mon, 16 Jun 2003 18:07:12 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <002001c33421$5e5c7ab0$0200a8c0@fjodor>
References: <Pine.LNX.4.44.0306121516450.1795-100000@pnote.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Jaroslav Kysela <perex@suse.cz>, Giuliano Pochini <pochini@shiny.it>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi All!

Thanks for all the help you offered. I got everything, but unfortunately I
cannot explain why. The machine staff had first installed it in my
workstation on which I do not have root access. However in the end, I got
them to take it out, and then I put it in the demo machine in which it
supposed to work in the end anyhow. I have root access on this machine and
is responsible for configuring everything myself. Here everything worked
nearly out of the box; installation of drivers, libs, and utils went fine.

Thanks again. - I learned a lot in the process.

Gorm



----- Original Message -----
From: "Jaroslav Kysela" <perex@suse.cz>
To: "Giuliano Pochini" <pochini@shiny.it>
Cc: <alsa-devel@lists.sourceforge.net>
Sent: Thursday, June 12, 2003 3:18 PM
Subject: Re: [Alsa-devel] problems with rme digi96/8


> On Thu, 12 Jun 2003, Giuliano Pochini wrote:
>
> >
> > On 12-Jun-2003 Jaroslav Kysela wrote:
> > > On 12 Jun 2003, Gorm David Lai wrote:
> > >
> > >> I tried your example. Aplay is rather stupid, so it is seems it needs
a
> > >
> > > Not too stupid, but you should use right device (plughw vs. hw) and
> > > probably right alsa-lib configuration (~/.asoundrc).
> >
> > The format written in the sound file has priority over command
> > line options. It's a bit annoying and should be changed IMHO.
>
> No, you can explicitly change the format (if something is wrong) using
> command line parameters. But my point was that aplay does not do any
> conversion. If someone use 'hw' device then hardware must match the stream
> parameters, otherwise 'plughw' should be used to instruct alsa-lib to do
> necessary conversions.
>
> Jaroslav
>
> -----
> Jaroslav Kysela <perex@suse.cz>
> Linux Kernel Sound Maintainer
> ALSA Project, SuSE Labs
>
>
>
> -------------------------------------------------------
> This SF.NET email is sponsored by: eBay
> Great deals on office technology -- on eBay now! Click here:
> http://adfarm.mediaplex.com/ad/ck/711-11697-6916-5
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/alsa-devel
>



-------------------------------------------------------
This SF.NET email is sponsored by: eBay
Great deals on office technology -- on eBay now! Click here:
http://adfarm.mediaplex.com/ad/ck/711-11697-6916-5
