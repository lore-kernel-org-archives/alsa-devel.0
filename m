From: Mark Knecht <markknecht@comcast.net>
Subject: Re: Alsa-1.0.0rc2 Hammerfall Light - small bug report
Date: Fri, 02 Jan 2004 07:33:48 -0800
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1073057628.1802.1.camel@Wizard.knechthome.com>
References: <1070760538.5385.12.camel@Wizard.knechthome.com>
	 <1070763319.31277.0.camel@Wizard.knechthome.com>
	 <20040102141046.GA590@tuba.home>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <20040102141046.GA590@tuba.home>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Martin Langer <martin-langer@gmx.de>
Cc: Alsa-Devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Fri, 2004-01-02 at 06:10, Martin Langer wrote:
> On Sat, Dec 06, 2003 at 06:15:19PM -0800, Mark Knecht wrote:
> > 
> > Note ADAT3 which do not exist on
> > this card.
> > 
> > 
> > [mark@localhost mark]$ cat /proc/asound/card0/rme9652 
> [...]
> > ADAT Sample rate: 44100Hz
> > ADAT1: No Lock
> > ADAT2: No Lock
> > ADAT3: No Lock
> > 
> 
> This patch will remove the ADAT3 entry for light users. Please try it out,
> because I don't have any hammerfall hardware.
> 
> 
> martin

Martin,
   Sorry, but I cannot try it out. My Hammerfall Light box is a
PlanetCCRMA machine which is RPM based. I wouldn't have a clue how to
patch an RPM to do this.

Sorry,
Mark



-------------------------------------------------------
This SF.net email is sponsored by: IBM Linux Tutorials.
Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
Click now! http://ads.osdn.com/?ad_id=1278&alloc_id=3371&op=click
