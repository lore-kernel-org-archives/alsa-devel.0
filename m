From: Juha <juhis@trinity.is-a-geek.com>
Subject: Re: CD SPDIF in Soundblaster Live 5.1 working?
Date: Tue, 14 Oct 2003 20:28:57 +0300
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1066152537.1512.17.camel@client.veehoo.net>
References: <Pine.HPX.4.33n.0310101823200.12877-100000@studcom.urz.uni-halle.de>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.HPX.4.33n.0310101823200.12877-100000@studcom.urz.uni-halle.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Hi Clemens,

Well, finally got time to test it out and everything works perfectly.
The "IEC958 TTL Volume" control actually controls the volume of the "CD
SPDIF" input. 

Thanks for your help,

Juha

On Fri, 2003-10-10 at 19:24, Clemens Ladisch wrote:
> Juha wrote:
> > On Tue, 2003-10-07 at 12:19, Clemens Ladisch wrote:
> > > Device 3 is playback only. As far as I can see, you can only record
> > > from S/PDIF by mixing it with other input signals to device 0.
> >
> > Ok, gotta try that then. What about routing the signal to the spdif
> > output of the soundblaster. Do you know how to enable that?
> 
> I guess there's a mixer control to route the mixed output (including
> the SPDIF input) to the SPDIF output.
> 
> 
> HTH
> Clemens
> 
> 
> 
> 
> -------------------------------------------------------
> This SF.net email is sponsored by: SF.net Giveback Program.
> SourceForge.net hosts over 70,000 Open Source Projects.
> See the people who have HELPED US provide better services:
> Click here: http://sourceforge.net/supporters.php
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/alsa-devel



-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
SourceForge.net hosts over 70,000 Open Source Projects.
See the people who have HELPED US provide better services:
Click here: http://sourceforge.net/supporters.php
