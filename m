From: Peter Heatwole <peter599@gotnet.net>
Subject: Re: SPDIF output finally working properly with CS4630
Date: Wed, 24 Jul 2002 16:37:58 -0700
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20020724233758.GO1681@porky>
References: <3D3DBDA2.10602@cucumelo.org> <20020724013400.GA5214@porky> <3D3E2D08.3070800@cucumelo.org> <20020724181919.GC1681@porky> <3D3EF4CA.1090504@cucumelo.org> <20020724201201.GI1681@porky> <3D3F0710.1060307@cucumelo.org> <20020724212315.GK1681@porky> <3D3F21CD.9090600@cucumelo.org>
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <3D3F21CD.9090600@cucumelo.org>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Benny Sjostrand <gorm@cucumelo.org>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On 2002.07.24 14:53 Benny Sjostrand wrote:
> Well, if you have access to a oscilloscope that can be programed to view 
> the differential result
> of the signals then probably you can proably view the digital data.
> But i've never tested to do this, and don't have any access to a 
> oscilloscope at home ...

    Neither do I. =)

> Then, do you know if your IEC958 is connected to CS4297A or CS4630 ??
> If it is connected to the CS4297A then this patch will not provide any 
> output on that IEC958 port.

    Looking at the datasheets and schematics, it looks like the CS4630 uses
AC97 codecs to actually process and output it's iec958 frames. I could
easily be wrong, but the schematics for the CS4630-CM don't show the
circuitry necessary to power and control an iec958 line. It shows a pin,
which I assume links to the codec (in my case, a CS4297A). Is there
a datasheet that could show me what you mean?

[...]
> This dump should not be that long!
> Did you change anything in the code ? the SCB block
> has always a fixed size of 16 Dwords. A new SCB block will
> start on 0x0050.

    No, I haven't changed a thing.

> Well, that's what i can interpret from this outputs.
> 
> Everything look basically OK.
> Seems like you have loaded the module successfully and have not started
> playing yet.

    Strange. Well, if it _were_ the case that my card is using a CS4297A 
for
digital output, do you think that would cause this?


-- Peter Heatwole
"Murphy was just a well known pessimist."



-------------------------------------------------------
This sf.net email is sponsored by: Jabber - The world's fastest growing 
real-time communications platform! Don't just IM. Build it in! 
http://www.jabber.com/osdn/xim
