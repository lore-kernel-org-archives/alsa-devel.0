From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: problems with rme digi96/8
Date: Thu, 12 Jun 2003 15:18:37 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0306121516450.1795-100000@pnote.perex-int.cz>
References: <XFMail.20030612145047.pochini@shiny.it>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <XFMail.20030612145047.pochini@shiny.it>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Giuliano Pochini <pochini@shiny.it>
Cc: "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Thu, 12 Jun 2003, Giuliano Pochini wrote:

> 
> On 12-Jun-2003 Jaroslav Kysela wrote:
> > On 12 Jun 2003, Gorm David Lai wrote:
> >
> >> I tried your example. Aplay is rather stupid, so it is seems it needs a
> >
> > Not too stupid, but you should use right device (plughw vs. hw) and
> > probably right alsa-lib configuration (~/.asoundrc).
> 
> The format written in the sound file has priority over command
> line options. It's a bit annoying and should be changed IMHO.

No, you can explicitly change the format (if something is wrong) using
command line parameters. But my point was that aplay does not do any
conversion. If someone use 'hw' device then hardware must match the stream
parameters, otherwise 'plughw' should be used to instruct alsa-lib to do
necessary conversions.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SuSE Labs



-------------------------------------------------------
This SF.NET email is sponsored by: eBay
Great deals on office technology -- on eBay now! Click here:
http://adfarm.mediaplex.com/ad/ck/711-11697-6916-5
