From: Mark Rages <markrages@mlug.missouri.edu>
Subject: Re: Interesting observation of cs46xx bass issues
Date: Sat, 19 Oct 2002 01:12:51 -0500
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20021019061251.GA2693@mlug.missouri.edu>
References: <3DB0F3D3.9040204@prism.gatech.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <3DB0F3D3.9040204@prism.gatech.edu>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Weijia Yang <gte733z@prism.gatech.edu>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Sat, Oct 19, 2002 at 01:55:31AM -0400, Weijia Yang wrote:
> I was fooling around w/ the mixer with the new cs46xx dsp driver, and I 
> noticed that if I set the volume of one stereo channel (either left or 
> right) to the lowest value in Master, the bass magically comes back! 
> However, this invariably results in only one speaker playing music, but 
> the subwoofer definitly plays bass now.  Muting the volume of only one 
> channel in PCM also does the same trick. However, bringing both channels 
> to the same level results in the absence of bass again.  Any ideas?

This sounds like the effect achieved when one channel is out-of-phase in 
an analog system.

Regards,
Mark





-------------------------------------------------------
This sf.net email is sponsored by:
Access Your PC Securely with GoToMyPC. Try Free Now
https://www.gotomypc.com/s/OSND/DD
