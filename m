From: Peter Heatwole <peter599@gotnet.net>
Subject: Re: SPDIF output finally working properly with CS4630
Date: Wed, 24 Jul 2002 16:53:39 -0700
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20020724235339.GS1681@porky>
References: <3D3DBDA2.10602@cucumelo.org> <20020724013400.GA5214@porky> <3D3E2D08.3070800@cucumelo.org> <20020724181919.GC1681@porky> <3D3EF4CA.1090504@cucumelo.org> <20020724201201.GI1681@porky> <3D3F0710.1060307@cucumelo.org> <20020724212315.GK1681@porky> <3D3F21CD.9090600@cucumelo.org> <20020724233758.GO1681@porky>
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <20020724233758.GO1681@porky>; from peter599@gotnet.net on Wed, Jul 24, 2002 at 16:37:58 -0700
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

On 2002.07.24 16:37 Peter Heatwole wrote:
>    Looking at the datasheets and schematics, it looks like the CS4630 
> uses
> AC97 codecs to actually process and output it's iec958 frames. I could
> easily be wrong, but the schematics for the CS4630-CM don't show the
> circuitry necessary to power and control an iec958 line. It shows a pin,
> which I assume links to the codec (in my case, a CS4297A). Is there
> a datasheet that could show me what you mean?


    Hmm. Seems like I'm wrong. I just remembered you mentioned that the
Game Theatre only has 2 CS4294 codecs, which suggests that the CS4630
does indeed have it's own iec958 output pin. I wish I understood schematics
better. The one I was looking at must have just generalized and I took it
literally.

-- Peter Heatwole
"Murphy was just a well known pessimist."


-------------------------------------------------------
This sf.net email is sponsored by: Jabber - The world's fastest growing 
real-time communications platform! Don't just IM. Build it in! 
http://www.jabber.com/osdn/xim
