From: Reimar =?iso-8859-1?Q?D=F6ffinger?= <Reimar.Doeffinger@stud.uni-karlsruhe.de>
Subject: Re: Re: [Fwd: Re: [MPlayer-dev-eng] AV out of sync with "-ao alsa" in gmplayer, mplayer works ok]
Date: Tue, 18 Jan 2005 21:23:09 +0100
Message-ID: <20050118202309.GA1147@rz.uni-karlsruhe.de>
References: <1104311474.2984.2.camel@krustophenia.net> <yw1x1xd976fz.fsf@inprovide.com> <loom.20050113T160235-955@post.gmane.org> <1105647075.3457.18.camel@krustophenia.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <1105647075.3457.18.camel@krustophenia.net>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Lee Revell <rlrevell@joe-job.com>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi,
On Thu, Jan 13, 2005 at 03:11:15PM -0500, Lee Revell wrote:
> Are there any plans to fix the ALSA output so that it doesn't reset the
> stream with every xrun?  Since you don't use a realtime thread to handl=
e
> the audio there are certain to be some xruns, for example whenever usin=
g
> the GUI controls in any way or moving the mouse.

xruns just should not happen. Ignoring them seems to be the very wrong
way. Also a real-time thread should not be necessary just to avoid xruns
when only moving the mouse IMHO.
Maybe you can just increase the buffer size somehow? At least for
MPlayer a big buffer should cause no problems.

Greetings,
Reimar D=F6ffinger

P.S.: I wont cc further mails about this to the list, because I don't thi=
nk this
belongs on alsa-devel.


-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
