From: =?iso-8859-1?Q?Ville_Syrj=E4l=E4?= <syrjala@sci.fi>
Subject: Re: Simple instruments broken?
Date: Tue, 23 Apr 2002 02:27:47 +0300
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20020423022747.D2708@sci.fi>
References: <20020423014954.C2708@sci.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <20020423014954.C2708@sci.fi>; from syrjala@sci.fi on Tue, Apr 23, 2002 at 01:49:54AM +0300
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Tue, Apr 23, 2002 at 01:49:54AM +0300, Ville Syrjälä wrote:
> Maybe a year ago I hacked together a mikmod driver for GUS synth. I
> started with the drivers in alsamod and ultramod and I actually got
> it to make sound. But somehow I misplaced the driver. So I started from
> scratch after the sequencer API changes, but I couldn't get any sound from
> it. Now I wanted to take another look to see if I could actually make it
> work, but now it won't even compile. What's happened to the instrument
> support stuff?

Stupid me. ainstr_simple.h header simply wasn't installed anymore. But the
driver still won't produce any sound. Is there someone who'd like to take
a look at it. I'm not sure what the problem is. I don't know if my usage
of poll is correct so maybe it's that. I've put a patch against libmikmod
3.1.9 to "http://www.saunalahti.fi/~syrjala/alsa/"

-- 
Ville Syrjälä
syrjala@sci.fi
http://www.sci.fi/~syrjala/
