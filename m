From: Peter Heatwole <peter599@gotnet.net>
Subject: Re: More CS4630, secondary CODEC output.
Date: Sat, 27 Jul 2002 09:13:41 -0700
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20020727161341.GA774@porky>
References: <3D41D4DC.60004@cucumelo.org> <20020727003649.GA5560@porky> <3D4245A1.3020302@cucumelo.org> <20020727151347.GA1991@idefix.fvdpol.home.nl>
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mail.gotnet.net (mail.gotnet.net [207.173.88.4])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id SAA13258
	for <alsa-devel@alsa-project.org>; Sat, 27 Jul 2002 18:19:34 +0200
Content-Disposition: inline
In-Reply-To: <20020727151347.GA1991@idefix.fvdpol.home.nl>; from fvdpol@home.nl on Sat, Jul 27, 2002 at 08:13:47 -0700
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Frank van de Pol <fvdpol@home.nl>
Cc: Benny Sjostrand <gorm@cucumelo.org>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 2002.07.27 08:13 Frank van de Pol wrote:
> > Well, you dont seems to any luck ... no SPDIF, no rear sound -:(
> > Do you know which CODEC's you card have ??, are AC97 2.0 or AC97 1.03
> >
> 
> Turtle Beach Santa Cruz boards have:
> 
> CS4630-CM DSP,
> CS4294-JO codec,
> CS4297A-JO codec

    Both are AC97 2.0 codecs.


> the board supports 4 analog inputs + 6 analog outputs (I use it for
> multi-track recording). One thing that might cause for the driver is that
> it
> has one 1/8" jack, the 'versa jack' that combines multiple (selectable)
> functions:

    I have been thinking about this as well. I wrote Turtle Beach 
requesting
any kind of documentation on the Santa Cruz, specifically, design docs.
Hopefully they will provide some useful information regarding this question
as well as "does S/PDIF travel through the CS4297A or is it output directly
by the CS4630?". I informed them that the Hercules Game Theater had digital
and rear channel support functioning, and that the current driver
implementation was incompatible with the Santa Cruz. Hopefully that will
spur them to release some useful docs. (I figure I might as well use the
leverage while we have it. :)


-- Peter Heatwole
"Murphy was just a well known pessimist."



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
