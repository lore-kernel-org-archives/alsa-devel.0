From: Martin Langer <martin-langer@gmx.de>
Subject: Re: tascam us-122 : invalid synch pipe
Date: Tue, 21 Oct 2003 23:52:55 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20031021215255.GA535@tuba.home>
References: <200309251806.20116.ws@seh.de> <s5hd6dnkht9.wl@alsa2.suse.de> <20031020203131.GA614@tuba.home> <200310211138.36779.ws@seh.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <200310211138.36779.ws@seh.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Werner Schweer <ws@seh.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Tue, Oct 21, 2003 at 11:38:36AM +0200, Werner Schweer wrote:
> On Monday 20 October 2003 22:31, you wrote:
> >
> > Nevertheless I will invite other us122 owners: Please try it out!
> >
> > The Tascam US-122 driver v0.12 is available here:
> > http://www.langerland.de/us122/driver.html
> 
> funktioniert, Vielen Dank!
> 
> was mir auffiel:
> 
> - alsa cvs compiliert nur, wenn debug=0 gesetzt ist; ansonsten
>   meldet der Compiler, das "snd_us122_stream_t_magic" nicht
>   definiert ist.
> 

New us122 driver patch available (v0.13):
- fixing debug mode problem.

... at http://www.langerland.de/us122/driver.html


bye,
martin


-------------------------------------------------------
This SF.net email is sponsored by OSDN developer relations
Here's your chance to show off your extensive product knowledge
We want to know what you know. Tell us and you have a chance to win $100
http://www.zoomerang.com/survey.zgi?HRPT1X3RYQNC5V4MLNSV3E54
