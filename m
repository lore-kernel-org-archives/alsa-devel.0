From: Lee Revell <rlrevell@joe-job.com>
Subject: Re: [Alsa-user] Re: Re: SB Live! PCM control
Date: Sat, 05 Feb 2005 20:52:34 -0500
Message-ID: <1107654754.7256.115.camel@krustophenia.net>
References: <420270C1.3000706@voicenet.com>
	 <1107457227.7256.37.camel@krustophenia.net>
	 <4202A72C.3000007@superbug.co.uk>
	 <1107645609.7256.73.camel@krustophenia.net>
	 <1107653698.1333.5.camel@IMIRKIN.MIT.EDU>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
In-Reply-To: <1107653698.1333.5.camel@IMIRKIN.MIT.EDU>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Ilia Mirkin <imirkin@MIT.EDU>
Cc: alsa-user@lists.sourceforge.net, alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Sat, 2005-02-05 at 20:34 -0500, Ilia Mirkin wrote:
> The way that most (OSS at least) applications work is that they grab the
> PCM volume control and use that instead of actually adjusting the
> amplitude of the PCM samples. The problem that I was originally having
> is that the Wave Surround level is not effected by the PCM level,
> whereas the Master output is.

How do they know which control to use?  Just blithely grabbing the
master seems boneheaded.  What if another application is playing sound
at the same time?  I certainly don't want or expect the volume control
in mplayer to affect the output levels of other applications.  For
example a configuration that uses the front and rear speakers as
indepenent stereo PCMs.  Lowering the volume in the app A that's playing
to the front speakers should NOT affect the volume in app B that's
playing to the rear speakers.

The emu10k1 has a per PCM volume control ("EMU10K1 PCM Volume") that
does the Right Thing in this situation.

Lee



-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
