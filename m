From: Lee Revell <rlrevell@joe-job.com>
Subject: Re: Re: Re: SB Live! PCM control
Date: Sat, 05 Feb 2005 18:20:08 -0500
Message-ID: <1107645609.7256.73.camel@krustophenia.net>
References: <420270C1.3000706@voicenet.com>
	 <1107457227.7256.37.camel@krustophenia.net>
	 <4202A72C.3000007@superbug.co.uk>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
In-Reply-To: <4202A72C.3000007@superbug.co.uk>
Sender: alsa-user-admin@lists.sourceforge.net
Errors-To: alsa-user-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-user>,
	<mailto:alsa-user-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-user@lists.sourceforge.net>
List-Help: <mailto:alsa-user-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-user>,
	<mailto:alsa-user-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-user>
To: James Courtier-Dutton <James@superbug.co.uk>
Cc: Adam K Kirchhoff <adamk@voicenet.com>, alsa-user@lists.sourceforge.net, alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Thu, 2005-02-03 at 22:35 +0000, James Courtier-Dutton wrote:
> I think it is unwise to implement a Master volume control for the SBLive 
> at this time. We had to remove it some time ago, and it can be 
> implemented in a better way that in the DSP code.
> 

Really?  This is certainly news to me.  Why did you remove it?  What's
this "better way" you speak of?  And what's wrong with doing it in the
DSP?

I wish you had said something sooner.  Users have been complaining
vociferously about this as long as I have been involved with ALSA (not
as long as some people, but long enough ;-).

Personally I never thought this was a big deal.  I don't use the Audigy
master volume anyway, I just adjust the volume inside the app.  It seems
broken to me for a program like mplayer to grab the master volume
control anyway.  Shouldn't it just attenuate the PCM samples it's
generating?

Lee



-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
