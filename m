From: Sjoerd Simons <sjoerd@luon.net>
Subject: Re: status of powermac sound?
Date: Wed, 12 May 2004 23:39:35 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040512213935.GB4696@spring.luon.net>
References: <200405121138.09878.bergtroll@gmx.li> <1084357911.3034.11.camel@thor.asgaard.local> <20040512145302.GA11235@spring.luon.net> <200405130915.34452.bergtroll@gmx.li>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <200405130915.34452.bergtroll@gmx.li>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Thu, May 13, 2004 at 09:15:34AM +1200, Niklas Werner wrote:
> On Thu, 13 May 2004 02:53, Sjoerd Simons wrote:
> 
> > Using this on my albook. I get strange distorsions and a too low pitch
> > when playing a dvd or divx with 48Khz audio.
> >
> > For the record, the hardware is:
> > 0 [Snapper        ]: PMac Snapper - PowerMac Snapper
> >                      PowerMac Snapper (Dev 35) Sub-frame 0
> 
> yep, exactly. And normally using alsa directly does not work, and if it 
> does it shows the same effects...
> 
> mplayer with -ao alsa1x yields:
> 
> alsa-play: unknown status, trying to reset soundcard
> 
> works fine with -ao oss
> xmms doesn't work with alsa-plugin at all (well, OK, who cares... xmms 
> seems to have died anyways...)

rhythmbox (with gstreamer 0.8 backend) and gnomemeeting 1.0.2 both work fine 
with alsa directly here (vanilla 2.6.6 kernel). As long as the samplerate is 
44100hz alsa works perfectly :)

  Sjoerd
-- 
Since everything in life is but an experience perfect in being what it is,
having nothing to do with good or bad, acceptance or rejection, one may well
burst out in laughter.
		-- Long Chen Pa


-------------------------------------------------------
This SF.Net email is sponsored by Sleepycat Software
Learn developer strategies Cisco, Motorola, Ericsson & Lucent use to deliver
higher performing products faster, at low TCO.
http://www.sleepycat.com/telcomwpreg.php?From=osdnemail3
